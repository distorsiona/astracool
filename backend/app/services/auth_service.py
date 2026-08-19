from datetime import datetime
from zoneinfo import ZoneInfo

from supabase_auth.errors import AuthApiError

from app.core.supabase import (
    supabase_admin,
    supabase_auth,
)

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
    # ============================================================
    # REGISTER
    # ============================================================

    async def register(
        self,
        data: RegisterRequest,
    ) -> RegisterResponse:

        user_id: str | None = None
        profile_created = False

        # ========================================================
        # 1. NORMALIZAR DATOS
        # ========================================================

        email = data.email.lower().strip()
        username = data.username.lower().strip()
        full_name = data.full_name.strip()
        birth_place_query = data.birth_place.strip()

        print()
        print("========================================")
        print("INICIANDO REGISTRO ASTRA")
        print("========================================")

        print(
            "PASO 1 -> datos normalizados"
        )

        # ========================================================
        # 2. VALIDAR USERNAME
        # ========================================================

        username_result = (
            supabase
            .table("profiles")
            .select("id")
            .eq(
                "username",
                username,
            )
            .limit(1)
            .execute()
        )

        if username_result.data:
            raise ValueError(
                "El nombre de usuario ya está en uso."
            )

        print(
            "PASO 2 -> username disponible"
        )

        # ========================================================
        # 3. RESOLVER UBICACIÓN
        # ========================================================

        location_results = (
            await location_service.search(
                birth_place_query
            )
        )

        if not location_results:
            raise ValueError(
                "No fue posible encontrar el lugar "
                "de nacimiento."
            )

        location = location_results[0]

        birth_place = (
            location["display_name"]
        )

        birth_lat = float(
            location["lat"]
        )

        birth_lon = float(
            location["lon"]
        )

        timezone_name = location.get(
            "timezone_name"
        )

        if not timezone_name:
            raise RuntimeError(
                "No fue posible determinar la zona "
                "horaria del lugar de nacimiento."
            )

        print(
            "PASO 3 -> ubicación:",
            birth_place,
            birth_lat,
            birth_lon,
            timezone_name,
        )

        # ========================================================
        # 4. CALCULAR TIMEZONE HISTÓRICO
        # ========================================================

        birth_datetime = datetime(
            year=data.birth_date.year,
            month=data.birth_date.month,
            day=data.birth_date.day,
            hour=data.birth_time.hour,
            minute=data.birth_time.minute,
            second=data.birth_time.second,
        )

        try:
            timezone_info = ZoneInfo(
                timezone_name
            )
        except Exception as exc:
            raise RuntimeError(
                "La zona horaria obtenida no está "
                "disponible en el servidor."
            ) from exc

        localized_birth_datetime = (
            birth_datetime.replace(
                tzinfo=timezone_info,
            )
        )

        utc_offset = (
            localized_birth_datetime.utcoffset()
        )

        if utc_offset is None:
            raise RuntimeError(
                "No fue posible calcular la zona "
                "horaria histórica de nacimiento."
            )

        birth_timezone = (
            utc_offset.total_seconds()
            / 3600
        )

        print(
            "PASO 4 -> timezone offset:",
            birth_timezone,
        )

        # ========================================================
        # 5. CONSTRUIR REQUEST ASTROLÓGICO
        # ========================================================

        birth_request = (
            AstrologyBirthRequest(
                day=data.birth_date.day,
                month=data.birth_date.month,
                year=data.birth_date.year,
                hour=data.birth_time.hour,
                minute=data.birth_time.minute,
                lat=birth_lat,
                lon=birth_lon,
                timezone=birth_timezone,
            )
        )

        print(
            "PASO 5 -> solicitando carta astral"
        )

        # ========================================================
        # 6. CONSULTAR ASTROLOGY API
        # ========================================================

        chart = (
            await astrology_service
            .western_horoscope(
                birth_request
            )
        )

        if not isinstance(
            chart,
            dict,
        ):
            raise RuntimeError(
                "AstrologyAPI devolvió una carta "
                "astral inválida."
            )

        print(
            "PASO 6 -> carta astral obtenida"
        )

        # ========================================================
        # 7. ANALIZAR CARTA
        # ========================================================

        analysis = astra_service.analyze(
            chart
        )

        big_three = analysis.get(
            "big_three",
            {},
        )

        zodiac = analysis.get(
            "zodiac",
            {},
        )

        sun = big_three.get(
            "sun"
        )

        moon = big_three.get(
            "moon"
        )

        rising = big_three.get(
            "rising"
        )

        if not sun:
            raise RuntimeError(
                "No fue posible calcular el Sol."
            )

        if not moon:
            raise RuntimeError(
                "No fue posible calcular la Luna."
            )

        if not rising:
            raise RuntimeError(
                "No fue posible calcular el Ascendente."
            )

        print(
            "PASO 7 -> análisis ASTRA:",
            {
                "sun": sun,
                "moon": moon,
                "rising": rising,
                "zodiac": zodiac,
            },
        )

        # ========================================================
        # 8. CREAR USUARIO SUPABASE AUTH
        # ========================================================

        try:
            auth_response = (
                supabase
                .auth
                .admin
                .create_user(
                    {
                        "email": email,
                        "password": data.password,
                        "email_confirm": True,
                        "user_metadata": {
                            "display_name":
                                full_name,
                            "username":
                                username,
                        },
                    }
                )
            )

        except AuthApiError as exc:
            print(
                "ERROR SUPABASE CREATE USER:",
                repr(exc),
            )

            message = str(exc).lower()

            if (
                "already" in message
                or "registered" in message
                or "exists" in message
            ):
                raise ValueError(
                    "Ya existe una cuenta con ese correo."
                ) from exc

            raise RuntimeError(
                "No fue posible crear la cuenta "
                "en Supabase Auth."
            ) from exc

        user = auth_response.user

        if user is None:
            raise RuntimeError(
                "Supabase no devolvió el usuario creado."
            )

        user_id = str(
            user.id
        )

        print(
            "PASO 8 -> usuario Auth creado:",
            user_id,
        )

        # ========================================================
        # 9. PREPARAR PROFILE
        # ========================================================

        profile_data = {
            "id":
                user_id,

            "display_name":
                full_name,

            "username":
                username,

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

            "sun_sign":
                sun.get(
                    "sign",
                    "",
                ),

            "sun_degree":
                float(
                    sun.get(
                        "degree",
                        0,
                    )
                    or 0
                ),

            "moon_sign":
                moon.get(
                    "sign",
                    "",
                ),

            "moon_degree":
                float(
                    moon.get(
                        "degree",
                        0,
                    )
                    or 0
                ),

            "rising_sign":
                rising.get(
                    "sign",
                    "",
                ),

            "rising_degree":
                float(
                    rising.get(
                        "degree",
                        0,
                    )
                    or 0
                ),

            "element":
                zodiac.get(
                    "element",
                ),

            "modality":
                zodiac.get(
                    "modality",
                ),

            "ruling_planet":
                zodiac.get(
                    "ruling_planet",
                ),
        }

        print(
            "PASO 9 -> profile preparado:",
            profile_data,
        )

        # ========================================================
        # 10. GUARDAR PROFILE
        # ========================================================

        try:
            profile_response = (
                supabase
                .table("profiles")
                .insert(
                    profile_data
                )
                .execute()
            )

            if not profile_response.data:
                raise RuntimeError(
                    "Supabase no devolvió "
                    "el perfil creado."
                )

            profile_created = True

        except Exception as exc:
            print(
                "ERROR GUARDANDO PROFILE:",
                repr(exc),
            )

            await self._rollback_register(
                user_id=user_id,
                delete_profile=False,
            )

            raise RuntimeError(
                "No se pudo crear el perfil ASTRA."
            ) from exc

        print(
            "PASO 10 -> perfil creado correctamente"
        )

        # ========================================================
        # 11. PREPARAR NATAL CHART
        # ========================================================

        natal_chart_data = {
            "profile_id":
                user_id,

            "chart_data": {
                "big_three":
                    analysis.get(
                        "big_three",
                        {},
                    ),

                "zodiac":
                    analysis.get(
                        "zodiac",
                        {},
                    ),

                "planets":
                    analysis.get(
                        "planets",
                        [],
                    ),

                "houses":
                    chart.get(
                        "houses",
                        [],
                    ),

                "aspects":
                    chart.get(
                        "aspects",
                        [],
                    ),

                "dominant_aspects":
                    analysis.get(
                        "dominant_aspects",
                        [],
                    ),

                # Datos RAW útiles para
                # ChartScreen y futuras features.

                "ascendant":
                    chart.get(
                        "ascendant"
                    ),

                "midheaven":
                    chart.get(
                        "midheaven"
                    ),

                "vertex":
                    chart.get(
                        "vertex"
                    ),

                "lilith":
                    chart.get(
                        "lilith"
                    ),
            },
        }

        print(
            "PASO 11 -> natal chart preparado"
        )

        # ========================================================
        # 12. GUARDAR NATAL CHART
        # ========================================================

        try:
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
                    "Supabase no devolvió "
                    "la carta natal creada."
                )

        except Exception as exc:
            print(
                "ERROR GUARDANDO NATAL CHART:",
                repr(exc),
            )

            await self._rollback_register(
                user_id=user_id,
                delete_profile=profile_created,
            )

            raise RuntimeError(
                "No se pudo guardar la carta natal."
            ) from exc

        print(
            "PASO 12 -> carta natal guardada correctamente"
        )

        # ========================================================
        # 13. RESPUESTA REGISTER
        # ========================================================

        print(
            "REGISTRO ASTRA COMPLETADO"
        )
        print(
            "========================================"
        )
        print()

        return RegisterResponse(
            message=(
                "Usuario creado correctamente."
            ),
            user=UserProfileResponse(
                id=user_id,
                full_name=full_name,
                username=username,
                email=email,
                birth_date=data.birth_date,
                birth_time=data.birth_time,
                birth_place=birth_place,
            ),
        )

    # ============================================================
    # LOGIN
    # ============================================================

    async def login(
        self,
        identifier: str,
        password: str,
    ) -> dict:

        identifier = (
            identifier
            .strip()
            .lower()
        )

        if not identifier:
            raise ValueError(
                "Ingresa tu correo o nombre de usuario."
            )

        if not password:
            raise ValueError(
                "Ingresa tu contraseña."
            )

        print()
        print(
            "========================================"
        )
        print(
            "INICIANDO LOGIN ASTRA"
        )
        print(
            "IDENTIFIER:",
            identifier,
        )
        print(
            "========================================"
        )

        # ========================================================
        # 1. RESOLVER EMAIL
        # ========================================================

        if "@" in identifier:
            email = identifier

            print(
                "LOGIN -> identificador es email"
            )

        else:
            print(
                "LOGIN -> buscando username:",
                identifier,
            )

            profile_response = (
                supabase
                .table("profiles")
                .select("id")
                .eq(
                    "username",
                    identifier,
                )
                .limit(1)
                .execute()
            )

            if not profile_response.data:
                raise ValueError(
                    "Usuario o contraseña incorrectos."
                )

            resolved_user_id = (
                profile_response
                .data[0]["id"]
            )

            try:
                auth_user_response = (
                    supabase
                    .auth
                    .admin
                    .get_user_by_id(
                        resolved_user_id
                    )
                )

            except AuthApiError as exc:
                print(
                    "ERROR BUSCANDO USER AUTH:",
                    repr(exc),
                )

                raise ValueError(
                    "Usuario o contraseña incorrectos."
                ) from exc

            auth_user = (
                auth_user_response.user
            )

            if (
                auth_user is None
                or not auth_user.email
            ):
                raise ValueError(
                    "Usuario o contraseña incorrectos."
                )

            email = (
                auth_user.email
                .strip()
                .lower()
            )

            print(
                "LOGIN -> username resuelto a:",
                email,
            )

        # ========================================================
        # 2. LOGIN SUPABASE
        # ========================================================

        try:
            auth_response = (
                supabase
                .auth
                .sign_in_with_password(
                    {
                        "email": email,
                        "password": password,
                    }
                )
            )

        except AuthApiError as exc:
            code = getattr(
                exc,
                "code",
                None,
            )

            status = getattr(
                exc,
                "status",
                None,
            )

            message = str(exc)

            print()
            print(
                "========== SUPABASE AUTH ERROR =========="
            )
            print(
                "TYPE:",
                type(exc).__name__,
            )
            print(
                "MESSAGE:",
                message,
            )
            print(
                "CODE:",
                code,
            )
            print(
                "STATUS:",
                status,
            )
            print(
                "ARGS:",
                exc.args,
            )
            print(
                "REPR:",
                repr(exc),
            )
            print(
                "========================================="
            )
            print()

            normalized_code = (
                str(code or "")
                .lower()
            )

            normalized_message = (
                message.lower()
            )

            # ----------------------------------------------------
            # EMAIL NO CONFIRMADO
            # ----------------------------------------------------

            if (
                normalized_code
                == "email_not_confirmed"
                or "email not confirmed"
                in normalized_message
            ):
                raise ValueError(
                    "Tu correo todavía no está confirmado."
                ) from exc

            # ----------------------------------------------------
            # USUARIO BLOQUEADO
            # ----------------------------------------------------

            if (
                normalized_code
                == "user_banned"
                or "banned"
                in normalized_message
            ):
                raise ValueError(
                    "Esta cuenta está temporalmente bloqueada."
                ) from exc

            # ----------------------------------------------------
            # USER NOT ALLOWED
            # ----------------------------------------------------

            if (
                "user not allowed"
                in normalized_message
            ):
                raise ValueError(
                    "Supabase no permite iniciar sesión "
                    "con esta cuenta en este momento."
                ) from exc

            # ----------------------------------------------------
            # CREDENCIALES INCORRECTAS
            # ----------------------------------------------------

            if (
                normalized_code
                == "invalid_credentials"
                or "invalid login"
                in normalized_message
                or "invalid credentials"
                in normalized_message
            ):
                raise ValueError(
                    "Usuario o contraseña incorrectos."
                ) from exc

            # No filtramos el error real
            # silenciosamente durante desarrollo.
            raise ValueError(
                "No fue posible iniciar sesión. "
                f"Supabase: {message}"
            ) from exc

        except Exception as exc:
            print(
                "LOGIN ERROR INESPERADO:",
                repr(exc),
            )

            raise RuntimeError(
                "No fue posible comunicarse "
                "correctamente con Supabase Auth."
            ) from exc

        # ========================================================
        # 3. VALIDAR SESSION
        # ========================================================

        user = auth_response.user
        session = auth_response.session

        if (
            user is None
            or session is None
        ):
            raise ValueError(
                "Usuario o contraseña incorrectos."
            )

        user_id = str(
            user.id
        )

        print(
            "LOGIN AUTH OK ->",
            user_id,
        )

        # ========================================================
        # 4. CONFIRMAR PROFILE ASTRA
        # ========================================================

        profile_response = (
            supabase
            .table("profiles")
            .select(
                "id,"
                "display_name,"
                "username"
            )
            .eq(
                "id",
                user_id,
            )
            .limit(1)
            .execute()
        )

        if not profile_response.data:
            raise RuntimeError(
                "La cuenta existe, pero no tiene "
                "un perfil ASTRA asociado."
            )

        profile = (
            profile_response.data[0]
        )

        print(
            "LOGIN PROFILE OK ->",
            profile,
        )

        print(
            "LOGIN ASTRA COMPLETADO"
        )
        print(
            "========================================"
        )
        print()

        # ========================================================
        # 5. RESPUESTA
        # ========================================================

        return {
            "access_token":
                session.access_token,

            "refresh_token":
                session.refresh_token,

            "token_type":
                "bearer",

            "user": {
                "id":
                    user_id,

                "email":
                    user.email,

                "username":
                    profile.get(
                        "username"
                    ),

                "display_name":
                    profile.get(
                        "display_name"
                    ),
            },
        }

    # ============================================================
    # ROLLBACK REGISTER
    # ============================================================

    async def _rollback_register(
        self,
        user_id: str | None,
        delete_profile: bool,
    ) -> None:

        if not user_id:
            return

        print(
            "INICIANDO ROLLBACK:",
            user_id,
        )

        # ========================================================
        # ELIMINAR NATAL CHART
        # ========================================================

        try:
            (
                supabase
                .table("natal_charts")
                .delete()
                .eq(
                    "profile_id",
                    user_id,
                )
                .execute()
            )

        except Exception as exc:
            print(
                "ROLLBACK NATAL_CHART ERROR:",
                repr(exc),
            )

        # ========================================================
        # ELIMINAR PROFILE
        # ========================================================

        if delete_profile:
            try:
                (
                    supabase
                    .table("profiles")
                    .delete()
                    .eq(
                        "id",
                        user_id,
                    )
                    .execute()
                )

            except Exception as exc:
                print(
                    "ROLLBACK PROFILE ERROR:",
                    repr(exc),
                )

        # ========================================================
        # ELIMINAR AUTH USER
        # ========================================================

        try:
            (
                supabase
                .auth
                .admin
                .delete_user(
                    user_id
                )
            )

        except Exception as exc:
            print(
                "ROLLBACK AUTH USER ERROR:",
                repr(exc),
            )


auth_service = AuthService()