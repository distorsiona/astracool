from datetime import date

from pydantic import BaseModel, Field


class ProfileUpsertRequest(BaseModel):
    user_id: str

    display_name: str = Field(
        min_length=1,
        max_length=100,
    )

    birth_date: date

    birth_hour: int = Field(
        ge=0,
        le=23,
    )

    birth_minute: int = Field(
        ge=0,
        le=59,
    )

    birth_place: str = Field(
        min_length=2,
        max_length=200,
    )

    birth_lat: float = Field(
        ge=-90,
        le=90,
    )

    birth_lon: float = Field(
        ge=-180,
        le=180,
    )

    birth_timezone: float = Field(
        ge=-14,
        le=14,
    )