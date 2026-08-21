from typing import List, Optional

from fastapi import APIRouter, HTTPException
from pydantic import BaseModel

from app.services.chart_service import chart_service
from app.services.translation_service import (
    normalize_language,
    translate_list,
)


router = APIRouter(
    prefix="/houses",
    tags=["Houses"],
)


# ============================================================
# MODELOS
# ============================================================

class HousePlanet(BaseModel):
    name: str
    symbol: str

    sign: Optional[str] = None
    degree: Optional[float] = None
    formatted_degree: Optional[str] = None

    is_retrograde: bool = False


class HouseActivity(BaseModel):
    score: int
    level: str


class HouseData(BaseModel):
    house: int
    roman: str

    title: str
    subtitle: str

    sign: str

    degree: float
    formatted_degree: str

    ruler: str

    planets: List[HousePlanet]

    keywords: List[str]

    activity: HouseActivity


class HousesResponse(BaseModel):
    user_id: str
    houses: List[HouseData]


# ============================================================
# MODELOS PARA DETALLE / INTERPRETACIÓN
# ============================================================

class RulerPlacement(BaseModel):
    planet: str
    symbol: str

    sign: Optional[str] = None
    house: Optional[int] = None

    degree: Optional[float] = None
    formatted_degree: Optional[str] = None

    is_retrograde: bool = False


class PlanetInfluence(BaseModel):
    planet: str
    symbol: str

    title: str
    interpretation: str


class HouseInterpretation(BaseModel):
    summary: str

    sign_title: str
    sign_interpretation: str

    ruler_title: str
    ruler_interpretation: str

    planet_influences: List[PlanetInfluence]

    how_this_may_show_up: List[str]


class HouseDetailResponse(BaseModel):
    user_id: str

    house: HouseData

    ruler_placement: Optional[RulerPlacement] = None

    interpretation: HouseInterpretation


# ============================================================
# INFORMACIÓN BASE DE LAS CASAS
# ============================================================

HOUSE_INFO = {
    1: {
        "roman": "I",
        "title": "House of Self",
        "subtitle": "Identity, appearance & first impressions",
        "keywords": [
            "Identity",
            "Appearance",
            "First impressions",
        ],
    },

    2: {
        "roman": "II",
        "title": "House of Values",
        "subtitle": "Money, possessions & self-worth",
        "keywords": [
            "Money",
            "Values",
            "Self-worth",
        ],
    },

    3: {
        "roman": "III",
        "title": "House of Communication",
        "subtitle": "Communication, learning & local environment",
        "keywords": [
            "Communication",
            "Learning",
            "Siblings",
        ],
    },

    4: {
        "roman": "IV",
        "title": "House of Home",
        "subtitle": "Home, family & emotional foundations",
        "keywords": [
            "Home",
            "Family",
            "Roots",
        ],
    },

    5: {
        "roman": "V",
        "title": "House of Creativity",
        "subtitle": "Creativity, romance & self-expression",
        "keywords": [
            "Creativity",
            "Romance",
            "Pleasure",
        ],
    },

    6: {
        "roman": "VI",
        "title": "House of Daily Life",
        "subtitle": "Work, routines & wellbeing",
        "keywords": [
            "Routine",
            "Work",
            "Wellbeing",
        ],
    },

    7: {
        "roman": "VII",
        "title": "House of Relationships",
        "subtitle": "Partnerships, commitment & the other",
        "keywords": [
            "Relationships",
            "Partnerships",
            "Commitment",
        ],
    },

    8: {
        "roman": "VIII",
        "title": "House of Transformation",
        "subtitle": "Intimacy, shared resources & transformation",
        "keywords": [
            "Intimacy",
            "Transformation",
            "Shared resources",
        ],
    },

    9: {
        "roman": "IX",
        "title": "House of Expansion",
        "subtitle": "Beliefs, travel & higher learning",
        "keywords": [
            "Travel",
            "Beliefs",
            "Higher learning",
        ],
    },

    10: {
        "roman": "X",
        "title": "House of Career",
        "subtitle": "Purpose, reputation & public life",
        "keywords": [
            "Career",
            "Reputation",
            "Purpose",
        ],
    },

    11: {
        "roman": "XI",
        "title": "House of Community",
        "subtitle": "Friendships, community & future goals",
        "keywords": [
            "Friends",
            "Community",
            "Goals",
        ],
    },

    12: {
        "roman": "XII",
        "title": "House of Inner Life",
        "subtitle": "Subconscious, solitude & inner world",
        "keywords": [
            "Subconscious",
            "Solitude",
            "Inner world",
        ],
    },
}


