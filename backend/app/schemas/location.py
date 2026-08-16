from pydantic import BaseModel


class LocationSearchResult(BaseModel):
    display_name: str
    lat: float
    lon: float


class ReverseLocationResponse(BaseModel):
    display_name: str
    lat: float
    lon: float