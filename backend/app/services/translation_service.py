import asyncio
import logging
from typing import Optional

import httpx

from app.core.config import settings


logger = logging.getLogger(__name__)


SUPPORTED_LANGUAGES = {"en", "es"}

# =========================================================
# caché en memoria
#
# key:
# (texto_original, idioma_origen, idioma_destino)
#
# evita volver a traducir textos que ya fueron traducidos
# durante la ejecución actual del backend
# =========================================================

_cache: dict[tuple[str, str, str], str] = {}


# =========================================================
# configuración de traducción
#
# el timeout evita que una traducción deje esperando
# indefinidamente al endpoint que la está utilizando
# =========================================================

_TIMEOUT = httpx.Timeout(
    connect=5.0,
    read=8.0,
    write=5.0,
    pool=5.0,
)

# máximo de traducciones simultáneas
#
# no conviene mandar decenas de requests a libretranslate
# al mismo tiempo porque puede saturarse o responder muy lento
_MAX_CONCURRENT_TRANSLATIONS = 4

_translation_semaphore = asyncio.Semaphore(
    _MAX_CONCURRENT_TRANSLATIONS
)


def normalize_language(lang: Optional[str]) -> str:
    """
    normaliza el idioma recibido.

    actualmente la aplicación trabaja con inglés y español.
    si llega un idioma no soportado, se usa inglés.
    """

    if not lang:
        return "en"

    normalized = lang.strip().lower()

    return (
        normalized
        if normalized in SUPPORTED_LANGUAGES
        else "en"
    )


async def _request_translation(
    text: str,
    source_language: str,
    target_language: str,
) -> Optional[str]:
    """
    manda un texto a libretranslate.

    si libretranslate falla, demora demasiado o responde algo
    inválido, devuelve none.

    translate_text se encarga después de usar el texto original
    como fallback.
    """

    if not settings.libretranslate_url:
        logger.debug(
            "translation_service: libretranslate_url no configurada."
        )
        return None

    url = (
        f"{settings.libretranslate_url.rstrip('/')}"
        "/translate"
    )

    payload = {
        "q": text,
        "source": source_language,
        "target": target_language,
        "format": "text",
    }

    if settings.libretranslate_api_key:
        payload["api_key"] = settings.libretranslate_api_key

    try:

        # limitar cuántas traducciones pueden ejecutarse
        # simultáneamente
        async with _translation_semaphore:

            async with httpx.AsyncClient(
                timeout=_TIMEOUT
            ) as client:

                response = await client.post(
                    url,
                    json=payload,
                )

                response.raise_for_status()

                data = response.json()

        translated = data.get("translatedText")

        if not isinstance(translated, str):
            raise ValueError(
                "Respuesta de LibreTranslate "
                "sin 'translatedText'."
            )

        translated = translated.strip()

        if not translated:
            return None

        return translated

    except httpx.TimeoutException as exc:

        logger.warning(
            "translation_service: timeout traduciendo "
            "'%s...' (%s). Se utilizará el texto original.",
            text[:60],
            exc,
        )

        return None

    except httpx.HTTPStatusError as exc:

        status_code = exc.response.status_code

        logger.warning(
            "translation_service: LibreTranslate respondió "
            "HTTP %s traduciendo '%s...'. "
            "Se utilizará el texto original.",
            status_code,
            text[:60],
        )

        return None

    except httpx.RequestError as exc:

        logger.warning(
            "translation_service: error de conexión "
            "con LibreTranslate traduciendo '%s...' (%s). "
            "Se utilizará el texto original.",
            text[:60],
            exc,
        )

        return None

    except Exception as exc:

        logger.exception(
            "translation_service: error inesperado "
            "traduciendo '%s...' (%s). "
            "Se utilizará el texto original.",
            text[:60],
            exc,
        )

        return None