# ============================================================
# REGENTES
# Sistema moderno
# ============================================================

SIGN_RULERS = {
    "Aries": "Mars",
    "Taurus": "Venus",
    "Gemini": "Mercury",
    "Cancer": "Moon",
    "Leo": "Sun",
    "Virgo": "Mercury",
    "Libra": "Venus",
    "Scorpio": "Pluto",
    "Sagittarius": "Jupiter",
    "Capricorn": "Saturn",
    "Aquarius": "Uranus",
    "Pisces": "Neptune",
}


# ============================================================
# SÍMBOLOS
# ============================================================

PLANET_SYMBOLS = {
    "Sun": "☉",
    "Moon": "☽",
    "Mercury": "☿",
    "Venus": "♀",
    "Mars": "♂",
    "Jupiter": "♃",
    "Saturn": "♄",
    "Uranus": "♅",
    "Neptune": "♆",
    "Pluto": "♇",
    "North Node": "☊",
    "South Node": "☋",
    "Node": "☊",
    "Chiron": "⚷",
    "Lilith": "⚸",
    "Part of Fortune": "⊗",
}


# ============================================================
# SIGNIFICADO DE LOS SIGNOS
#
# Se utiliza para interpretar cómo el signo de la cúspide
# expresa los temas de esa casa.
# ============================================================

SIGN_INTERPRETATIONS = {
    "Aries": (
        "Aries brings initiative, independence and direct action. "
        "You tend to approach this area of life actively and prefer "
        "to make your own decisions rather than wait for circumstances."
    ),

    "Taurus": (
        "Taurus brings stability, patience and a strong need for security. "
        "You may build this area of life slowly, valuing consistency, "
        "comfort and what can be sustained over time."
    ),

    "Gemini": (
        "Gemini brings curiosity, adaptability and communication. "
        "This part of life is often processed through ideas, conversation, "
        "learning and the need to explore more than one perspective."
    ),

    "Cancer": (
        "Cancer brings emotional sensitivity, protection and attachment. "
        "This area tends to be experienced personally and may be strongly "
        "connected with emotional safety, memory and belonging."
    ),

    "Leo": (
        "Leo brings creativity, pride and the desire for authentic "
        "self-expression. This area may become an important place for "
        "visibility, confidence and recognition."
    ),

    "Virgo": (
        "Virgo brings analysis, precision and the desire to improve. "
        "You may approach this area carefully, noticing details and seeking "
        "practical ways to make it more organized or effective."
    ),

    "Libra": (
        "Libra brings balance, relationship awareness and a strong sense "
        "of fairness. You may evaluate this area through harmony, aesthetics, "
        "reciprocity and the effect your decisions have on others."
    ),

    "Scorpio": (
        "Scorpio brings intensity, depth and transformation. "
        "This area of life is rarely superficial for you and may involve "
        "powerful emotional processes, trust and periods of profound change."
    ),

    "Sagittarius": (
        "Sagittarius brings expansion, exploration and the search for meaning. "
        "You tend to seek freedom and broader perspectives in this area, "
        "often learning through experience."
    ),

    "Capricorn": (
        "Capricorn brings responsibility, ambition and long-term structure. "
        "You may take this area seriously and prefer to build something "
        "reliable through discipline and gradual progress."
    ),

    "Aquarius": (
        "Aquarius brings independence, originality and unconventional thinking. "
        "You may approach this part of life differently from what is expected, "
        "valuing autonomy and new possibilities."
    ),

    "Pisces": (
        "Pisces brings intuition, sensitivity and imagination. "
        "The boundaries around this area may feel fluid, and you may navigate "
        "it through empathy, instinct, creativity or spiritual meaning."
    ),
}


