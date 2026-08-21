from functools import lru_cache
from typing import Optional

from pydantic_settings import (
    BaseSettings,
    SettingsConfigDict,
)


class Settings(BaseSettings):
    # =========================================================
    # APP
    # =========================================================

    app_name: str = "Astra API"
    app_env: str = "development"

    # =========================================================
    # SUPABASE
    # =========================================================

    supabase_url: str

    # Cliente público/Auth normal.
    supabase_anon_key: str

    # Cliente privilegiado exclusivo del backend.
    supabase_service_role_key: str

    # =========================================================
    # ASTROLOGY API
    # =========================================================

    astrology_api_key: str

    astrology_api_base_url: str = (
        "https://json.astrologyapi.com/v1"
    )

    # =========================================================
    # LIBRETRANSLATE
    #
    # Si LIBRETRANSLATE_URL no está configurada, translation_service
    # queda deshabilitado automáticamente y el backend sigue
    # funcionando devolviendo siempre el texto original en inglés.
    # =========================================================

    libretranslate_url: Optional[str] = "http://127.0.0.1:5000"

    # Vacío/None para instancias self-hosted sin API key.
    libretranslate_api_key: Optional[str] = None

    libretranslate_source_language: str = "en"

    # =========================================================
    # SETTINGS
    # =========================================================

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        extra="ignore",
    )

    # =========================================================
    # BREVO
    # =========================================================

    brevo_api_key: str = ""
    brevo_sender_email: str = ""
    brevo_sender_name: str = "Sacred"

    frontend_verify_email_url: str = (
        "http://127.0.0.1:8080/verify-email"
    )

    frontend_reset_password_url: str = (
        "http://127.0.0.1:8080/reset-password"
    )


@lru_cache
def get_settings() -> Settings:
    return Settings()


settings = get_settings()