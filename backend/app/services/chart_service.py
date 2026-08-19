from fastapi import HTTPException

from app.core.supabase import supabase


class ChartService:

    # =========================================================
    # información fija de las 12 casas
    #
    # esto no depende de la persona.
    # solamente nos sirve para saber qué representa cada casa
    # y poder mostrar un nombre y temas entendibles en el front.
    # =========================================================

    HOUSE_INFO = {
        1: {
            "title": "House of Self",
            "subtitle": (
                "Identity, appearance & "
                "first impressions"
            ),
            "themes": [
                "Identity",
                "Appearance",
                "First impressions",
            ],
        },

        2: {
            "title": "House of Values",
            "subtitle": (
                "Money, possessions & "
                "self-worth"
            ),
            "themes": [
                "Money",
                "Values",
                "Self-worth",
            ],
        },

        3: {
            "title": "House of Communication",
            "subtitle": (
                "Thinking, learning & "
                "communication"
            ),
            "themes": [
                "Communication",
                "Learning",
                "Thinking",
            ],
        },

        4: {
            "title": "House of Home",
            "subtitle": (
                "Roots, family & "
                "emotional foundations"
            ),
            "themes": [
                "Home",
                "Family",
                "Roots",
            ],
        },

        5: {
            "title": "House of Creativity",
            "subtitle": (
                "Expression, romance & "
                "pleasure"
            ),
            "themes": [
                "Creativity",
                "Romance",
                "Pleasure",
            ],
        },

        6: {
            "title": "House of Daily Life",
            "subtitle": (
                "Routine, work & "
                "well-being"
            ),
            "themes": [
                "Routine",
                "Work",
                "Well-being",
            ],
        },

        7: {
            "title": "House of Relationships",
            "subtitle": (
                "Partnerships, commitment & "
                "the other"
            ),
            "themes": [
                "Relationships",
                "Partnerships",
                "Commitment",
            ],
        },

        8: {
            "title": "House of Transformation",
            "subtitle": (
                "Intimacy, trust & "
                "shared resources"
            ),
            "themes": [
                "Intimacy",
                "Trust",
                "Transformation",
            ],
        },

        9: {
            "title": "House of Expansion",
            "subtitle": (
                "Beliefs, travel & "
                "higher learning"
            ),
            "themes": [
                "Beliefs",
                "Travel",
                "Higher learning",
            ],
        },

        10: {
            "title": "House of Career",
            "subtitle": (
                "Purpose, reputation & "
                "public life"
            ),
            "themes": [
                "Career",
                "Reputation",
                "Purpose",
            ],
        },

        11: {
            "title": "House of Community",
            "subtitle": (
                "Friendships, networks & "
                "future goals"
            ),
            "themes": [
                "Friendships",
                "Community",
                "Future goals",
            ],
        },

        12: {
            "title": "House of the Inner World",
            "subtitle": (
                "Subconscious, solitude & "
                "hidden emotions"
            ),
            "themes": [
                "Inner world",
                "Subconscious",
                "Solitude",
            ],
        },
    }

    # =========================================================
    # planeta que rige cada signo
    #
    # esto sirve porque cada casa comienza en un signo.
    # el planeta que rige ese signo pasa a ser también
    # el regente de esa casa.
    #
    # por ejemplo:
    # casa 1 en libra -> venus rige la casa 1
    # =========================================================

    SIGN_RULERS = {
        "aries": "Mars",
        "taurus": "Venus",
        "gemini": "Mercury",
        "cancer": "Moon",
        "leo": "Sun",
        "virgo": "Mercury",
        "libra": "Venus",
        "scorpio": "Pluto",
        "sagittarius": "Jupiter",
        "capricorn": "Saturn",
        "aquarius": "Uranus",
        "pisces": "Neptune",
    }

    # =========================================================
    # peso de cada planeta
    #
    # esto lo usamos solamente para calcular qué casas tienen
    # más importancia dentro de la carta de esa persona.
    #
    # sol y luna pesan más porque son puntos personales
    # muy importantes.
    # =========================================================

    PLANET_WEIGHTS = {
        "sun": 5.0,
        "moon": 5.0,
        "mercury": 3.0,
        "venus": 3.0,
        "mars": 3.0,
        "jupiter": 2.5,
        "saturn": 2.5,
        "uranus": 2.0,
        "neptune": 2.0,
        "pluto": 2.0,
        "node": 1.5,
        "north node": 1.5,
        "chiron": 1.5,
        "lilith": 1.0,
    }

    # =========================================================
    # obtener la carta completa de una persona
    # =========================================================

    def get_chart(
        self,
        user_id: str,
    ) -> dict:

        # =====================================================
        # buscar el perfil de la persona
        #
        # aquí obtenemos información básica que ya tenemos
        # guardada en profiles.
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

        # si no existe el perfil, no podemos seguir
        if not profile_response.data:
            raise HTTPException(
                status_code=404,
                detail="Perfil no encontrado.",
            )

        profile = profile_response.data[0]

        # =====================================================
        # buscar la carta natal más reciente de la persona
        #
        # chart_data contiene la información que vino desde
        # astrology api cuando se generó la carta.
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

        # si todavía no existe una carta para esta persona
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
        # normalizar planetas
        #
        # astrology api puede entregar algunos nombres distintos
        # dependiendo del formato guardado.
        #
        # aquí dejamos todos los planetas con una estructura
        # común para que el resto del backend no tenga que
        # preocuparse de esas diferencias.
        # =====================================================

        raw_planets = chart_data.get(
            "planets",
            [],
        )

        planets = []

        for planet in raw_planets:

            # nombre del planeta
            name = (
                planet.get("planet")
                or planet.get("name")
                or ""
            )

            # grado dentro del signo
            degree = (
                planet.get("degree")
                if planet.get("degree") is not None
                else planet.get(
                    "norm_degree",
                    0,
                )
            )

            # algunas cartas guardan retrograde
            # y otras guardan is_retro
            retrograde_raw = (
                planet.get("retrograde")
                if planet.get("retrograde") is not None
                else planet.get(
                    "is_retro",
                    False,
                )
            )

            # dejamos siempre retrograde como true o false
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
                        self._safe_house_number(
                            planet.get(
                                "house"
                            )
                        ),

                    "retrograde":
                        retrograde,

                    # grado completo dentro de los 360 grados
                    #
                    # este nos sirve para dibujar la rueda
                    "absolute_degree":
                        float(
                            planet.get(
                                "full_degree",
                                0,
                            )
                            or 0
                        ),

                    # velocidad del planeta
                    #
                    # por ahora no la usamos mucho en el front
                    # pero la conservamos porque viene de la api
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
        # normalizar casas
        #
        # astrology api puede entregar el grado absoluto.
        #
        # por ejemplo:
        # escorpio 217.09 grados
        #
        # eso dentro de escorpio corresponde a:
        # 7.09 grados
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

                    # dejamos solamente el grado dentro del signo
                    "degree":
                        absolute_degree
                        % 30,

                    # dejamos también el grado completo
                    # para poder dibujar la rueda
                    "absolute_degree":
                        absolute_degree,
                }
            )

        # =====================================================
        # normalizar aspectos
        #
        # los aspectos muestran cómo se relacionan dos planetas.
        #
        # por ejemplo:
        # sun trine moon
        # moon square mars
        # =====================================================

        raw_aspects = chart_data.get(
            "aspects",
            [],
        )

        aspects = []

        for aspect in raw_aspects:

            # primer planeta del aspecto
            first = (
                aspect.get("first")
                or aspect.get(
                    "aspecting_planet"
                )
                or ""
            )

            # segundo planeta del aspecto
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

                    # el orb indica qué tan exacto es el aspecto
                    #
                    # mientras menor sea, más fuerte suele ser
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
        # buscar aspectos dominantes
        #
        # si la carta ya los tiene guardados, usamos esos.
        #
        # si es una carta antigua y no los tiene,
        # consideramos dominantes los que tengan orb <= 3.
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

            # mientras menor sea el orb,
            # más exacto es el aspecto
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
        # big three
        #
        # sun + moon + rising
        #
        # si ya estaba guardado dentro de chart_data lo usamos.
        #
        # si no, lo armamos usando los planetas y el perfil.
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

            # buscamos el sol dentro de los planetas
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

            # buscamos la luna dentro de los planetas
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
                        "planet":
                            "Sun",

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

                        "house":
                            None,

                        "retrograde":
                            False,
                    },

                "moon":
                    moon
                    or {
                        "planet":
                            "Moon",

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

                        "house":
                            None,

                        "retrograde":
                            False,
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

                    # el ascendente corresponde a la casa 1
                    "house":
                        1,

                    "retrograde":
                        False,
                },
            }

        # =====================================================
        # lilith
        #
        # astrology api la guarda separada de los planetas,
        # así que aquí la dejamos en el mismo formato.
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
                    self._safe_house_number(
                        raw_lilith.get(
                            "house"
                        )
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
        # crear una lista de todos los objetos de la carta
        #
        # los planetas normales vienen en planets,
        # pero lilith viene aparte.
        #
        # para calcular qué casas son más importantes queremos
        # considerar ambas cosas.
        # =====================================================

        chart_objects = list(
            planets
        )

        if lilith is not None:
            chart_objects.append(
                lilith
            )

        # =====================================================
        # enriquecer las 12 casas
        #
        # aquí tomamos cada casa y le agregamos:
        #
        # - qué significa
        # - qué planeta la rige
        # - qué planetas están dentro
        # - dónde está su planeta regente
        # - qué tan activa es
        # =====================================================

        enriched_houses = (
            self._build_enriched_houses(
                houses=houses,
                chart_objects=chart_objects,
                planets=planets,
                aspects=aspects,
            )
        )

        # =====================================================
        # elegir las casas más importantes
        #
        # primero ordenamos por strength_score.
        #
        # después tomamos las primeras 4 para mostrar
        # en chart como "your most active houses".
        # =====================================================

        featured_houses = sorted(
            enriched_houses,
            key=lambda house:
                house[
                    "strength_score"
                ],
            reverse=True,
        )[:4]

        # =====================================================
        # respuesta que recibe flutter
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

                # aquí ahora mandamos las casas enriquecidas
                #
                # siguen teniendo house, sign y degree,
                # así que no rompe lo que ya tienes en flutter
                "houses":
                    enriched_houses,

                "aspects":
                    aspects,

                "dominant_aspects":
                    dominant_aspects,

                # estas son solamente las 4 casas
                # con mayor peso de esta persona
                "featured_houses":
                    featured_houses,

                # puntos importantes de la carta
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

                # información sobre cuándo fue creada
                # la carta natal
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

    # =========================================================
    # obtener solamente una casa de una carta
    #
    # esto se usará cuando desde flutter la persona toque
    # por ejemplo:
    #
    # house i
    # house viii
    # house xii
    #
    # y entre a la pantalla con toda la información de esa casa.
    # =========================================================

    def get_house_detail(
        self,
        user_id: str,
        chart_id: str,
        house_number: int,
    ) -> dict:

        # una carta solamente tiene casas del 1 al 12
        if (
            house_number < 1
            or house_number > 12
        ):
            raise HTTPException(
                status_code=400,
                detail=(
                    "El número de casa debe "
                    "estar entre 1 y 12."
                ),
            )

        # buscamos la carta específica que se pidió
        chart_response = (
            supabase
            .table("natal_charts")
            .select(
                "id,"
                "profile_id,"
                "chart_data,"
                "generated_at"
            )
            .eq(
                "id",
                chart_id,
            )
            .eq(
                "profile_id",
                user_id,
            )
            .limit(1)
            .execute()
        )

        # si chart_id no pertenece a ese usuario
        # o simplemente no existe
        if not chart_response.data:
            raise HTTPException(
                status_code=404,
                detail=(
                    "Carta natal no encontrada."
                ),
            )

        natal_chart = (
            chart_response.data[0]
        )

        chart_data = (
            natal_chart.get(
                "chart_data"
            )
            or {}
        )

        # =====================================================
        # volver a normalizar los planetas de esta carta
        #
        # este endpoint funciona por sí solo,
        # por eso no depende de haber llamado get_chart antes.
        # =====================================================

        raw_planets = chart_data.get(
            "planets",
            [],
        )

        planets = []

        for planet in raw_planets:

            name = (
                planet.get("planet")
                or planet.get("name")
                or ""
            )

            degree = (
                planet.get("degree")
                if planet.get(
                    "degree"
                ) is not None
                else planet.get(
                    "norm_degree",
                    0,
                )
            )

            retrograde_raw = (
                planet.get(
                    "retrograde"
                )
                if planet.get(
                    "retrograde"
                ) is not None
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
                    "planet":
                        name,

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
                        self._safe_house_number(
                            planet.get(
                                "house"
                            )
                        ),

                    "retrograde":
                        retrograde,

                    "absolute_degree":
                        float(
                            planet.get(
                                "full_degree",
                                0,
                            )
                            or 0
                        ),
                }
            )

        # =====================================================
        # normalizar nuevamente las casas
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

                    "degree":
                        absolute_degree
                        % 30,

                    "absolute_degree":
                        absolute_degree,
                }
            )

        # =====================================================
        # normalizar nuevamente los aspectos
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
                }
            )

        # =====================================================
        # obtener lilith si existe
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

                "house":
                    self._safe_house_number(
                        raw_lilith.get(
                            "house"
                        )
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

        # juntamos planetas y lilith para poder
        # saber qué objetos están dentro de cada casa
        chart_objects = list(
            planets
        )

        if lilith is not None:
            chart_objects.append(
                lilith
            )

        # construimos las 12 casas enriquecidas
        enriched_houses = (
            self._build_enriched_houses(
                houses=houses,
                chart_objects=chart_objects,
                planets=planets,
                aspects=aspects,
            )
        )

        # buscamos solamente la casa que pidió el front
        selected_house = next(
            (
                house
                for house in enriched_houses
                if (
                    house["house"]
                    == house_number
                )
            ),
            None,
        )

        # por si la api no hubiera entregado esa casa
        if selected_house is None:
            raise HTTPException(
                status_code=404,
                detail=(
                    "No se encontró información "
                    "para esta casa."
                ),
            )

        return {
            "user_id":
                user_id,

            "chart_id":
                chart_id,

            "house":
                selected_house,
        }

    # =========================================================
    # construir las casas con información adicional
    #
    # recibe las casas normales de astrology api
    # y les agrega toda la información que necesitamos
    # para las cards y para house detail.
    # =========================================================

    def _build_enriched_houses(
        self,
        houses: list,
        chart_objects: list,
        planets: list,
        aspects: list,
    ) -> list:

        enriched_houses = []

        for house in houses:

            house_number = (
                house["house"]
            )

            # información general de esta casa
            house_info = (
                self.HOUSE_INFO.get(
                    house_number,
                    {
                        "title":
                            (
                                f"House "
                                f"{house_number}"
                            ),

                        "subtitle":
                            "",

                        "themes":
                            [],
                    },
                )
            )

            house_sign = (
                house.get(
                    "sign",
                    "",
                )
            )

            # buscamos qué planeta rige
            # el signo que inicia esta casa
            ruler = (
                self.SIGN_RULERS.get(
                    house_sign
                    .strip()
                    .lower(),
                    "",
                )
            )

            # buscamos qué planetas u objetos
            # están físicamente dentro de esta casa
            house_objects = [
                obj
                for obj in chart_objects
                if (
                    self._safe_house_number(
                        obj.get(
                            "house"
                        )
                    )
                    == house_number
                )
            ]

            # buscamos dónde está ubicado
            # el planeta que rige esta casa
            ruler_placement = (
                self._find_planet(
                    planets=planets,
                    planet_name=ruler,
                )
            )

            # calculamos cuánto pesa esta casa
            strength_score = (
                self._calculate_house_strength(
                    house_number=
                        house_number,
                    house_objects=
                        house_objects,
                    aspects=
                        aspects,
                )
            )

            # convertimos el número a algo entendible
            #
            # por ejemplo:
            # 14 -> very high
            strength_label = (
                self._strength_label(
                    strength_score
                )
            )

            # buscamos aspectos donde participe
            # algún planeta ubicado dentro de esta casa
            house_aspects = (
                self._find_house_aspects(
                    house_objects=
                        house_objects,
                    aspects=
                        aspects,
                )
            )

            supportive_influences = [
                aspect
                for aspect
                in house_aspects
                if (
                    aspect[
                        "nature"
                    ]
                    == "supportive"
                )
            ]

            challenging_influences = [
                aspect
                for aspect
                in house_aspects
                if (
                    aspect[
                        "nature"
                    ]
                    == "challenging"
                )
            ]

            enriched_houses.append(
                {
                    # mantenemos house porque así ya viene
                    # desde tu api y no rompe chart screen
                    "house":
                        house_number,

                    # agregamos number porque el nuevo
                    # modelo flutter también lo puede usar
                    "number":
                        house_number,

                    "sign":
                        house_sign,

                    "degree":
                        house.get(
                            "degree",
                            0,
                        ),

                    "absolute_degree":
                        house.get(
                            "absolute_degree",
                            0,
                        ),

                    "title":
                        house_info[
                            "title"
                        ],

                    "subtitle":
                        house_info[
                            "subtitle"
                        ],

                    "themes":
                        house_info[
                            "themes"
                        ],

                    "ruler":
                        ruler,

                    # acá van los objetos reales
                    # que existen en esta casa
                    "planets":
                        house_objects,

                    # acá va dónde está el regente
                    # de esta casa
                    "ruler_placement":
                        ruler_placement,

                    # número usado internamente
                    # para ordenar las casas
                    "strength_score":
                        strength_score,

                    # texto que verá el usuario
                    "strength_label":
                        strength_label,

                    "supportive_influences":
                        supportive_influences,

                    "challenging_influences":
                        challenging_influences,

                    # estas interpretaciones todavía
                    # las dejamos vacías.
                    #
                    # después podemos nutrirlas con
                    # interpretación astrológica real
                    # sin mezclarlo ahora con el cálculo.
                    "meaning":
                        "",

                    "interpretation":
                        "",
                }
            )

        return enriched_houses

    # =========================================================
    # calcular qué tan importante es una casa
    #
    # esto no intenta decir si una casa es buena o mala.
    #
    # solamente mide cuánta energía de la carta
    # está concentrada ahí.
    # =========================================================

    def _calculate_house_strength(
        self,
        house_number: int,
        house_objects: list,
        aspects: list,
    ) -> float:

        score = 0.0

        # sumamos el peso de cada planeta
        # que está dentro de esta casa
        for obj in house_objects:

            planet_name = (
                obj.get(
                    "planet",
                    "",
                )
                .strip()
                .lower()
            )

            score += (
                self.PLANET_WEIGHTS.get(
                    planet_name,
                    1.0,
                )
            )

        # las casas angulares son especialmente importantes
        #
        # 1  -> ascendente
        # 4  -> fondo del cielo
        # 7  -> descendente
        # 10 -> medio cielo
        if house_number in {
            1,
            4,
            7,
            10,
        }:
            score += 2.0

        # casa 1 recibe un poco más
        # porque está directamente conectada al ascendente
        if house_number == 1:
            score += 2.0

        # casa 10 recibe un poco más
        # porque está conectada al medio cielo
        if house_number == 10:
            score += 2.0

        # si hay varios planetas juntos
        # aumentamos el peso de esa casa
        amount_objects = len(
            house_objects
        )

        if amount_objects >= 3:
            score += 4.0

        elif amount_objects == 2:
            score += 2.0

        # también consideramos aspectos muy exactos
        # de los planetas que viven en esta casa
        object_names = {
            obj.get(
                "planet",
                "",
            )
            .strip()
            .lower()
            for obj
            in house_objects
        }

        for aspect in aspects:

            first = (
                aspect.get(
                    "first",
                    "",
                )
                .strip()
                .lower()
            )

            second = (
                aspect.get(
                    "second",
                    "",
                )
                .strip()
                .lower()
            )

            orb = float(
                aspect.get(
                    "orb",
                    0,
                )
                or 0
            )

            # solamente sumamos si el aspecto
            # toca algo de esta casa
            touches_house = (
                first in object_names
                or second in object_names
            )

            if not touches_house:
                continue

            # aspecto casi exacto
            if orb <= 1.0:
                score += 1.5

            # aspecto bastante fuerte
            elif orb <= 3.0:
                score += 0.75

        return round(
            score,
            2,
        )

    # =========================================================
    # transformar el score en una etiqueta
    #
    # esto es lo que finalmente verá flutter.
    # =========================================================

    def _strength_label(
        self,
        score: float,
    ) -> str:

        if score >= 12:
            return "VERY HIGH"

        if score >= 8:
            return "HIGH"

        if score >= 4:
            return "MEDIUM"

        return "LOW"

    # =========================================================
    # buscar un planeta específico
    #
    # lo usamos para saber dónde está el regente
    # de una casa.
    #
    # ejemplo:
    #
    # casa 1 en libra
    # libra -> venus
    #
    # acá buscamos dónde está venus.
    # =========================================================

    def _find_planet(
        self,
        planets: list,
        planet_name: str,
    ):

        if not planet_name:
            return None

        for planet in planets:

            if (
                planet.get(
                    "planet",
                    "",
                )
                .strip()
                .lower()
                ==
                planet_name
                .strip()
                .lower()
            ):
                return planet

        return None

    # =========================================================
    # buscar aspectos relacionados con una casa
    #
    # si un planeta está dentro de una casa,
    # buscamos todos los aspectos que tocan ese planeta.
    # =========================================================

    def _find_house_aspects(
        self,
        house_objects: list,
        aspects: list,
    ) -> list:

        object_names = {
            obj.get(
                "planet",
                "",
            )
            .strip()
            .lower()
            for obj
            in house_objects
        }

        result = []

        for aspect in aspects:

            first = (
                aspect.get(
                    "first",
                    "",
                )
                .strip()
                .lower()
            )

            second = (
                aspect.get(
                    "second",
                    "",
                )
                .strip()
                .lower()
            )

            if (
                first not in object_names
                and second not in object_names
            ):
                continue

            aspect_type = (
                aspect.get(
                    "type",
                    "",
                )
                .strip()
                .lower()
            )

            # trigono y sextil normalmente se consideran
            # influencias más fluidas
            if aspect_type in {
                "trine",
                "sextile",
            }:
                nature = (
                    "supportive"
                )

            # cuadratura y oposición normalmente
            # muestran más tensión
            elif aspect_type in {
                "square",
                "opposition",
            }:
                nature = (
                    "challenging"
                )

            # una conjunción depende mucho de los planetas
            # involucrados, así que no la marcamos
            # automáticamente como buena o mala
            else:
                nature = (
                    "neutral"
                )

            orb = float(
                aspect.get(
                    "orb",
                    0,
                )
                or 0
            )

            result.append(
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
                        orb,

                    "nature":
                        nature,

                    "strength":
                        self._aspect_strength(
                            orb
                        ),

                    # la interpretación todavía
                    # la dejamos para la siguiente parte
                    "interpretation":
                        "",
                }
            )

        # primero mostramos los aspectos
        # que tienen menor orb
        result.sort(
            key=lambda item:
                item["orb"]
        )

        return result

    # =========================================================
    # decir qué tan exacto es un aspecto
    #
    # mientras menor sea el orb, más exacto es.
    # =========================================================

    def _aspect_strength(
        self,
        orb: float,
    ) -> str:

        if orb <= 1.0:
            return "VERY STRONG"

        if orb <= 3.0:
            return "STRONG"

        if orb <= 5.0:
            return "MODERATE"

        return "WIDE"

    # =========================================================
    # convertir house a un número válido
    #
    # a veces la api puede mandar el número como int,
    # como float o como texto.
    #
    # aquí lo dejamos siempre como int.
    # =========================================================

    def _safe_house_number(
        self,
        value,
    ):

        if value is None:
            return None

        try:
            house_number = int(
                float(value)
            )

            if (
                house_number < 1
                or house_number > 12
            ):
                return None

            return house_number

        except (
            TypeError,
            ValueError,
        ):
            return None


chart_service = ChartService()