# ============================================================
# SIGNIFICADO DE PLANETAS
# ============================================================

PLANET_INTERPRETATIONS = {
    "Sun": (
        "The Sun makes this house an important part of your identity. "
        "You may feel a strong need to express yourself, develop confidence "
        "and feel recognized through the themes of this house."
    ),

    "Moon": (
        "The Moon makes this house emotionally important. "
        "Your instinctive reactions, emotional needs and sense of safety "
        "are strongly connected with its themes."
    ),

    "Mercury": (
        "Mercury brings thought, observation and communication into this house. "
        "You are likely to analyze, discuss or mentally revisit these themes "
        "more often than other areas of life."
    ),

    "Venus": (
        "Venus emphasizes attraction, pleasure, harmony and personal values. "
        "You naturally seek balance and satisfaction through the themes "
        "represented by this house."
    ),

    "Mars": (
        "Mars adds drive, urgency and initiative. "
        "You may actively pursue what this house represents, although it can "
        "also become an area where frustration or conflict pushes you to act."
    ),

    "Jupiter": (
        "Jupiter encourages growth, confidence and expansion. "
        "This house can become an important area of learning, opportunity "
        "and the desire to experience more."
    ),

    "Saturn": (
        "Saturn adds seriousness, responsibility and long-term lessons. "
        "This area may initially feel demanding, but it can become one of "
        "your strongest areas through patience and experience."
    ),

    "Uranus": (
        "Uranus introduces independence, change and unpredictability. "
        "You may need freedom in this area and may experience it in ways "
        "that differ from conventional expectations."
    ),

    "Neptune": (
        "Neptune adds sensitivity, imagination and idealism. "
        "This area can inspire you deeply, although maintaining clear "
        "boundaries and realistic expectations may sometimes be important."
    ),

    "Pluto": (
        "Pluto brings intensity, transformation and psychological depth. "
        "The themes of this house can become catalysts for major internal "
        "changes and powerful experiences."
    ),

    "Chiron": (
        "Chiron can make this area particularly sensitive. "
        "Experiences here may reveal vulnerabilities, but they can also "
        "become a source of insight, healing and maturity."
    ),

    "Node": (
        "The lunar node gives this area a developmental quality. "
        "Its themes may repeatedly invite growth, unfamiliar experiences "
        "and important personal learning."
    ),

    "North Node": (
        "The North Node gives this area a developmental quality. "
        "Its themes may repeatedly invite growth, unfamiliar experiences "
        "and important personal learning."
    ),

    "Part of Fortune": (
        "The Part of Fortune highlights an area where circumstances may "
        "flow more naturally when you act in alignment with your strengths."
    ),
}


# ============================================================
# HELPERS BÁSICOS
# ============================================================

def format_degree(
    degree: float,
) -> str:

    normalized = float(degree) % 30

    degrees = int(normalized)

    minutes = round(
        (normalized - degrees) * 60
    )

    if minutes == 60:
        degrees += 1
        minutes = 0

    if degrees == 30:
        degrees = 0

    return f"{degrees}°{minutes:02d}'"


def parse_retrograde(
    value,
) -> bool:

    if isinstance(value, bool):
        return value

    return (
        str(value)
        .strip()
        .lower()
        == "true"
    )


# ============================================================
# ACTIVIDAD
# ============================================================

