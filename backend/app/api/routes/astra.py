from fastapi import (
    APIRouter,
    HTTPException,
)

from app.schemas.astrology import (
    AstrologyBirthRequest,
)

from app.services.astrology_service import (
    AstrologyAPIError,
    astrology_service,
)

from app.services.astra_service import (
    astra_service,
)


router = APIRouter(
    prefix="/astra",
    tags=["Astra"],
)


@router.post("/profile-analysis")
async def profile_analysis(
    payload: AstrologyBirthRequest,
):
    try:
        chart = (
            await astrology_service
            .western_horoscope(
                payload
            )
        )

        return astra_service.analyze(
            chart
        )

    except AstrologyAPIError as exc:
        raise HTTPException(
            status_code=502,
            detail=str(exc),
        ) from exc

    except ValueError as exc:
        raise HTTPException(
            status_code=422,
            detail=str(exc),
        ) from exc