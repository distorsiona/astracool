from datetime import datetime
from zoneinfo import ZoneInfo

from app.core.supabase import supabase

from app.schemas.auth import (
    RegisterRequest,
    RegisterResponse,
    UserProfileResponse,
)

from app.schemas.astrology import (
    AstrologyBirthRequest,
)

from app.services.location_service import (
    location_service,
)

from app.services.astrology_service import (
    astrology_service,
)

from app.services.astra_service import (
    astra_service,
)


class AuthService:
    async def register(
        self,
        data: RegisterRequest,
    ) -> RegisterResponse:

        # =====================================================
        # 1. NORMALIZAR DATOS
        # =====================================================

        email = data.email.lower().strip()
        username = data.username.lower().strip()
        full_name = data.full_name.strip()
        birth_place_query = data.birth_place.strip()

        print("PASO 1 -> datos normalizados")

        # =====================================================
        # 2. VERIFICAR USERNAME
        # =====================================================

        username_result = (
            supabase
            .table("profiles")
            .select("id")
            .eq("username", username)
            .execute()
        )

        if username_result.data:
            raise ValueError(
                "El nombre de usuario ya está en uso."
            )

        print("PASO 2 -> username disponible")

        # =====================================================
        # 3. RESOLVER LUGAR DE NACIMIENTO
        # =====================================================

        location_results = await location_service.search(
            birth_place_query
        )

        if not location_results:
            raise ValueError(
                "No fue posible encontrar el lugar de nacimiento."
            )

        # Por ahora usamos el primer resultado.
        # Más adelante Flutter puede permitir seleccionar
        # explícitamente una ubicación.
        location = location_results[0]

        birth_place = location["display_name"]
        birth_lat = float(location["lat"])
        birth_lon = float(location["lon"])

        timezone_name = location.get(
            "timezone_name"
        )

        if not timezone_name:
            raise RuntimeError(
                "No fue posible determinar la zona horaria "
                "del lugar de nacimiento."
            )

        print(
            "PASO 3 -> ubicación:",
            birth_place,
            birth_lat,
            birth_lon,
            timezone_name,
        )

        # =====================================================
        # 4. CALCULAR OFFSET HISTÓRICO
        # =====================================================

        birth_datetime = datetime(
            year=data.birth_date.year,
            month=data.birth_date.month,
            day=data.birth_date.day,
            hour=data.birth_time.hour,
            minute=data.birth_time.minute,
            second=data.birth_time.second,
        )

        localized_birth_datetime = birth_datetime.replace(
            tzinfo=ZoneInfo(
                timezone_name
            ),
        )

        utc_offset = (
            localized_birth_datetime.utcoffset()
        )

        if utc_offset is None:
            raise RuntimeError(
                "No fue posible calcular la zona horaria "
                "de nacimiento."
            )

        birth_timezone = (
            utc_offset.total_seconds()
            / 3600
        )

        print(
            "PASO 4 -> timezone offset:",
            birth_timezone,
        )

        # =====================================================
        # 5. CONSTRUIR DATOS PARA ASTROLOGY API
        # =====================================================

        birth_request = AstrologyBirthRequest(
            day=data.birth_date.day,
            month=data.birth_date.month,
            year=data.birth_date.year,
            hour=data.birth_time.hour,
            minute=data.birth_time.minute,
            lat=birth_lat,
            lon=birth_lon,
            timezone=birth_timezone,
        )

        print(
            "PASO 5 -> solicitando carta astral"
        )

        # =====================================================
        # 6. OBTENER CARTA ASTRAL
        # =====================================================

        chart = (
            await astrology_service
            .western_horoscope(
                birth_request
            )
        )

        print(
            "PASO 6 -> carta astral obtenida"
        )

        # =====================================================
        # 7. ANALIZAR CARTA CON ASTRA SERVICE
        # =====================================================

        analysis = astra_service.analyze(
            chart
        )

        big_three = analysis[
            "big_three"
        ]

        zodiac = analysis[
            "zodiac"
        ]

        sun = big_three[
            "sun"
        ]

        moon = big_three[
            "moon"
        ]

        rising = big_three[
            "rising"
        ]

        print(
            "PASO 7 -> análisis ASTRA:",
            {
                "sun": sun,
                "moon": moon,
                "rising": rising,
                "zodiac": zodiac,
            },
        )

        # =====================================================
        # 8. CREAR USUARIO EN SUPABASE AUTH
        # =====================================================

        auth_response = (
            supabase
            .auth
            .admin
            .create_user(
                {
                    "email": email,
                    "password": data.password,
                    "email_confirm": True,
                }
            )
        )

        user = auth_response.user

        if user is None:
            raise RuntimeError(
                "No se pudo crear el usuario."
            )

        user_id = str(
            user.id
        )

        print(
            "PASO 8 -> usuario Auth creado:",
            user_id,
        )

        # =====================================================
        # 9. CREAR PERFIL COMPLETO
        # =====================================================

        profile_data = {
            # -------------------------------------------------
            # USUARIO
            # -------------------------------------------------

            "id": user_id,

            "display_name":
                full_name,

            "username":
                username,

            # -------------------------------------------------
            # NACIMIENTO
            # -------------------------------------------------

            "birth_date":
                data.birth_date.isoformat(),

            "birth_hour":
                data.birth_time.hour,

            "birth_minute":
                data.birth_time.minute,

            "birth_place":
                birth_place,

            "birth_lat":
                birth_lat,

            "birth_lon":
                birth_lon,

            "birth_timezone":
                birth_timezone,

            # -------------------------------------------------
            # SOL
            # -------------------------------------------------

            "sun_sign":
                sun["sign"],

            "sun_degree":
                float(
                    sun["degree"]
                ),

            # -------------------------------------------------
            # LUNA
            # -------------------------------------------------

            "moon_sign":
                moon["sign"],

            "moon_degree":
                float(
                    moon["degree"]
                ),

            # -------------------------------------------------
            # ASCENDENTE
            # -------------------------------------------------

            "rising_sign":
                rising["sign"],

            "rising_degree":
                float(
                    rising["degree"]
                ),

            # -------------------------------------------------
            # ATRIBUTOS ZODIACALES
            # -------------------------------------------------

            "element":
                zodiac["element"],

            "modality":
                zodiac["modality"],

            "ruling_planet":
                zodiac[
                    "ruling_planet"
                ],
        }

        print(
            "PASO 9 -> creando profile:",
            profile_data,
        )


        # =====================================================
        # 10. GUARDAR PERFIL
        # =====================================================

        profile_response = (
            supabase
            .table("profiles")
            .insert(profile_data)
            .execute()
        )

        if not profile_response.data:
            raise RuntimeError(
                "No se pudo crear el perfil."
            )

        print(
            "PASO 10 -> perfil creado correctamente"
        )

        # =====================================================
        # 11. PREPARAR CARTA NATAL
        # =====================================================

        natal_chart_data = {
            "profile_id": user_id,

            "chart_data": {
                "big_three": analysis.get(
                    "big_three",
                    {},
                ),

                "zodiac": analysis.get(
                    "zodiac",
                    {},
                ),

                "planets": analysis.get(
                    "planets",
                    [],
                ),

                "houses": chart.get(
                    "houses",
                    [],
                ),

                "aspects": chart.get(
                    "aspects",
                    [],
                ),

                "dominant_aspects": analysis.get(
                    "dominant_aspects",
                    [],
                ),
            },
        }

        print(
            "PASO 11 -> guardando carta natal"
        )

        # =====================================================
        # 12. GUARDAR CARTA NATAL
        # =====================================================

        natal_chart_response = (
            supabase
            .table("natal_charts")
            .insert(
                natal_chart_data
            )
            .execute()
        )

        if not natal_chart_response.data:
            raise RuntimeError(
                "No se pudo guardar la carta natal."
            )

        print(
            "PASO 12 -> carta natal guardada correctamente"
        )

    async def login(
        self,
        identifier: str,
        password: str,
    ):
        identifier = identifier.strip().lower()

        # =====================================================
        # 1. RESOLVER EMAIL
        # =====================================================

        if "@" in identifier:
            email = identifier

        else:
            profile_response = (
                supabase
                .table("profiles")
                .select("id")
                .eq("username", identifier)
                .limit(1)
                .execute()
            )

            if not profile_response.data:
                raise ValueError(
                    "Usuario o contraseña incorrectos."
                )

            user_id = profile_response.data[0]["id"]

            auth_user_response = (
                supabase
                .auth
                .admin
                .get_user_by_id(
                    user_id
                )
            )

            auth_user = auth_user_response.user

            if auth_user is None or not auth_user.email:
                raise ValueError(
                    "Usuario o contraseña incorrectos."
                )

            email = auth_user.email

        # =====================================================
        # 2. LOGIN EN SUPABASE
        # =====================================================

        try:
            auth_response = (
                supabase.auth.sign_in_with_password(
                    {
                        "email": email,
                        "password": password,
                    }
                )
            )

        except Exception as exc:
            raise ValueError(
                "Usuario o contraseña incorrectos."
            ) from exc

        user = auth_response.user
        session = auth_response.session

        if user is None or session is None:
            raise ValueError(
                "Usuario o contraseña incorrectos."
            )

        user_id = str(user.id)

        # =====================================================
        # 3. CONFIRMAR PERFIL
        # =====================================================

        profile_response = (
            supabase
            .table("profiles")
            .select("id")
            .eq("id", user_id)
            .limit(1)
            .execute()
        )

        if not profile_response.data:
            raise RuntimeError(
                "La cuenta no tiene un perfil ASTRA."
            )

        return {
            "access_token": session.access_token,
            "refresh_token": session.refresh_token,
            "token_type": "bearer",
            "user": {
                "id": user_id,
                "email": user.email,
            },
        }


auth_service = AuthService()