def calculate_activity(
    planets: List[HousePlanet],
) -> HouseActivity:

    score = 0

    for planet in planets:

        if planet.name in {
            "Sun",
            "Moon",
        }:
            score += 3

        elif planet.name in {
            "Mercury",
            "Venus",
            "Mars",
            "Jupiter",
            "Saturn",
        }:
            score += 2

        elif planet.name in {
            "Uranus",
            "Neptune",
            "Pluto",
        }:
            score += 1

    if score >= 7:
        level = "VERY HIGH"

    elif score >= 5:
        level = "HIGH"

    elif score >= 3:
        level = "MEDIUM"

    else:
        level = "LOW"

    return HouseActivity(
        score=score,
        level=level,
    )


# ============================================================
# PLANETAS DE UNA CASA
# ============================================================

def get_planets_for_house(
    planets: list,
    house_number: int,
) -> List[HousePlanet]:

    result: List[HousePlanet] = []

    for planet in planets:

        raw_house = planet.get("house")

        if raw_house is None:
            continue

        try:
            planet_house = int(raw_house)

        except (
            TypeError,
            ValueError,
        ):
            continue

        if planet_house != house_number:
            continue

        name = (
            planet.get("planet")
            or planet.get("name")
            or ""
        )

        if not name:
            continue

        raw_degree = planet.get("degree")

        if raw_degree is None:
            raw_degree = planet.get(
                "norm_degree"
            )

        degree = None

        if raw_degree is not None:

            try:
                degree = (
                    float(raw_degree)
                    % 30
                )

            except (
                TypeError,
                ValueError,
            ):
                degree = None

        retrograde_raw = planet.get(
            "retrograde"
        )

        if retrograde_raw is None:
            retrograde_raw = planet.get(
                "is_retro",
                False,
            )

        result.append(
            HousePlanet(
                name=name,
                symbol=PLANET_SYMBOLS.get(
                    name,
                    "•",
                ),
                sign=planet.get("sign"),
                degree=degree,
                formatted_degree=(
                    format_degree(degree)
                    if degree is not None
                    else None
                ),
                is_retrograde=parse_retrograde(
                    retrograde_raw
                ),
            )
        )

    return result


# ============================================================
# BUSCAR UN PLANETA
# ============================================================

def find_planet(
    planets: list,
    planet_name: str,
) -> Optional[dict]:

    for planet in planets:

        name = (
            planet.get("planet")
            or planet.get("name")
            or ""
        )

        if name.lower() == planet_name.lower():
            return planet

    return None


# ============================================================
# POSICIÓN DEL REGENTE
# ============================================================

def get_ruler_placement(
    planets: list,
    ruler: str,
) -> Optional[RulerPlacement]:

    raw_planet = find_planet(
        planets,
        ruler,
    )

    if raw_planet is None:
        return None

    raw_degree = (
        raw_planet.get("degree")
    )

    if raw_degree is None:
        raw_degree = (
            raw_planet.get(
                "norm_degree"
            )
        )

    degree = None

    if raw_degree is not None:

        try:
            degree = (
                float(raw_degree)
                % 30
            )

        except (
            TypeError,
            ValueError,
        ):
            degree = None

    raw_house = raw_planet.get(
        "house"
    )

    house = None

    if raw_house is not None:

        try:
            house = int(raw_house)

        except (
            TypeError,
            ValueError,
        ):
            house = None

    retrograde_raw = (
        raw_planet.get(
            "retrograde"
        )
    )

    if retrograde_raw is None:
        retrograde_raw = (
            raw_planet.get(
                "is_retro",
                False,
            )
        )

    return RulerPlacement(
        planet=ruler,
        symbol=PLANET_SYMBOLS.get(
            ruler,
            "•",
        ),
        sign=raw_planet.get(
            "sign"
        ),
        house=house,
        degree=degree,
        formatted_degree=(
            format_degree(degree)
            if degree is not None
            else None
        ),
        is_retrograde=(
            parse_retrograde(
                retrograde_raw
            )
        ),
    )