async def translate_text(
    text: Optional[str],
    target_language: str,
    source_language: str = "en",
) -> Optional[str]:
    """
    traduce un texto individual.

    primero revisa la caché.
    si libretranslate falla, devuelve el texto original.
    """

    if text is None:
        return None

    if not text.strip():
        return text

    target_language = normalize_language(
        target_language
    )

    source_language = normalize_language(
        source_language
    )

    # si ambos idiomas son iguales no hay nada que traducir
    if target_language == source_language:
        return text

    cache_key = (
        text,
        source_language,
        target_language,
    )

    # devolver resultado guardado si ya existe
    cached_translation = _cache.get(cache_key)

    if cached_translation is not None:
        return cached_translation

    translated = await _request_translation(
        text=text,
        source_language=source_language,
        target_language=target_language,
    )

    # si la traducción falla, la aplicación sigue funcionando
    # utilizando el texto original
    if translated is None:
        return text

    # guardar traducción exitosa en caché
    _cache[cache_key] = translated

    return translated


async def translate_list(
    values: list[str],
    target_language: str,
    source_language: str = "en",
) -> list[str]:
    """
    traduce una lista de textos.

    elimina temporalmente los textos repetidos para evitar
    solicitudes innecesarias.

    las traducciones se hacen en paralelo, pero el semáforo
    limita cuántas pueden ejecutarse simultáneamente.
    """

    target_language = normalize_language(
        target_language
    )

    source_language = normalize_language(
        source_language
    )

    if not values:
        return []

    if target_language == source_language:
        return list(values)

    # obtener únicamente textos válidos y distintos
    unique_texts = list(
        dict.fromkeys(
            value
            for value in values
            if value and value.strip()
        )
    )

    if not unique_texts:
        return list(values)

    try:

        translated_values = await asyncio.gather(
            *(
                translate_text(
                    text=text,
                    target_language=target_language,
                    source_language=source_language,
                )
                for text in unique_texts
            ),
            return_exceptions=True,
        )

    except Exception as exc:

        # esta excepción no debería ocurrir normalmente porque
        # translate_text ya tiene fallback, pero evita que una
        # traducción rompa completamente /chart
        logger.exception(
            "translation_service: error general "
            "traduciendo lista (%s).",
            exc,
        )

        return list(values)

    translated_map: dict[str, str] = {}

    for original, translated in zip(
        unique_texts,
        translated_values,
    ):

        # si una tarea individual lanzó una excepción
        # simplemente usamos el texto original
        if isinstance(translated, BaseException):

            logger.warning(
                "translation_service: una traducción "
                "de la lista falló para '%s...'.",
                original[:60],
            )

            translated_map[original] = original

            continue

        if translated is None:
            translated_map[original] = original

            continue

        translated_map[original] = translated

    # reconstruir la lista manteniendo el orden original
    return [
        translated_map.get(value, value)
        for value in values
    ]


async def translate_optional_text(
    text: Optional[str],
    target_language: str,
    source_language: str = "en",
) -> Optional[str]:
    """
    helper para campos que pueden venir como none.
    """

    return await translate_text(
        text=text,
        target_language=target_language,
        source_language=source_language,
    )


async def check_health() -> bool:
    """
    comprueba si libretranslate está disponible.

    este método no debería bloquear la aplicación si
    libretranslate está caído.
    """

    if not settings.libretranslate_url:
        return False

    url = (
        f"{settings.libretranslate_url.rstrip('/')}"
        "/health"
    )

    try:

        timeout = httpx.Timeout(
            connect=2.0,
            read=3.0,
            write=2.0,
            pool=2.0,
        )

        async with httpx.AsyncClient(
            timeout=timeout
        ) as client:

            response = await client.get(url)

        return response.status_code == 200

    except Exception as exc:

        logger.warning(
            "translation_service: health check falló (%s).",
            exc,
        )

        return False


def clear_translation_cache() -> None:
    """
    limpia manualmente la caché de traducciones.

    puede ser útil durante desarrollo o testing.
    """

    _cache.clear()


def get_translation_cache_size() -> int:
    """
    devuelve cuántas traducciones hay actualmente
    almacenadas en caché.
    """

    return len(_cache)