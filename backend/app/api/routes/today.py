from fastapi import (
    APIRouter,
    HTTPException,
)

from app.services.today_service import (
    today_service,
)


router = APIRouter(
    prefix="/today",
    tags=["Today"],
)


@router.get("/{user_id}")
async def get_today(
    user_id: str,
):
    try:
        return await today_service.get_today(
            user_id
        )

    except ValueError as exc:
        raise HTTPException(
            status_code=404,
            detail=str(exc),
        ) from exc

    except Exception as exc:
        print(
            "TODAY ERROR:",
            repr(exc),
        )

        raise HTTPException(
            status_code=500,
            detail=(
                "No fue posible cargar "
                "la información de hoy."
            ),
        ) from exc