# ============================================================
# CONSTRUIR UNA CASA
# ============================================================

def build_house_data(
    raw_house: dict,
    raw_planets: list,
) -> Optional[HouseData]:

    try:
        house_number = int(
            raw_house.get(
                "house",
                0,
            )
        )

    except (
        TypeError,
        ValueError,
    ):
        return None

    if not 1 <= house_number <= 12:
        return None

    info = HOUSE_INFO.get(
        house_number
    )

    if info is None:
        return None

    sign = str(
        raw_house.get(
            "sign",
            "",
        )
        or ""
    )

    try:
        degree = (
            float(
                raw_house.get(
                    "degree",
                    0,
                )
                or 0
            )
            % 30
        )

    except (
        TypeError,
        ValueError,
    ):
        degree = 0.0

    planets = get_planets_for_house(
        raw_planets,
        house_number,
    )

    ruler = SIGN_RULERS.get(
        sign,
        "Unknown",
    )

    return HouseData(
        house=house_number,
        roman=info["roman"],
        title=info["title"],
        subtitle=info["subtitle"],
        sign=sign,
        degree=degree,
        formatted_degree=format_degree(
            degree
        ),
        ruler=ruler,
        planets=planets,
        keywords=info["keywords"],
        activity=calculate_activity(
            planets
        ),
    )


# ============================================================
# CARGAR CARTA REAL
# ============================================================

async def get_chart_data(
    user_id: str,
) -> tuple[dict, list, list]:

    chart_response = (
        await chart_service.get_chart(
            user_id
        )
    )

    chart = (
        chart_response.get(
            "chart",
            {},
        )
        or {}
    )

    raw_houses = (
        chart.get(
            "houses",
            [],
        )
        or []
    )

    raw_planets = (
        chart.get(
            "planets",
            [],
        )
        or []
    )

    if not raw_houses:
        raise HTTPException(
            status_code=404,
            detail=(
                "La carta natal del usuario "
                "no contiene información de casas."
            ),
        )

    return (
        chart,
        raw_houses,
        raw_planets,
    )


# ============================================================
# INTERPRETACIÓN DEL SIGNO EN LA CASA
# ============================================================

def build_sign_interpretation(
    house: HouseData,
) -> str:

    sign_text = (
        SIGN_INTERPRETATIONS.get(
            house.sign,
            (
                "The sign on this house describes "
                "the style through which you tend "
                "to experience this area of life."
            ),
        )
    )

    return (
        f"Your {house.title.lower()} begins in "
        f"{house.sign} at {house.formatted_degree}. "
        f"{sign_text}"
    )


# ============================================================
# INTERPRETACIÓN DEL REGENTE
# ============================================================

def build_ruler_interpretation(
    house: HouseData,
    placement: Optional[RulerPlacement],
) -> str:

    if placement is None:
        return (
            f"{house.ruler} rules your "
            f"{house.title.lower()} because the cusp "
            f"falls in {house.sign}. The condition of "
            f"{house.ruler} describes how the themes "
            f"of this house are expressed elsewhere "
            f"in your natal chart."
        )

    location_parts = []

    if placement.sign:
        location_parts.append(
            f"in {placement.sign}"
        )

    if placement.house:
        location_parts.append(
            f"in House {placement.house}"
        )

    location = " ".join(
        location_parts
    )

    retrograde_text = (
        " Because it is retrograde, its themes may be "
        "processed in a more internal, reflective or "
        "personally defined way."
        if placement.is_retrograde
        else ""
    )

    if location:
        location = f" {location}"

    return (
        f"{house.ruler} rules this house because "
        f"{house.sign} is on its cusp. In your natal "
        f"chart, {house.ruler} is{location}. "
        f"This links the themes of your "
        f"{house.title.lower()} with that part of "
        f"your chart.{retrograde_text}"
    )


# ============================================================
# INTERPRETACIONES DE PLANETAS
# ============================================================

