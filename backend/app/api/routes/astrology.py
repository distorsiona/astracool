from fastapi import APIRouter, HTTPException

from app.schemas.astrology import AstrologyBirthRequest
from app.services.astrology_service import (
    AstrologyAPIError,
    astrology_service,
)


router = APIRouter(
    prefix="/astrology",
    tags=["Astrology"],
)


@router.post("/western-horoscope")
async def get_western_horoscope(
    payload: AstrologyBirthRequest,
):
    try:
        return await astrology_service.western_horoscope(
            payload
        )

    except AstrologyAPIError as exc:
        raise HTTPException(
            status_code=502,
            detail=str(exc),
        ) from exc


@router.post("/chart-data")
async def get_chart_data(
    payload: AstrologyBirthRequest,
):
    try:
        return await astrology_service.western_chart_data(
            payload
        )

    except AstrologyAPIError as exc:
        raise HTTPException(
            status_code=502,
            detail=str(exc),
        ) from exc


@router.post("/natal-wheel")
async def get_natal_wheel(
    payload: AstrologyBirthRequest,
):
    try:
        return await astrology_service.natal_wheel_chart(
            payload
        )

    except AstrologyAPIError as exc:
        raise HTTPException(
            status_code=502,
            detail=str(exc),
        ) from exc

@router.post("/profile-summary")
async def get_profile_summary(
    payload: AstrologyBirthRequest,
):
    try:
        chart = (
            await astrology_service.western_horoscope(
                payload
            )
        )

        return astrology_service.build_profile_summary(
            chart
        )

    except AstrologyAPIError as exc:
        raise HTTPException(
            status_code=502,
            detail=str(exc),
        ) from exc