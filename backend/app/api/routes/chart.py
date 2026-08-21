# from fastapi import (
#     APIRouter,
#     HTTPException,
#     Path,
# )

# from app.services.chart_service import (
#     chart_service,
# )


# router = APIRouter(
#     prefix="/chart",
#     tags=["Chart"],
# )


# # ============================================================
# # obtener la carta completa de una persona
# # ============================================================

# @router.get("/{user_id}")
# async def get_chart(
#     user_id: str,
# ):
#     try:
#         return chart_service.get_chart(
#             user_id
#         )

#     except HTTPException:
#         raise

#     except Exception as exc:
#         print(
#             "chart error:",
#             repr(exc),
#         )

#         raise HTTPException(
#             status_code=500,
#             detail=(
#                 "No fue posible cargar "
#                 "la carta natal."
#             ),
#         ) from exc


# # ============================================================
# # obtener el detalle de una casa específica
# #
# # ejemplo:
# #
# # /chart/user-id/chart-id/houses/1
# #
# # esto devuelve solamente la casa 1
# # de la carta de esa persona.
# # ============================================================

# @router.get(
#     "/{user_id}/{chart_id}/houses/{house_number}"
# )
# async def get_chart_house(
#     user_id: str,
#     chart_id: str,
#     house_number: int = Path(
#         ...,
#         ge=1,
#         le=12,
#     ),
# ):
#     try:
#         return chart_service.get_house_detail(
#             user_id=user_id,
#             chart_id=chart_id,
#             house_number=house_number,
#         )

#     except HTTPException:
#         raise

#     except Exception as exc:
#         print(
#             "chart house error:",
#             repr(exc),
#         )

#         raise HTTPException(
#             status_code=500,
#             detail=(
#                 "No fue posible cargar "
#                 "la información de esta casa."
#             ),
#         ) from exc





import traceback
from typing import Optional

from fastapi import (
    APIRouter,
    HTTPException,
    Path,
)

from app.services.chart_service import (
    chart_service,
)


router = APIRouter(
    prefix="/chart",
    tags=["Chart"],
)


# ============================================================
# obtener la carta completa de una persona
# ============================================================

@router.get("/{user_id}")
async def get_chart(
    user_id: str,
    lang: Optional[str] = None,
):
    try:
        return await chart_service.get_chart(
            user_id,
            lang=lang,
        )

    except HTTPException:
        raise

    except Exception as exc:
        print(
            "chart error:",
            repr(exc),
        )

        traceback.print_exc()

        raise HTTPException(
            status_code=500,
            detail=(
                "No fue posible cargar "
                "la carta natal."
            ),
        ) from exc


# ============================================================
# obtener una casa específica de la carta
#
# recibe:
# user_id      -> persona dueña de la carta
# chart_id     -> carta natal que estamos leyendo
# house_number -> casa que queremos abrir, del 1 al 12
# ============================================================

@router.get(
    "/{user_id}/{chart_id}/houses/{house_number}"
)
async def get_chart_house(
    user_id: str,
    chart_id: str,
    house_number: int = Path(
        ...,
        ge=1,
        le=12,
    ),
):
    try:
        return chart_service.get_house_detail(
            user_id=user_id,
            chart_id=chart_id,
            house_number=house_number,
        )

    except HTTPException:
        raise

    except Exception as exc:
        print(
            "chart house error:",
            repr(exc),
        )

        # esto imprime exactamente
        # en qué línea ocurrió el error
        traceback.print_exc()

        raise HTTPException(
            status_code=500,

            # esto es solamente para debug.
            # después lo volvemos a dejar con
            # un mensaje bonito para el usuario.
            detail=str(exc),
        ) from exc