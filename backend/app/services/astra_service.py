class AstraService:

    # =========================================================
    # PLANET
    # =========================================================

    def _planet(
        self,
        chart: dict,
        name: str,
    ) -> dict | None:

        for planet in chart.get("planets", []):

            if (
                str(planet.get("name", "")).lower()
                == name.lower()
            ):
                return planet

        return None

    # =========================================================
    # HOUSE
    # =========================================================

    def _house(
        self,
        chart: dict,
        number: int,
    ) -> dict | None:

        for house in chart.get("houses", []):

            if house.get("house") == number:
                return house

        return None

    # =========================================================
    # PLACEMENT
    # =========================================================

    def _placement(
        self,
        planet: dict,
    ) -> dict:

        return {
            "planet": planet["name"],
            "sign": planet["sign"],
            "degree": planet["norm_degree"],
            "house": planet.get("house"),
            "retrograde": (
                str(
                    planet.get(
                        "is_retro",
                        "false",
                    )
                ).lower()
                == "true"
            ),
        }

    # =========================================================
    # ASCENDANT
    # =========================================================

    def _rising(
        self,
        chart: dict,
    ) -> dict:

        house_one = self._house(
            chart,
            1,
        )

        if not house_one:
            raise ValueError(
                "No se encontró la casa 1."
            )

        absolute_degree = house_one["degree"]

        return {
            "planet": "Ascendant",
            "sign": house_one["sign"],
            "degree": absolute_degree % 30,
            "house": 1,
            "retrograde": False,
        }

    # =========================================================
    # BIG THREE
    # =========================================================

    def big_three(
        self,
        chart: dict,
    ) -> dict:

        sun = self._planet(
            chart,
            "Sun",
        )

        moon = self._planet(
            chart,
            "Moon",
        )

        if not sun or not moon:
            raise ValueError(
                "La carta no contiene Sol o Luna."
            )

        return {
            "sun": self._placement(sun),
            "moon": self._placement(moon),
            "rising": self._rising(chart),
        }

    # =========================================================
    # ZODIAC DATA
    # =========================================================

    def zodiac_attributes(
        self,
        sign: str,
    ) -> dict:

        data = {
            "Aries": (
                "Fire",
                "Cardinal",
                "Mars",
            ),
            "Taurus": (
                "Earth",
                "Fixed",
                "Venus",
            ),
            "Gemini": (
                "Air",
                "Mutable",
                "Mercury",
            ),
            "Cancer": (
                "Water",
                "Cardinal",
                "Moon",
            ),
            "Leo": (
                "Fire",
                "Fixed",
                "Sun",
            ),
            "Virgo": (
                "Earth",
                "Mutable",
                "Mercury",
            ),
            "Libra": (
                "Air",
                "Cardinal",
                "Venus",
            ),
            "Scorpio": (
                "Water",
                "Fixed",
                "Pluto",
            ),
            "Sagittarius": (
                "Fire",
                "Mutable",
                "Jupiter",
            ),
            "Capricorn": (
                "Earth",
                "Cardinal",
                "Saturn",
            ),
            "Aquarius": (
                "Air",
                "Fixed",
                "Uranus",
            ),
            "Pisces": (
                "Water",
                "Mutable",
                "Neptune",
            ),
        }

        element, modality, ruler = data[sign]

        return {
            "sign": sign,
            "element": element,
            "modality": modality,
            "ruling_planet": ruler,
        }

    # =========================================================
    # DOMINANT ASPECTS
    # =========================================================

    def dominant_aspects(
        self,
        chart: dict,
        max_orb: float = 3.0,
    ) -> list[dict]:

        aspects = []

        for aspect in chart.get(
            "aspects",
            [],
        ):

            orb = float(
                aspect.get(
                    "orb",
                    999,
                )
            )

            if orb <= max_orb:

                aspects.append({
                    "first":
                        aspect["aspecting_planet"],

                    "second":
                        aspect["aspected_planet"],

                    "type":
                        aspect["type"],

                    "orb":
                        orb,

                    "diff":
                        aspect["diff"],
                })

        aspects.sort(
            key=lambda item: item["orb"]
        )

        return aspects

    # =========================================================
    # COMPLETE ANALYSIS
    # =========================================================

    def analyze(
        self,
        chart: dict,
    ) -> dict:

        big_three = self.big_three(
            chart
        )

        zodiac = self.zodiac_attributes(
            big_three["sun"]["sign"]
        )

        planets = [
            self._placement(planet)
            for planet
            in chart.get(
                "planets",
                [],
            )
        ]

        return {
            "big_three": big_three,

            "zodiac": zodiac,

            "planets": planets,

            "dominant_aspects":
                self.dominant_aspects(
                    chart
                ),
        }


astra_service = AstraService()