def build_planet_influences(
    house: HouseData,
) -> List[PlanetInfluence]:

    result: List[
        PlanetInfluence
    ] = []

    for planet in house.planets:

        base_text = (
            PLANET_INTERPRETATIONS.get(
                planet.name,
                (
                    f"{planet.name} adds another layer "
                    f"of meaning to the themes of this house."
                ),
            )
        )

        retrograde_text = ""

        if planet.is_retrograde:
            retrograde_text = (
                " Its retrograde position can make this "
                "energy more introspective or personally "
                "defined."
            )

        sign_text = ""

        if planet.sign:
            sign_text = (
                f" In {planet.sign}, this influence is "
                f"expressed through the qualities of "
                f"{planet.sign}."
            )

        result.append(
            PlanetInfluence(
                planet=planet.name,
                symbol=planet.symbol,
                title=(
                    f"{planet.name} in "
                    f"House {house.roman}"
                ),
                interpretation=(
                    base_text
                    + sign_text
                    + retrograde_text
                ),
            )
        )

    return result


# ============================================================
# RESUMEN PERSONALIZADO
# ============================================================

def build_summary(
    house: HouseData,
) -> str:

    topics = ", ".join(
        keyword.lower()
        for keyword in house.keywords
    )

    planet_names = [
        planet.name
        for planet in house.planets
    ]

    if not planet_names:

        return (
            f"Your {house.title.lower()} begins in "
            f"{house.sign}, shaping the way you experience "
            f"{topics}. There are no major natal planets "
            f"placed directly in this house, so its story "
            f"is expressed mainly through {house.sign} "
            f"and its ruler, {house.ruler}."
        )

    if len(planet_names) == 1:
        planets_text = planet_names[0]

    elif len(planet_names) == 2:
        planets_text = (
            f"{planet_names[0]} and "
            f"{planet_names[1]}"
        )

    else:
        planets_text = (
            ", ".join(
                planet_names[:-1]
            )
            + f" and {planet_names[-1]}"
        )

    intensity_text = {
        "VERY HIGH": (
            "This is one of the most emphasized "
            "areas of your natal chart."
        ),

        "HIGH": (
            "This is a strongly emphasized "
            "area of your natal chart."
        ),

        "MEDIUM": (
            "This area has a noticeable role "
            "in your natal chart."
        ),

        "LOW": (
            "This area is expressed more selectively "
            "within your natal chart."
        ),
    }.get(
        house.activity.level,
        "",
    )

    return (
        f"Your {house.title.lower()} begins in "
        f"{house.sign} at {house.formatted_degree}. "
        f"{intensity_text} "
        f"{planets_text} {'is' if len(planet_names) == 1 else 'are'} "
        f"placed here, connecting their energies directly "
        f"with themes of {topics}. "
        f"{house.ruler} rules this house."
    )


# ============================================================
# CÓMO PUEDE MANIFESTARSE
# ============================================================

def build_how_this_may_show_up(
    house: HouseData,
) -> List[str]:

    result: List[str] = []

    if house.activity.level == "VERY HIGH":
        result.append(
            "This area may repeatedly become a major "
            "focus of decisions, growth and life experience."
        )

    elif house.activity.level == "HIGH":
        result.append(
            "The themes of this house are likely to "
            "receive substantial attention throughout life."
        )

    elif house.activity.level == "MEDIUM":
        result.append(
            "The themes of this house may become especially "
            "noticeable during important periods of change."
        )

    else:
        result.append(
            "This area may operate more quietly, becoming "
            "important when its ruler or planets are activated."
        )

    if house.keywords:
        result.append(
            "You may notice recurring experiences involving "
            + ", ".join(
                keyword.lower()
                for keyword in house.keywords
            )
            + "."
        )

    if house.planets:

        names = ", ".join(
            planet.name
            for planet in house.planets
        )

        result.append(
            f"With {names} placed here, these themes are "
            f"directly connected with important parts "
            f"of your personality and life experience."
        )

    else:
        result.append(
            f"Because this house contains no major natal "
            f"planets, its ruler {house.ruler} becomes "
            f"especially important for understanding it."
        )

    return result


