from fastapi import (
    APIRouter,
    HTTPException,
)

from app.services.chart_service import (
    chart_service,
)


router = APIRouter(
    prefix="/chart",
    tags=["Chart"],
)


@router.get("/{user_id}")
async def get_chart(
    user_id: str,
):
    try:
        return chart_service.get_chart(
            user_id
        )

    except HTTPException:
        raise

    except Exception as exc:
        print(
            "CHART ERROR:",
            repr(exc),
        )

        raise HTTPException(
            status_code=500,
            detail=(
                "No fue posible cargar "
                "la carta natal."
            ),
        ) from exc