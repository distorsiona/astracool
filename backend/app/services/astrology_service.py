import httpx

from app.core.config import settings
from app.schemas.astrology import AstrologyBirthRequest


class AstrologyAPIError(Exception):
    pass


class AstrologyService:
    def __init__(self) -> None:
        self.base_url = settings.astrology_api_base_url
        self.api_key = settings.astrology_api_key

    # =========================================================
    # HEADERS
    # =========================================================

    def _headers(self) -> dict[str, str]:
        return {
            "x-astrologyapi-key": self.api_key,
            "Content-Type": "application/json",
        }

    # =========================================================
    # PAYLOAD BASE
    # =========================================================

    def _payload(
        self,
        data: AstrologyBirthRequest,
    ) -> dict:
        return {
            "day": data.day,
            "month": data.month,
            "year": data.year,
            "hour": data.hour,
            "min": data.minute,
            "lat": data.lat,
            "lon": data.lon,
            "tzone": data.timezone,
            "house_type": data.house_type,
            "is_asteroids": str(
                data.is_asteroids
            ).lower(),
        }

    # =========================================================
    # WESTERN HOROSCOPE
    # =========================================================

    async def western_horoscope(
        self,
        data: AstrologyBirthRequest,
    ) -> dict:

        return await self._post(
            endpoint="western_horoscope",
            payload=self._payload(data),
        )

    # =========================================================
    # WESTERN CHART DATA
    # =========================================================

    async def western_chart_data(
        self,
        data: AstrologyBirthRequest,
    ) -> dict:

        return await self._post(
            endpoint="western_chart_data",
            payload=self._payload(data),
        )

    # =========================================================
    # NATAL WHEEL
    # =========================================================

    async def natal_wheel_chart(
        self,
        data: AstrologyBirthRequest,
    ) -> dict:

        payload = self._payload(data)

        return await self._post(
            endpoint="natal_wheel_chart",
            payload=payload,
        )

    # =========================================================
    # HTTP
    # =========================================================

    async def _post(
        self,
        *,
        endpoint: str,
        payload: dict,
    ) -> dict:

        url = f"{self.base_url}/{endpoint}"

        try:
            async with httpx.AsyncClient(
                timeout=30.0,
            ) as client:

                response = await client.post(
                    url,
                    headers=self._headers(),
                    json=payload,
                )

            response.raise_for_status()

            return response.json()

        except httpx.HTTPStatusError as exc:

            raise AstrologyAPIError(
                f"AstrologyAPI error "
                f"{exc.response.status_code}: "
                f"{exc.response.text}"
            ) from exc

        except httpx.RequestError as exc:

            raise AstrologyAPIError(
                "No fue posible conectarse "
                "con AstrologyAPI."
            ) from exc

    # =========================================================
    # PARSER: BUSCAR PLANETA
    # =========================================================

    def find_planet(
        self,
        chart: dict,
        planet_name: str,
    ) -> dict | None:

        planets = chart.get(
            "planets",
            [],
        )

        for planet in planets:

            if (
                str(
                    planet.get(
                        "name",
                        "",
                    )
                ).lower()
                == planet_name.lower()
            ):
                return planet

        return None

    # =========================================================
    # PARSER: BIG THREE
    # =========================================================

    def extract_big_three(
        self,
        chart: dict,
    ) -> dict:

        sun = self.find_planet(
            chart,
            "Sun",
        )

        moon = self.find_planet(
            chart,
            "Moon",
        )

        # El ascendente corresponde a la cúspide
        # de la casa 1.
        rising = None

        houses = chart.get(
            "houses",
            [],
        )

        for house in houses:

            if house.get("house") == 1:
                rising = house
                break

        return {
            "sun": {
                "sign": (
                    sun.get("sign")
                    if sun
                    else None
                ),
                "degree": (
                    sun.get("norm_degree")
                    if sun
                    else None
                ),
                "house": (
                    sun.get("house")
                    if sun
                    else None
                ),
            },

            "moon": {
                "sign": (
                    moon.get("sign")
                    if moon
                    else None
                ),
                "degree": (
                    moon.get("norm_degree")
                    if moon
                    else None
                ),
                "house": (
                    moon.get("house")
                    if moon
                    else None
                ),
            },

            "rising": {
                "sign": (
                    rising.get("sign")
                    if rising
                    else None
                ),

                # AstrologyAPI entrega la cúspide
                # como grado absoluto 0-360.
                # Lo normalizamos al signo 0-30.
                "degree": (
                    rising.get("degree") % 30
                    if rising
                    else None
                ),
            },
        }

    # =========================================================
    # ATRIBUTOS DEL SIGNO SOLAR
    # =========================================================

    def get_sign_attributes(
        self,
        sign: str | None,
    ) -> dict:

        signs = {
            "aries": {
                "element": "Fire",
                "modality": "Cardinal",
                "ruling_planet": "Mars",
            },

            "taurus": {
                "element": "Earth",
                "modality": "Fixed",
                "ruling_planet": "Venus",
            },

            "gemini": {
                "element": "Air",
                "modality": "Mutable",
                "ruling_planet": "Mercury",
            },

            "cancer": {
                "element": "Water",
                "modality": "Cardinal",
                "ruling_planet": "Moon",
            },

            "leo": {
                "element": "Fire",
                "modality": "Fixed",
                "ruling_planet": "Sun",
            },

            "virgo": {
                "element": "Earth",
                "modality": "Mutable",
                "ruling_planet": "Mercury",
            },

            "libra": {
                "element": "Air",
                "modality": "Cardinal",
                "ruling_planet": "Venus",
            },

            "scorpio": {
                "element": "Water",
                "modality": "Fixed",
                "ruling_planet": "Pluto",
            },

            "sagittarius": {
                "element": "Fire",
                "modality": "Mutable",
                "ruling_planet": "Jupiter",
            },

            "capricorn": {
                "element": "Earth",
                "modality": "Cardinal",
                "ruling_planet": "Saturn",
            },

            "aquarius": {
                "element": "Air",
                "modality": "Fixed",
                "ruling_planet": "Uranus",
            },

            "pisces": {
                "element": "Water",
                "modality": "Mutable",
                "ruling_planet": "Neptune",
            },
        }

        if not sign:
            return {
                "element": None,
                "modality": None,
                "ruling_planet": None,
            }

        return signs.get(
            sign.lower(),
            {
                "element": None,
                "modality": None,
                "ruling_planet": None,
            },
        )

    # =========================================================
    # RESUMEN PARA FLUTTER
    # =========================================================

    def build_profile_summary(
        self,
        chart: dict,
    ) -> dict:

        big_three = self.extract_big_three(
            chart
        )

        attributes = (
            self.get_sign_attributes(
                big_three["sun"]["sign"]
            )
        )

        return {
            "big_three": big_three,
            "zodiac": attributes,
        }


astrology_service = AstrologyService()