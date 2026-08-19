from datetime import date, datetime

import httpx

from app.core.config import settings
from app.core.supabase import supabase


class TodayService:
    # ============================================================
    # ENDPOINTS
    # ============================================================

    NATAL_TRANSITS_ENDPOINT = (
        "/natal_transits/daily"
    )

    TROPICAL_TRANSITS_ENDPOINT = (
        "/tropical_transits/daily"
    )

    # ============================================================
    # HOUSE INFORMATION
    # ============================================================

    HOUSE_DATA = {
        1: {
            "title": "House I",
            "subtitle": "Self & identity",
            "description":
                "Identity, appearance, beginnings "
                "and the way you approach life.",
        },
        2: {
            "title": "House II",
            "subtitle": "Values & resources",
            "description":
                "Money, resources, possessions "
                "and personal values.",
        },
        3: {
            "title": "House III",
            "subtitle": "Communication",
            "description":
                "Communication, learning, ideas "
                "and your immediate environment.",
        },
        4: {
            "title": "House IV",
            "subtitle": "Home & roots",
            "description":
                "Home, family, roots and your "
                "private emotional foundation.",
        },
        5: {
            "title": "House V",
            "subtitle": "Creativity & pleasure",
            "description":
                "Creativity, romance, pleasure "
                "and personal expression.",
        },
        6: {
            "title": "House VI",
            "subtitle": "Routine & wellbeing",
            "description":
                "Daily routines, work, health "
                "and practical responsibilities.",
        },
        7: {
            "title": "House VII",
            "subtitle": "Relationships",
            "description":
                "Partnerships, relationships "
                "and important one-to-one bonds.",
        },
        8: {
            "title": "House VIII",
            "subtitle": "Transformation",
            "description":
                "Intimacy, transformation, shared "
                "resources and deep emotional change.",
        },
        9: {
            "title": "House IX",
            "subtitle": "Beliefs & exploration",
            "description":
                "Beliefs, higher learning, travel "
                "and expansion of perspective.",
        },
        10: {
            "title": "House X",
            "subtitle": "Career & direction",
            "description":
                "Career, reputation, ambition "
                "and your public direction.",
        },
        11: {
            "title": "House XI",
            "subtitle": "Friends & community",
            "description":
                "Friendships, communities, future "
                "plans and collective goals.",
        },
        12: {
            "title": "House XII",
            "subtitle": "Inner world",
            "description":
                "Rest, intuition, subconscious "
                "patterns and your private inner world.",
        },
    }

    # ============================================================
    # PUBLIC
    # ============================================================

    async def get_today(
        self,
        user_id: str,
    ) -> dict:

        # ========================================================
        # 1. PROFILE
        # ========================================================

        profile_response = (
            supabase
            .table("profiles")
            .select(
                "id,"
                "display_name,"
                "birth_date,"
                "birth_hour,"
                "birth_minute,"
                "birth_lat,"
                "birth_lon,"
                "birth_timezone,"
                "sun_sign,"
                "moon_sign,"
                "rising_sign"
            )
            .eq(
                "id",
                user_id,
            )
            .limit(1)
            .execute()
        )

        if not profile_response.data:
            raise ValueError(
                "Perfil no encontrado."
            )

        profile = (
            profile_response.data[0]
        )

        # ========================================================
        # 2. VALIDATE NATAL DATA
        # ========================================================

        birth_date_raw = (
            profile.get(
                "birth_date"
            )
        )

        birth_hour = (
            profile.get(
                "birth_hour"
            )
        )

        birth_minute = (
            profile.get(
                "birth_minute"
            )
        )

        birth_lat = (
            profile.get(
                "birth_lat"
            )
        )

        birth_lon = (
            profile.get(
                "birth_lon"
            )
        )

        birth_timezone = (
            profile.get(
                "birth_timezone"
            )
        )

        required = {
            "birth_date":
                birth_date_raw,

            "birth_hour":
                birth_hour,

            "birth_minute":
                birth_minute,

            "birth_lat":
                birth_lat,

            "birth_lon":
                birth_lon,

            "birth_timezone":
                birth_timezone,
        }

        missing = [
            key
            for key, value
            in required.items()
            if value is None
        ]

        if missing:
            raise RuntimeError(
                "El perfil no tiene todos "
                "los datos necesarios para "
                "calcular los tránsitos: "
                + ", ".join(missing)
            )

        # ========================================================
        # 3. PARSE BIRTH DATE
        # ========================================================

        birth_date = (
            datetime.strptime(
                str(birth_date_raw),
                "%Y-%m-%d",
            )
        )

        astrology_body = {
            "day":
                birth_date.day,

            "month":
                birth_date.month,

            "year":
                birth_date.year,

            "hour":
                int(birth_hour),

            "min":
                int(birth_minute),

            "lat":
                float(birth_lat),

            "lon":
                float(birth_lon),

            "tzone":
                float(birth_timezone),

            "house_type":
                "placidus",
        }

        # ========================================================
        # 4. ASTROLOGY API
        # ========================================================

        natal_transits = (
            await self._post_astrology(
                self.NATAL_TRANSITS_ENDPOINT,
                astrology_body,
            )
        )

        tropical_transits = (
            await self._post_astrology(
                self.TROPICAL_TRANSITS_ENDPOINT,
                astrology_body,
            )
        )

        # ========================================================
        # 5. DETERMINE TODAY DATE
        # ========================================================

        transit_date_raw = (
            natal_transits.get(
                "transit_date"
            )
            or tropical_transits.get(
                "transit_date"
            )
        )

        today_date = (
            self._resolve_date(
                transit_date_raw
            )
        )

        date_display = (
            today_date.strftime(
                "%d %B %Y"
            )
        )

        # ========================================================
        # 6. TODAY MOON
        # ========================================================

        today_moon_sign = (
            self._extract_today_moon_sign(
                natal_transits=
                    natal_transits,
                tropical_transits=
                    tropical_transits,
            )
        )

        # ========================================================
        # 7. TRANSITS
        # ========================================================

        transits = (
            self._build_transits(
                natal_transits=
                    natal_transits,
                today_date=
                    today_date,
            )
        )

        # ========================================================
        # 8. AFFECTED HOUSES
        # ========================================================

        affected_houses = (
            self._build_affected_houses(
                natal_transits
            )
        )

        # ========================================================
        # 9. THEMES
        # ========================================================

        themes = (
            self._build_themes(
                transits
            )
        )

        # ========================================================
        # 10. INTERPRETATION
        # ========================================================

        interpretation = (
            self._build_interpretation(
                transits=
                    transits,
                moon_sign=
                    today_moon_sign,
                affected_houses=
                    affected_houses,
            )
        )

        # ========================================================
        # 11. FOCUS
        # ========================================================

        focus = (
            self._build_focus(
                transits
            )
        )

        # ========================================================
        # 12. RESPONSE
        # ========================================================

        return {
            "date":
                date_display,

            # ==================================================
            # SKY TODAY
            # ==================================================

            "today_moon_sign":
                today_moon_sign,

            # Mantener compatibilidad con Flutter actual.
            "moon_sign":
                today_moon_sign,

            "moon_subtitle":
                self._moon_subtitle(
                    today_moon_sign
                ),

            # ==================================================
            # NATAL
            # ==================================================

            "big_three": {
                "sun":
                    profile.get(
                        "sun_sign",
                        "",
                    ),

                "moon":
                    profile.get(
                        "moon_sign",
                        "",
                    ),

                "rising":
                    profile.get(
                        "rising_sign",
                        "",
                    ),
            },

            # ==================================================
            # DAILY ANALYSIS
            # ==================================================

            "interpretation":
                interpretation,

            "quote":
                self._build_quote(
                    today_moon_sign
                ),

            "transits":
                transits,

            "affected_houses":
                affected_houses,

            "themes":
                themes,

            "focus":
                focus,

            # ==================================================
            # ASTRA DERIVED DATA
            # ==================================================

            "lucky_time":
                self._lucky_time(
                    transits=
                        transits,
                    today_date=
                        today_date,
                ),

            "lucky_color":
                self._lucky_color(
                    today_moon_sign
                ),
        }

    # ============================================================
    # ASTROLOGY API REQUEST
    # ============================================================

    async def _post_astrology(
        self,
        endpoint: str,
        body: dict,
    ) -> dict:

        url = (
            f"{settings.astrology_api_base_url}"
            f"{endpoint}"
        )

        headers = {
            "Accept":
                "application/json",

            "Content-Type":
                "application/json",

            "Accept-Language":
                "en",

            "x-astrologyapi-key":
                settings.astrology_api_key,
        }

        print()
        print(
            "========================================"
        )
        print(
            "ASTROLOGY TODAY REQUEST"
        )
        print(
            "ENDPOINT:",
            endpoint,
        )
        print(
            "URL:",
            url,
        )
        print(
            "BODY:",
            body,
        )
        print(
            "========================================"
        )

        async with httpx.AsyncClient(
            timeout=30.0,
        ) as client:

            response = await client.post(
                url,
                json=body,
                headers=headers,
            )

        print(
            "ASTROLOGY STATUS:",
            response.status_code,
        )

        if (
            response.status_code < 200
            or response.status_code >= 300
        ):
            print(
                "ASTROLOGY ERROR BODY:",
                response.text,
            )

            raise RuntimeError(
                "AstrologyAPI rechazó la "
                f"solicitud "
                f"({response.status_code}): "
                f"{response.text}"
            )

        try:
            data = response.json()

        except Exception as exc:
            raise RuntimeError(
                "AstrologyAPI devolvió "
                "una respuesta que no es JSON."
            ) from exc

        if not isinstance(
            data,
            dict,
        ):
            raise RuntimeError(
                "AstrologyAPI devolvió "
                "una respuesta inválida."
            )

        return data

    # ============================================================
    # DATE HELPERS
    # ============================================================

    def _resolve_date(
        self,
        raw: object,
    ) -> date:

        if raw is None:
            return datetime.now().date()

        parsed = (
            self._parse_datetime(
                raw
            )
        )

        if parsed is not None:
            return parsed.date()

        return datetime.now().date()

    def _parse_datetime(
        self,
        raw: object,
    ) -> datetime | None:

        if raw is None:
            return None

        value = (
            str(raw)
            .strip()
        )

        if not value:
            return None

        formats = [
            "%Y-%m-%d %H:%M:%S",
            "%Y-%m-%dT%H:%M:%S",
            "%Y-%m-%dT%H:%M:%S.%f",
            "%Y-%m-%d",
            "%m-%d-%Y",
            "%d-%m-%Y",
            "%H:%M:%S",
            "%H:%M",
        ]

        for fmt in formats:
            try:
                return datetime.strptime(
                    value,
                    fmt,
                )

            except ValueError:
                continue

        return None

    # ============================================================
    # CURRENT MOON
    # ============================================================

    def _extract_today_moon_sign(
        self,
        natal_transits: dict,
        tropical_transits: dict,
    ) -> str:

        # ========================================================
        # First choice:
        # natal_transits transit_relation
        # ========================================================

        relations = (
            natal_transits.get(
                "transit_relation",
                [],
            )
            or []
        )

        if isinstance(
            relations,
            list,
        ):
            for relation in relations:

                if not isinstance(
                    relation,
                    dict,
                ):
                    continue

                planet = str(
                    relation.get(
                        "transit_planet",
                        "",
                    )
                ).lower()

                if planet != "moon":
                    continue

                sign = (
                    relation.get(
                        "transit_sign"
                    )
                )

                if sign:
                    return str(sign)

        # ========================================================
        # Fallback:
        # tropical_transits
        # ========================================================

        possible_lists = [
            tropical_transits.get(
                "transit_house"
            ),
            tropical_transits.get(
                "planets"
            ),
            tropical_transits.get(
                "transits"
            ),
        ]

        for collection in possible_lists:

            if not isinstance(
                collection,
                list,
            ):
                continue

            for item in collection:

                if not isinstance(
                    item,
                    dict,
                ):
                    continue

                planet_name = str(
                    item.get(
                        "planet",
                        item.get(
                            "name",
                            "",
                        ),
                    )
                ).lower()

                if planet_name != "moon":
                    continue

                sign = (
                    item.get(
                        "transit_sign"
                    )
                    or item.get(
                        "sign"
                    )
                    or item.get(
                        "natal_sign"
                    )
                )

                if sign:
                    return str(sign)

        return ""

    # ============================================================
    # BUILD TRANSITS
    # ============================================================

    def _build_transits(
        self,
        natal_transits: dict,
        today_date: date,
    ) -> list[dict]:

        relations = (
            natal_transits.get(
                "transit_relation",
                [],
            )
            or []
        )

        if not isinstance(
            relations,
            list,
        ):
            return []

        parsed = []

        for relation in relations:

            if not isinstance(
                relation,
                dict,
            ):
                continue

            transit_planet = str(
                relation.get(
                    "transit_planet",
                    "",
                )
            ).strip()

            natal_planet = str(
                relation.get(
                    "natal_planet",
                    "",
                )
            ).strip()

            aspect = str(
                relation.get(
                    "aspect_type",
                    relation.get(
                        "type",
                        "",
                    ),
                )
            ).strip()

            if (
                not transit_planet
                or not natal_planet
            ):
                continue

            start_raw = (
                relation.get(
                    "start_time"
                )
            )

            exact_raw = (
                relation.get(
                    "exact_time"
                )
            )

            end_raw = (
                relation.get(
                    "end_time"
                )
            )

            start_dt = (
                self._parse_datetime(
                    start_raw
                )
            )

            exact_dt = (
                self._parse_datetime(
                    exact_raw
                )
            )

            end_dt = (
                self._parse_datetime(
                    end_raw
                )
            )

            # ====================================================
            # EXACT TODAY
            # ====================================================

            is_exact_today = (
                exact_dt is not None
                and exact_dt.date()
                == today_date
            )

            # ====================================================
            # ACTIVE TODAY
            # ====================================================

            active_today = True

            if (
                start_dt is not None
                and end_dt is not None
            ):
                active_today = (
                    start_dt.date()
                    <= today_date
                    <= end_dt.date()
                )

            if not active_today:
                continue

            # ====================================================
            # STATUS
            # ====================================================

            if is_exact_today:
                status = (
                    "Exact today"
                )

            elif exact_dt is not None:

                if exact_dt.date() < today_date:
                    status = (
                        "Active · exact "
                        + exact_dt.strftime(
                            "%b %d"
                        )
                    )

                else:
                    status = (
                        "Active · exact "
                        + exact_dt.strftime(
                            "%b %d"
                        )
                    )

            else:
                status = "Active"

            # ====================================================
            # SCORE FOR ORDER
            # ====================================================

            priority = (
                self._transit_priority(
                    transit_planet=
                        transit_planet,
                    aspect=
                        aspect,
                    is_exact_today=
                        is_exact_today,
                )
            )

            parsed.append(
                {
                    "first":
                        transit_planet,

                    "aspect":
                        aspect,

                    "second":
                        natal_planet,

                    "title":
                        (
                            f"{transit_planet} "
                            f"{aspect.lower()} "
                            f"natal {natal_planet}"
                        ),

                    "description":
                        self._transit_description(
                            transit_planet=
                                transit_planet,
                            aspect=
                                aspect,
                            natal_planet=
                                natal_planet,
                        ),

                    "status":
                        status,

                    "is_exact_today":
                        is_exact_today,

                    "transit_sign":
                        relation.get(
                            "transit_sign"
                        ),

                    "natal_house":
                        relation.get(
                            "natal_house"
                        ),

                    "start_time":
                        start_raw,

                    "exact_time":
                        exact_raw,

                    "end_time":
                        end_raw,

                    "exact_hour":
                        (
                            exact_dt.strftime(
                                "%H:%M"
                            )
                            if exact_dt
                            is not None
                            else None
                        ),

                    "retrograde":
                        bool(
                            relation.get(
                                "is_retrograde",
                                False,
                            )
                        ),

                    "_priority":
                        priority,

                    "_exact_datetime":
                        exact_dt,
                }
            )

        # ========================================================
        # SORT
        #
        # 1. Exact today
        # 2. Higher priority
        # 3. Exact time
        # ========================================================

        parsed.sort(
            key=lambda item: (
                0
                if item[
                    "is_exact_today"
                ]
                else 1,

                -item[
                    "_priority"
                ],

                (
                    item[
                        "_exact_datetime"
                    ]
                    or datetime.max
                ),
            )
        )

        # ========================================================
        # REMOVE INTERNAL FIELDS
        # ========================================================

        result = []

        for transit in parsed[:8]:

            clean = dict(
                transit
            )

            clean.pop(
                "_priority",
                None,
            )

            clean.pop(
                "_exact_datetime",
                None,
            )

            result.append(
                clean
            )

        return result

    # ============================================================
    # TRANSIT PRIORITY
    # ============================================================

    def _transit_priority(
        self,
        transit_planet: str,
        aspect: str,
        is_exact_today: bool,
    ) -> int:

        score = 0

        # Exact today gets strongest boost.
        if is_exact_today:
            score += 100

        # Faster planets matter more for TODAY.
        planet_scores = {
            "moon": 30,
            "sun": 25,
            "mercury": 22,
            "venus": 22,
            "mars": 22,
            "jupiter": 16,
            "saturn": 15,
            "uranus": 12,
            "neptune": 12,
            "pluto": 12,
        }

        score += planet_scores.get(
            transit_planet.lower(),
            10,
        )

        # Stronger traditional aspects.
        aspect_scores = {
            "conjunction": 12,
            "opposition": 11,
            "square": 11,
            "trine": 9,
            "sextile": 7,
        }

        score += aspect_scores.get(
            aspect.lower(),
            4,
        )

        return score

    # ============================================================
    # AFFECTED HOUSES
    # ============================================================

    def _build_affected_houses(
        self,
        natal_transits: dict,
    ) -> list[dict]:

        relations = (
            natal_transits.get(
                "transit_relation",
                [],
            )
            or []
        )

        if not isinstance(
            relations,
            list,
        ):
            return []

        counts: dict[int, int] = {}

        for relation in relations:

            if not isinstance(
                relation,
                dict,
            ):
                continue

            house = (
                relation.get(
                    "natal_house"
                )
            )

            if house is None:
                continue

            try:
                number = int(
                    house
                )

            except Exception:
                continue

            if (
                number < 1
                or number > 12
            ):
                continue

            counts[number] = (
                counts.get(
                    number,
                    0,
                )
                + 1
            )

        ordered = sorted(
            counts.items(),
            key=lambda item:
                item[1],
            reverse=True,
        )

        result = []

        for number, count in ordered[:3]:

            house_data = (
                self.HOUSE_DATA[
                    number
                ]
            )

            result.append(
                {
                    "number":
                        number,

                    "title":
                        house_data[
                            "title"
                        ],

                    "subtitle":
                        house_data[
                            "subtitle"
                        ],

                    "description":
                        house_data[
                            "description"
                        ],

                    "activity_count":
                        count,
                }
            )

        return result

    # ============================================================
    # THEMES
    # ============================================================

    def _build_themes(
        self,
        transits: list[dict],
    ) -> list[dict]:

        scores = {
            "Love": 3,
            "Energy": 3,
            "Work": 3,
            "Emotions": 3,
        }

        for transit in transits:

            first = str(
                transit.get(
                    "first",
                    "",
                )
            ).lower()

            second = str(
                transit.get(
                    "second",
                    "",
                )
            ).lower()

            aspect = str(
                transit.get(
                    "aspect",
                    "",
                )
            ).lower()

            exact_today = bool(
                transit.get(
                    "is_exact_today",
                    False,
                )
            )

            planets = {
                first,
                second,
            }

            harmonious = (
                aspect in {
                    "trine",
                    "sextile",
                }
            )

            challenging = (
                aspect in {
                    "square",
                    "opposition",
                }
            )

            modifier = (
                2
                if exact_today
                else 1
            )

            # ====================================================
            # LOVE
            # ====================================================

            if "venus" in planets:

                if harmonious:
                    scores["Love"] += (
                        modifier
                    )

                elif challenging:
                    scores["Love"] -= (
                        modifier
                    )

            # ====================================================
            # ENERGY
            # ====================================================

            if "mars" in planets:

                if harmonious:
                    scores["Energy"] += (
                        modifier
                    )

                elif challenging:
                    scores["Energy"] -= (
                        modifier
                    )

                elif (
                    aspect ==
                    "conjunction"
                ):
                    scores["Energy"] += 1

            # ====================================================
            # WORK
            # ====================================================

            if (
                "saturn" in planets
                or "mercury" in planets
            ):

                if harmonious:
                    scores["Work"] += (
                        modifier
                    )

                elif challenging:
                    scores["Work"] -= (
                        modifier
                    )

            # ====================================================
            # EMOTIONS
            # ====================================================

            if "moon" in planets:

                if harmonious:
                    scores[
                        "Emotions"
                    ] += modifier

                elif challenging:
                    scores[
                        "Emotions"
                    ] -= modifier

                elif (
                    aspect ==
                    "conjunction"
                ):
                    scores[
                        "Emotions"
                    ] += 1

        return [
            {
                "name":
                    name,

                "value":
                    max(
                        1,
                        min(
                            5,
                            value,
                        ),
                    ),
            }
            for name, value
            in scores.items()
        ]

    # ============================================================
    # INTERPRETATION
    # ============================================================

    def _build_interpretation(
        self,
        transits: list[dict],
        moon_sign: str,
        affected_houses: list[dict],
    ) -> str:

        exact_today = [
            transit
            for transit in transits
            if transit.get(
                "is_exact_today"
            )
        ]

        house_text = ""

        if affected_houses:
            primary_house = (
                affected_houses[0]
            )

            house_text = (
                f" Your {primary_house['title']} "
                f"({primary_house['subtitle'].lower()}) "
                f"is especially activated."
            )

        # ========================================================
        # EXACT TRANSITS TODAY
        # ========================================================

        if exact_today:

            main = exact_today[0]

            second = (
                exact_today[1]
                if len(exact_today) > 1
                else None
            )

            text = ""

            if moon_sign:
                text += (
                    f"With the Moon moving through "
                    f"{moon_sign}, today's emotional "
                    f"tone emphasizes the qualities "
                    f"of that sign."
                )

            text += house_text

            text += (
                f" A major pattern today is "
                f"{main['title']}."
            )

            if second:
                text += (
                    f" Another exact influence is "
                    f"{second['title']}."
                )

            text += (
                " Notice how these energies appear "
                "in your decisions, reactions and "
                "relationships rather than treating "
                "them as isolated events."
            )

            return text.strip()

        # ========================================================
        # ACTIVE BUT NOT EXACT
        # ========================================================

        if transits:

            strongest = (
                transits[0]
            )

            text = ""

            if moon_sign:
                text += (
                    f"With the Moon moving through "
                    f"{moon_sign}, your emotional "
                    f"rhythm reflects the themes "
                    f"of that sign."
                )

            text += house_text

            text += (
                f" One of the strongest active "
                f"patterns around your chart is "
                f"{strongest['title']}."
            )

            return text.strip()

        # ========================================================
        # QUIET DAY
        # ========================================================

        if moon_sign:
            return (
                f"The Moon is moving through "
                f"{moon_sign}. The sky is relatively "
                f"quiet around your natal chart today, "
                f"making this a useful day to observe "
                f"your emotional rhythm without "
                f"forcing major movement."
            )

        return (
            "The sky is relatively quiet around "
            "your natal chart today. Observe your "
            "natural rhythm rather than forcing "
            "unnecessary movement."
        )

    # ============================================================
    # TODAY FOCUS
    # ============================================================

    def _build_focus(
        self,
        transits: list[dict],
    ) -> str:

        if not transits:
            return (
                "Observe your rhythm and avoid "
                "forcing unnecessary decisions."
            )

        exact_today = [
            transit
            for transit in transits
            if transit.get(
                "is_exact_today"
            )
        ]

        transit = (
            exact_today[0]
            if exact_today
            else transits[0]
        )

        first = (
            transit.get(
                "first",
                ""
            )
        )

        second = (
            transit.get(
                "second",
                ""
            )
        )

        aspect = (
            transit.get(
                "aspect",
                ""
            )
        )

        return (
            f"Notice how {first} "
            f"{aspect.lower()} your natal "
            f"{second} shows up in your "
            f"choices today."
        )

    # ============================================================
    # TRANSIT DESCRIPTION
    # ============================================================

    def _transit_description(
        self,
        transit_planet: str,
        aspect: str,
        natal_planet: str,
    ) -> str:

        aspect_lower = (
            aspect.lower()
        )

        if aspect_lower == "trine":
            tone = (
                "This creates a smoother flow "
                "between both energies."
            )

        elif aspect_lower == "sextile":
            tone = (
                "This opens an opportunity to "
                "use both energies constructively."
            )

        elif aspect_lower == "square":
            tone = (
                "This can create friction that "
                "asks for adjustment and awareness."
            )

        elif aspect_lower == "opposition":
            tone = (
                "This highlights a polarity that "
                "may require balance."
            )

        elif aspect_lower == "conjunction":
            tone = (
                "These energies become strongly "
                "combined and more noticeable."
            )

        else:
            tone = (
                "This interaction is currently "
                "active in your natal chart."
            )

        return (
            f"{transit_planet} is interacting "
            f"with your natal {natal_planet}. "
            f"{tone}"
        )

    # ============================================================
    # MOON SUBTITLE
    # ============================================================

    def _moon_subtitle(
        self,
        sign: str,
    ) -> str:

        descriptions = {
            "aries":
                "Emotion moves quickly and directly.",

            "taurus":
                "A slower rhythm favors stability and grounding.",

            "gemini":
                "Curiosity and communication shape the emotional tone.",

            "cancer":
                "Sensitivity, belonging and emotional security come forward.",

            "leo":
                "Expression, warmth and recognition become more noticeable.",

            "virgo":
                "Attention turns toward details, routines and improvement.",

            "libra":
                "Balance, connection and harmony become more important.",

            "scorpio":
                "Emotions deepen and hidden layers may become more visible.",

            "sagittarius":
                "The mood favors movement, perspective and exploration.",

            "capricorn":
                "Emotional energy becomes more contained and goal-oriented.",

            "aquarius":
                "Distance, perspective and unconventional ideas come forward.",

            "pisces":
                "Intuition, imagination and sensitivity are heightened.",
        }

        return descriptions.get(
            sign.lower(),
            "Your emotional rhythm for today.",
        )

    # ============================================================
    # QUOTE
    # ============================================================

    def _build_quote(
        self,
        sign: str,
    ) -> str:

        quotes = {
            "aries":
                "Move with intention, not only impulse.",

            "taurus":
                "What is steady does not need to be rushed.",

            "gemini":
                "A new perspective can change the entire conversation.",

            "cancer":
                "Protect what matters without closing yourself off.",

            "leo":
                "Expression becomes stronger when it comes from sincerity.",

            "virgo":
                "Small adjustments can change the whole rhythm.",

            "libra":
                "Balance is created, not simply found.",

            "scorpio":
                "Depth reveals what the surface cannot.",

            "sagittarius":
                "Perspective expands when you allow yourself to move.",

            "capricorn":
                "What you build patiently can become lasting.",

            "aquarius":
                "Distance can reveal patterns that closeness hides.",

            "pisces":
                "Not everything meaningful needs to be explained immediately.",
        }

        return quotes.get(
            sign.lower(),
            "Notice what the day is asking you to see.",
        )

    # ============================================================
    # LUCKY TIME
    # ============================================================

    def _lucky_time(
        self,
        transits: list[dict],
        today_date: date,
    ) -> str:

        # ========================================================
        # Use ONLY harmonious exact transits
        # happening on this date.
        # ========================================================

        harmonious_aspects = {
            "trine",
            "sextile",
        }

        candidates = []

        for transit in transits:

            if not transit.get(
                "is_exact_today"
            ):
                continue

            aspect = str(
                transit.get(
                    "aspect",
                    "",
                )
            ).lower()

            if (
                aspect
                not in harmonious_aspects
            ):
                continue

            exact_dt = (
                self._parse_datetime(
                    transit.get(
                        "exact_time"
                    )
                )
            )

            if (
                exact_dt is None
                or exact_dt.date()
                != today_date
            ):
                continue

            candidates.append(
                exact_dt
            )

        if candidates:
            candidates.sort()

            return (
                candidates[0]
                .strftime(
                    "%H:%M"
                )
            )

        # ========================================================
        # Fallback:
        # any exact transit today
        # ========================================================

        fallback = []

        for transit in transits:

            if not transit.get(
                "is_exact_today"
            ):
                continue

            exact_dt = (
                self._parse_datetime(
                    transit.get(
                        "exact_time"
                    )
                )
            )

            if (
                exact_dt is not None
                and exact_dt.date()
                == today_date
            ):
                fallback.append(
                    exact_dt
                )

        if fallback:

            fallback.sort()

            return (
                fallback[0]
                .strftime(
                    "%H:%M"
                )
            )

        return "—"

    # ============================================================
    # LUCKY COLOR
    # ============================================================

    def _lucky_color(
        self,
        moon_sign: str,
    ) -> str:

        colors = {
            "aries":
                "Crimson",

            "taurus":
                "Sage Green",

            "gemini":
                "Soft Yellow",

            "cancer":
                "Pearl",

            "leo":
                "Gold",

            "virgo":
                "Olive",

            "libra":
                "Rose",

            "scorpio":
                "Burgundy",

            "sagittarius":
                "Indigo",

            "capricorn":
                "Charcoal",

            "aquarius":
                "Electric Blue",

            "pisces":
                "Lavender",
        }

        return colors.get(
            moon_sign.lower(),
            "Neutral",
        )


today_service = TodayService()