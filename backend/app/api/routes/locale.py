from typing import Optional

from fastapi import APIRouter

from app.services.translation_service import (
    SUPPORTED_LANGUAGES,
    check_health,
    normalize_language,
)


router = APIRouter(
    prefix="/locale",
    tags=["Locale"],
)


# ============================================================
# NORMALIZAR / VALIDAR IDIOMA
#
# GET /api/locale?lang=es
# ============================================================

@router.get("")
async def get_locale(
    lang: Optional[str] = None,
) -> dict:

    raw = (lang or "").strip().lower()

    return {
        "language": normalize_language(lang),
        "supported": raw in SUPPORTED_LANGUAGES,
    }


# ============================================================
# ESTADO DEL SERVICIO DE TRADUCCIÓN
#
# GET /api/locale/health
# ============================================================

@router.get("/health")
async def get_translation_health() -> dict:

    available = await check_health()

    return {
        "translation_service": "available" if available else "unavailable",
    }
