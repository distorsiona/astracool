from pydantic import BaseModel, Field


class AstrologyBirthRequest(BaseModel):
    day: int = Field(ge=1, le=31)
    month: int = Field(ge=1, le=12)
    year: int = Field(ge=1900, le=2100)

    hour: int = Field(ge=0, le=23)
    minute: int = Field(ge=0, le=59)

    lat: float = Field(ge=-90, le=90)
    lon: float = Field(ge=-180, le=180)

    timezone: float = Field(
        ge=-14,
        le=14,
    )

    house_type: str = "placidus"
    is_asteroids: bool = False