from fastapi import HTTPException

from app.core.supabase import supabase


class ChartService:

    # =========================================================
    # GET CHART
    # =========================================================

    def get_chart(
        self,
        user_id: str,
    ) -> dict:

        # =====================================================
        # 1. PERFIL
        # =====================================================

        profile_response = (
            supabase
            .table("profiles")
            .select(
                "id,"
                "display_name,"
                "username,"
                "sun_sign,"
                "sun_degree,"
                "moon_sign,"
                "moon_degree,"
                "rising_sign,"
                "rising_degree,"
                "element,"
                "modality,"
                "ruling_planet"
            )
            .eq(
                "id",
                user_id,
            )
            .limit(1)
            .execute()
        )

        if not profile_response.data:
            raise HTTPException(
                status_code=404,
                detail="Perfil no encontrado.",
            )

        profile = profile_response.data[0]

        # =====================================================
        # 2. NATAL CHART
        # =====================================================

        chart_response = (
            supabase
            .table("natal_charts")
            .select(
                "id,"
                "profile_id,"
                "chart_data,"
                "wheel_url,"
                "generated_at,"
                "updated_at"
            )
            .eq(
                "profile_id",
                user_id,
            )
            .order(
                "generated_at",
                desc=True,
            )
            .limit(1)
            .execute()
        )

        if not chart_response.data:
            raise HTTPException(
                status_code=404,
                detail=(
                    "El usuario todavía no tiene "
                    "una carta natal generada."
                ),
            )

        natal_chart = chart_response.data[0]

        chart_data = (
            natal_chart.get("chart_data")
            or {}
        )

        # =====================================================
        # 3. NORMALIZAR PLANETAS
        # =====================================================

        raw_planets = chart_data.get(
            "planets",
            [],
        )

        planets = []

        for planet in raw_planets:

            # Soportamos tanto el formato RAW de AstrologyAPI
            # como nuestro formato procesado por AstraService.

            name = (
                planet.get("planet")
                or planet.get("name")
                or ""
            )

            degree = (
                planet.get("degree")
                if planet.get("degree") is not None
                else planet.get(
                    "norm_degree",
                    0,
                )
            )

            retrograde_raw = (
                planet.get("retrograde")
                if planet.get("retrograde") is not None
                else planet.get(
                    "is_retro",
                    False,
                )
            )

            retrograde = (
                retrograde_raw
                if isinstance(
                    retrograde_raw,
                    bool,
                )
                else str(
                    retrograde_raw
                ).lower() == "true"
            )

            planets.append(
                {
                    "planet": name,

                    "sign":
                        planet.get(
                            "sign",
                            "",
                        ),

                    "degree":
                        float(
                            degree or 0
                        ),

                    "house":
                        planet.get(
                            "house"
                        ),

                    "retrograde":
                        retrograde,

                    # Información adicional útil
                    # para la rueda.
                    "absolute_degree":
                        float(
                            planet.get(
                                "full_degree",
                                0,
                            )
                            or 0
                        ),

                    "speed":
                        float(
                            planet.get(
                                "speed",
                                0,
                            )
                            or 0
                        ),
                }
            )

        # =====================================================
        # 4. NORMALIZAR CASAS
        # =====================================================

        raw_houses = chart_data.get(
            "houses",
            [],
        )

        houses = []

        for house in raw_houses:

            absolute_degree = float(
                house.get(
                    "degree",
                    0,
                )
                or 0
            )

            houses.append(
                {
                    "house":
                        int(
                            house.get(
                                "house",
                                0,
                            )
                            or 0
                        ),

                    "sign":
                        house.get(
                            "sign",
                            "",
                        ),

                    # Ej:
                    # Scorpio 217.09°
                    # →
                    # Scorpio 7.09°
                    "degree":
                        absolute_degree
                        % 30,

                    # Conservamos el valor absoluto
                    # para dibujar correctamente la rueda.
                    "absolute_degree":
                        absolute_degree,
                }
            )

        # =====================================================
        # 5. NORMALIZAR ASPECTOS
        # =====================================================

        raw_aspects = chart_data.get(
            "aspects",
            [],
        )

        aspects = []

        for aspect in raw_aspects:

            first = (
                aspect.get("first")
                or aspect.get(
                    "aspecting_planet"
                )
                or ""
            )

            second = (
                aspect.get("second")
                or aspect.get(
                    "aspected_planet"
                )
                or ""
            )

            aspects.append(
                {
                    "first":
                        first,

                    "second":
                        second,

                    "type":
                        aspect.get(
                            "type",
                            "",
                        ),

                    "orb":
                        float(
                            aspect.get(
                                "orb",
                                0,
                            )
                            or 0
                        ),

                    "diff":
                        float(
                            aspect.get(
                                "diff",
                                0,
                            )
                            or 0
                        ),

                    "aspect_type":
                        aspect.get(
                            "aspect_type"
                        ),
                }
            )

        # =====================================================
        # 6. DOMINANT ASPECTS
        # =====================================================

        raw_dominant_aspects = (
            chart_data.get(
                "dominant_aspects",
                [],
            )
        )

        dominant_aspects = []

        if raw_dominant_aspects:

            for aspect in raw_dominant_aspects:

                dominant_aspects.append(
                    {
                        "first":
                            aspect.get(
                                "first",
                                "",
                            ),

                        "second":
                            aspect.get(
                                "second",
                                "",
                            ),

                        "type":
                            aspect.get(
                                "type",
                                "",
                            ),

                        "orb":
                            float(
                                aspect.get(
                                    "orb",
                                    0,
                                )
                                or 0
                            ),

                        "diff":
                            float(
                                aspect.get(
                                    "diff",
                                    0,
                                )
                                or 0
                            ),
                    }
                )

        else:
            # Si una carta antigua no guardó
            # dominant_aspects, los calculamos
            # usando orb <= 3°.

            dominant_aspects = [
                aspect
                for aspect in aspects
                if aspect["orb"] <= 3.0
            ]

            dominant_aspects.sort(
                key=lambda item:
                    item["orb"]
            )

        # =====================================================
        # 7. BIG THREE
        # =====================================================

        stored_big_three = (
            chart_data.get(
                "big_three"
            )
            or {}
        )

        if stored_big_three:

            big_three = stored_big_three

        else:

            sun = next(
                (
                    planet
                    for planet in planets
                    if (
                        planet["planet"]
                        .lower()
                        == "sun"
                    )
                ),
                None,
            )

            moon = next(
                (
                    planet
                    for planet in planets
                    if (
                        planet["planet"]
                        .lower()
                        == "moon"
                    )
                ),
                None,
            )

            big_three = {
                "sun":
                    sun
                    or {
                        "planet": "Sun",
                        "sign":
                            profile.get(
                                "sun_sign",
                                "",
                            ),
                        "degree":
                            float(
                                profile.get(
                                    "sun_degree",
                                    0,
                                )
                                or 0
                            ),
                        "house": None,
                        "retrograde": False,
                    },

                "moon":
                    moon
                    or {
                        "planet": "Moon",
                        "sign":
                            profile.get(
                                "moon_sign",
                                "",
                            ),
                        "degree":
                            float(
                                profile.get(
                                    "moon_degree",
                                    0,
                                )
                                or 0
                            ),
                        "house": None,
                        "retrograde": False,
                    },

                "rising": {
                    "planet":
                        "Ascendant",

                    "sign":
                        profile.get(
                            "rising_sign",
                            "",
                        ),

                    "degree":
                        float(
                            profile.get(
                                "rising_degree",
                                0,
                            )
                            or 0
                        ),

                    "house":
                        1,

                    "retrograde":
                        False,
                },
            }

        # =====================================================
        # 8. LILITH
        # =====================================================

        raw_lilith = chart_data.get(
            "lilith"
        )

        lilith = None

        if isinstance(
            raw_lilith,
            dict,
        ):
            lilith = {
                "planet":
                    raw_lilith.get(
                        "name",
                        "Lilith",
                    ),

                "sign":
                    raw_lilith.get(
                        "sign",
                        "",
                    ),

                "degree":
                    float(
                        raw_lilith.get(
                            "norm_degree",
                            0,
                        )
                        or 0
                    ),

                "absolute_degree":
                    float(
                        raw_lilith.get(
                            "full_degree",
                            0,
                        )
                        or 0
                    ),

                "house":
                    raw_lilith.get(
                        "house"
                    ),

                "retrograde":
                    str(
                        raw_lilith.get(
                            "is_retro",
                            "false",
                        )
                    ).lower()
                    == "true",
            }

        # =====================================================
        # 9. RESPUESTA
        # =====================================================

        return {
            "profile": {
                "id":
                    profile["id"],

                "display_name":
                    profile.get(
                        "display_name",
                        "",
                    ),

                "username":
                    profile.get(
                        "username",
                        "",
                    ),

                "sign":
                    profile.get(
                        "sun_sign",
                        "",
                    ),

                "element":
                    profile.get(
                        "element",
                        "",
                    ),

                "modality":
                    profile.get(
                        "modality",
                        "",
                    ),

                "ruling_planet":
                    profile.get(
                        "ruling_planet",
                        "",
                    ),
            },

            "chart": {
                "id":
                    natal_chart["id"],

                "big_three":
                    big_three,

                "planets":
                    planets,

                "houses":
                    houses,

                "aspects":
                    aspects,

                "dominant_aspects":
                    dominant_aspects,

                # ---------------------------------------------
                # PUNTOS IMPORTANTES
                # ---------------------------------------------

                "ascendant":
                    chart_data.get(
                        "ascendant"
                    ),

                "midheaven":
                    chart_data.get(
                        "midheaven"
                    ),

                "vertex":
                    chart_data.get(
                        "vertex"
                    ),

                "lilith":
                    lilith,

                # ---------------------------------------------
                # METADATA
                # ---------------------------------------------

                "wheel_url":
                    natal_chart.get(
                        "wheel_url"
                    ),

                "generated_at":
                    natal_chart.get(
                        "generated_at"
                    ),

                "updated_at":
                    natal_chart.get(
                        "updated_at"
                    ),
            },
        }


chart_service = ChartService()