# ============================================================
# GET TODAS LAS CASAS
#
# GET /api/houses/{user_id}
# ============================================================

@router.get(
    "/{user_id}",
    response_model=HousesResponse,
    summary="Get natal houses",
)
async def get_houses(
    user_id: str,
    lang: Optional[str] = None,
) -> HousesResponse:

    try:

        (
            _,
            raw_houses,
            raw_planets,
        ) = await get_chart_data(
            user_id
        )

        houses: List[
            HouseData
        ] = []

        for raw_house in raw_houses:

            house = build_house_data(
                raw_house,
                raw_planets,
            )

            if house is not None:
                houses.append(
                    house
                )

        houses.sort(
            key=lambda item:
                item.house
        )

        if not houses:
            raise HTTPException(
                status_code=404,
                detail=(
                    "No fue posible procesar "
                    "las casas natales."
                ),
            )

        target_language = normalize_language(lang)

        if target_language != "en":
            houses = await _translate_houses(
                houses,
                target_language,
            )

        return HousesResponse(
            user_id=user_id,
            houses=houses,
        )

    except HTTPException:
        raise

    except Exception as exc:

        raise HTTPException(
            status_code=500,
            detail=(
                "No fue posible obtener "
                f"las casas natales: {exc}"
            ),
        ) from exc


# ============================================================
# TRADUCCIÓN DE LAS CASAS
#
# Traduce title/subtitle/keywords de una o varias casas en un
# solo batch por campo (independiente de cuántas casas se pasen),
# reusando translate_list como única fuente de traducción.
# ============================================================

async def _translate_houses(
    houses: List[HouseData],
    target_language: str,
) -> List[HouseData]:

    titles = await translate_list(
        [house.title for house in houses],
        target_language,
    )

    subtitles = await translate_list(
        [house.subtitle for house in houses],
        target_language,
    )

    flat_keywords: List[str] = []
    index_map: List[tuple] = []

    for house in houses:
        start = len(flat_keywords)
        flat_keywords.extend(house.keywords)
        index_map.append((start, len(flat_keywords)))

    translated_keywords = await translate_list(
        flat_keywords,
        target_language,
    )

    return [
        house.model_copy(
            update={
                "title": title,
                "subtitle": subtitle,
                "keywords": translated_keywords[start:end],
            }
        )
        for house, title, subtitle, (start, end) in zip(
            houses,
            titles,
            subtitles,
            index_map,
        )
    ]


# ============================================================
# TRADUCCIÓN DE LA INTERPRETACIÓN
#
# Traduce el texto narrativo de la interpretación personalizada.
# ============================================================

async def _translate_interpretation(
    interpretation: HouseInterpretation,
    target_language: str,
) -> HouseInterpretation:

    (
        summary,
        sign_title,
        sign_interpretation,
        ruler_title,
        ruler_interpretation,
    ) = await translate_list(
        [
            interpretation.summary,
            interpretation.sign_title,
            interpretation.sign_interpretation,
            interpretation.ruler_title,
            interpretation.ruler_interpretation,
        ],
        target_language,
    )

    influence_titles = await translate_list(
        [
            influence.title
            for influence in interpretation.planet_influences
        ],
        target_language,
    )

    influence_texts = await translate_list(
        [
            influence.interpretation
            for influence in interpretation.planet_influences
        ],
        target_language,
    )

    planet_influences = [
        influence.model_copy(
            update={
                "title": title,
                "interpretation": text,
            }
        )
        for influence, title, text in zip(
            interpretation.planet_influences,
            influence_titles,
            influence_texts,
        )
    ]

    how_this_may_show_up = await translate_list(
        interpretation.how_this_may_show_up,
        target_language,
    )

    return interpretation.model_copy(
        update={
            "summary": summary,
            "sign_title": sign_title,
            "sign_interpretation": sign_interpretation,
            "ruler_title": ruler_title,
            "ruler_interpretation": ruler_interpretation,
            "planet_influences": planet_influences,
            "how_this_may_show_up": how_this_may_show_up,
        }
    )


