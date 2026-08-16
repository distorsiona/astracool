from pydantic import BaseModel


class AstraPlacement(BaseModel):
    planet: str
    sign: str
    degree: float
    house: int | None = None
    retrograde: bool = False


class AstraAspect(BaseModel):
    first: str
    second: str

    type: str

    orb: float
    diff: float


class AstraBigThree(BaseModel):
    sun: AstraPlacement
    moon: AstraPlacement
    rising: AstraPlacement


class AstraZodiacIdentity(BaseModel):
    sign: str

    element: str
    modality: str
    ruling_planet: str


class AstraProfileAnalysis(BaseModel):
    big_three: AstraBigThree

    zodiac: AstraZodiacIdentity

    planets: list[AstraPlacement]

    dominant_aspects: list[AstraAspect]