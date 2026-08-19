from functools import lru_cache

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
    # SETTINGS
    # =========================================================

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        extra="ignore",
    )


@lru_cache
def get_settings() -> Settings:
    return Settings()


settings = get_settings()