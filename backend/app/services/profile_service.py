from fastapi import HTTPException

from app.core.supabase import supabase
from app.schemas.astrology import AstrologyBirthRequest
from app.schemas.profile import ProfileUpsertRequest
from app.services.astrology_service import (
    AstrologyAPIError,
    astrology_service,
)


class ProfileService:
    async def upsert_profile(
        self,
        data: ProfileUpsertRequest,
    ) -> dict:

        birth = AstrologyBirthRequest(
            day=data.birth_date.day,
            month=data.birth_date.month,
            year=data.birth_date.year,
            hour=data.birth_hour,
            minute=data.birth_minute,
            lat=data.birth_lat,
            lon=data.birth_lon,
            timezone=data.birth_timezone,
        )

        try:
            horoscope = (
                await astrology_service.western_horoscope(
                    birth
                )
            )

            chart = (
                await astrology_service.western_chart_data(
                    birth
                )
            )

        except AstrologyAPIError as exc:
            raise HTTPException(
                status_code=502,
                detail=str(exc),
            ) from exc

        profile_record = {
            "id": data.user_id,
            "display_name": data.display_name,

            "birth_date":
                data.birth_date.isoformat(),

            "birth_hour":
                data.birth_hour,

            "birth_minute":
                data.birth_minute,

            "birth_place":
                data.birth_place,

            "birth_lat":
                data.birth_lat,

            "birth_lon":
                data.birth_lon,

            "birth_timezone":
                data.birth_timezone,
        }

        result = (
            supabase
            .table("profiles")
            .upsert(profile_record)
            .execute()
        )

        if not result.data:
            raise HTTPException(
                status_code=500,
                detail="No se pudo guardar el perfil.",
            )

        (
            supabase
            .table("natal_charts")
            .upsert(
                {
                    "profile_id":
                        data.user_id,

                    "chart_data":
                        chart,
                },
                on_conflict="profile_id",
            )
            .execute()
        )

        return {
            "profile": result.data[0],
            "horoscope": horoscope,
            "chart": chart,
        }

    def get_profile(
        self,
        user_id: str,
    ) -> dict:

        profile_result = (
            supabase
            .table("profiles")
            .select("*")
            .eq("id", user_id)
            .maybe_single()
            .execute()
        )

        if not profile_result.data:
            raise HTTPException(
                status_code=404,
                detail="Perfil no encontrado.",
            )

        profile = profile_result.data

        # =====================================================
        # FORMATO QUE ESPERA FLUTTER (ZodiacProfileModel)
        # =====================================================

        return {
            "id": profile["id"],

            "display_name":
                profile["display_name"],

            "username":
                profile.get("username"),

            "sign":
                profile["sun_sign"],

            "element":
                profile["element"],

            "modality":
                profile["modality"],

            "ruling_planet":
                profile["ruling_planet"],

            "sun": {
                "planet": "Sun",
                "sign":
                    profile["sun_sign"],
                "degree":
                    profile["sun_degree"],
                "house": None,
                "retrograde": False,
            },

            "moon": {
                "planet": "Moon",
                "sign":
                    profile["moon_sign"],
                "degree":
                    profile["moon_degree"],
                "house": None,
                "retrograde": False,
            },

            "rising": {
                "planet": "Ascendant",
                "sign":
                    profile["rising_sign"],
                "degree":
                    profile["rising_degree"],
                "house": 1,
                "retrograde": False,
            },

            "birth": {
                "date":
                    profile["birth_date"],
                "hour":
                    profile["birth_hour"],
                "minute":
                    profile["birth_minute"],
                "place":
                    profile["birth_place"],
                "lat":
                    profile["birth_lat"],
                "lon":
                    profile["birth_lon"],
                "timezone":
                    profile["birth_timezone"],
            },
        }


profile_service = ProfileService()