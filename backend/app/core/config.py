from functools import lru_cache

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    app_name: str = "Astra API"
    app_env: str = "development"

    # Supabase
    supabase_url: str
    supabase_service_role_key: str

    # AstrologyAPI
    astrology_api_key: str
    astrology_api_base_url: str = "https://json.astrologyapi.com/v1"

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        extra="ignore",
    )


@lru_cache
def get_settings() -> Settings:
    return Settings()


settings = get_settings()