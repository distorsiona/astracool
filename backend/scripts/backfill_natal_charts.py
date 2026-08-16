import asyncio

from app.core.supabase import supabase
from app.schemas.astrology import AstrologyBirthRequest
from app.services.astrology_service import astrology_service
from app.services.astra_service import astra_service


async def backfill_natal_charts():
    # =========================================================
    # 1. TRAER PERFILES
    # =========================================================

    profiles_response = (
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
            "birth_timezone"
        )
        .execute()
    )

    profiles = profiles_response.data or []

    print(
        f"Perfiles encontrados: {len(profiles)}"
    )

    created = 0
    skipped = 0
    failed = 0

    # =========================================================
    # 2. PROCESAR CADA PERFIL
    # =========================================================

    for profile in profiles:
        profile_id = profile["id"]

        display_name = (
            profile.get("display_name")
            or profile_id
        )

        print()
        print(
            "========================================"
        )
        print(
            f"Procesando: {display_name}"
        )
        print(
            f"Profile ID: {profile_id}"
        )

        try:
            # =================================================
            # 3. VER SI YA TIENE CARTA
            # =================================================

            existing_response = (
                supabase
                .table("natal_charts")
                .select("id")
                .eq(
                    "profile_id",
                    profile_id,
                )
                .limit(1)
                .execute()
            )

            if existing_response.data:
                print(
                    "SKIP -> ya tiene natal_chart"
                )

                skipped += 1
                continue

            # =================================================
            # 4. VALIDAR DATOS DE NACIMIENTO
            # =================================================

            birth_date_raw = profile.get(
                "birth_date"
            )

            birth_hour = profile.get(
                "birth_hour"
            )

            birth_minute = profile.get(
                "birth_minute"
            )

            birth_lat = profile.get(
                "birth_lat"
            )

            birth_lon = profile.get(
                "birth_lon"
            )

            birth_timezone = profile.get(
                "birth_timezone"
            )

            required_values = {
                "birth_date": birth_date_raw,
                "birth_hour": birth_hour,
                "birth_minute": birth_minute,
                "birth_lat": birth_lat,
                "birth_lon": birth_lon,
                "birth_timezone": birth_timezone,
            }

            missing = [
                key
                for key, value
                in required_values.items()
                if value is None
            ]

            if missing:
                raise ValueError(
                    "Faltan datos de nacimiento: "
                    + ", ".join(missing)
                )

            # =================================================
            # 5. PARSEAR FECHA
            # =================================================

            year, month, day = map(
                int,
                str(
                    birth_date_raw
                ).split("-"),
            )

            # =================================================
            # 6. CONSTRUIR REQUEST ASTROLÓGICO
            # =================================================

            birth_request = AstrologyBirthRequest(
                day=day,
                month=month,
                year=year,
                hour=int(
                    birth_hour
                ),
                minute=int(
                    birth_minute
                ),
                lat=float(
                    birth_lat
                ),
                lon=float(
                    birth_lon
                ),
                timezone=float(
                    birth_timezone
                ),
            )

            print(
                "Solicitando carta..."
            )

            # =================================================
            # 7. CALCULAR CARTA
            # =================================================

            chart = (
                await astrology_service
                .western_horoscope(
                    birth_request
                )
            )

            analysis = astra_service.analyze(
                chart
            )

            # =================================================
            # 8. PREPARAR CHART_DATA
            # =================================================

            chart_data = {
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
            }

            # =================================================
            # 9. GUARDAR
            # =================================================

            insert_response = (
                supabase
                .table("natal_charts")
                .insert(
                    {
                        "profile_id":
                            profile_id,

                        "chart_data":
                            chart_data,
                    }
                )
                .execute()
            )

            if not insert_response.data:
                raise RuntimeError(
                    "Supabase no devolvió la carta creada."
                )

            created += 1

            print(
                "OK -> natal chart creada"
            )

            print(
                "Planetas:",
                len(
                    chart_data["planets"]
                ),
            )

            print(
                "Casas:",
                len(
                    chart_data["houses"]
                ),
            )

            print(
                "Aspectos:",
                len(
                    chart_data["aspects"]
                ),
            )

        except Exception as exc:
            failed += 1

            print(
                "ERROR ->",
                repr(exc),
            )

    # =========================================================
    # RESUMEN
    # =========================================================

    print()
    print(
        "========================================"
    )
    print(
        "BACKFILL TERMINADO"
    )
    print(
        "========================================"
    )
    print(
        f"Creadas: {created}"
    )
    print(
        f"Ya existentes: {skipped}"
    )
    print(
        f"Fallidas: {failed}"
    )


if __name__ == "__main__":
    asyncio.run(
        backfill_natal_charts()
    )