# ============================================================
# GET DETALLE PERSONALIZADO
#
# GET /api/houses/{user_id}/{house_number}
# ============================================================

@router.get(
    "/{user_id}/{house_number}",
    response_model=HouseDetailResponse,
    summary="Get personalized natal house interpretation",
)
async def get_house_detail(
    user_id: str,
    house_number: int,
    lang: Optional[str] = None,
) -> HouseDetailResponse:

    try:

        # --------------------------------------------------------
        # Validar número
        # --------------------------------------------------------

        if not 1 <= house_number <= 12:
            raise HTTPException(
                status_code=400,
                detail=(
                    "house_number debe estar "
                    "entre 1 y 12."
                ),
            )

        (
            _,
            raw_houses,
            raw_planets,
        ) = await get_chart_data(
            user_id
        )

        # --------------------------------------------------------
        # Encontrar casa
        # --------------------------------------------------------

        target_raw_house = None

        for raw_house in raw_houses:

            try:
                current_number = int(
                    raw_house.get(
                        "house",
                        0,
                    )
                )

            except (
                TypeError,
                ValueError,
            ):
                continue

            if current_number == house_number:
                target_raw_house = raw_house
                break

        if target_raw_house is None:
            raise HTTPException(
                status_code=404,
                detail=(
                    f"No se encontró la casa "
                    f"{house_number}."
                ),
            )

        # --------------------------------------------------------
        # Construir datos de la casa
        # --------------------------------------------------------

        house = build_house_data(
            target_raw_house,
            raw_planets,
        )

        if house is None:
            raise HTTPException(
                status_code=404,
                detail=(
                    "No fue posible procesar "
                    "la casa solicitada."
                ),
            )

        # --------------------------------------------------------
        # Posición real del regente
        # --------------------------------------------------------

        ruler_placement = (
            get_ruler_placement(
                raw_planets,
                house.ruler,
            )
        )

        # --------------------------------------------------------
        # Interpretación
        # --------------------------------------------------------

        interpretation = HouseInterpretation(
            summary=build_summary(
                house
            ),

            sign_title=(
                f"{house.sign} in your "
                f"{house.title}"
            ),

            sign_interpretation=(
                build_sign_interpretation(
                    house
                )
            ),

            ruler_title=(
                f"{house.ruler} rules "
                f"your House {house.roman}"
            ),

            ruler_interpretation=(
                build_ruler_interpretation(
                    house,
                    ruler_placement,
                )
            ),

            planet_influences=(
                build_planet_influences(
                    house
                )
            ),

            how_this_may_show_up=(
                build_how_this_may_show_up(
                    house
                )
            ),
        )

        # --------------------------------------------------------
        # Traducir si corresponde
        #
        # la interpretación se construye SIEMPRE en inglés primero
        # (usa house.title en sus f-strings), y recién después se
        # traduce house.title/subtitle/keywords por separado, para
        # no mezclar idiomas dentro de una misma oración generada.
        # --------------------------------------------------------

        target_language = normalize_language(lang)

        if target_language != "en":
            interpretation = await _translate_interpretation(
                interpretation,
                target_language,
            )

            (house,) = await _translate_houses(
                [house],
                target_language,
            )

        return HouseDetailResponse(
            user_id=user_id,
            house=house,
            ruler_placement=(
                ruler_placement
            ),
            interpretation=(
                interpretation
            ),
        )

    except HTTPException:
        raise

    except Exception as exc:

        raise HTTPException(
            status_code=500,
            detail=(
                "No fue posible interpretar "
                f"la casa natal: {exc}"
            ),
        ) from exc