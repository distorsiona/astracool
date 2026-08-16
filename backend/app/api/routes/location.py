from fastapi import APIRouter, HTTPException, Query

from app.services.location_service import (
    location_service,
)


router = APIRouter(
    prefix="/locations",
    tags=["Locations"],
)


@router.get("/search")
async def search_location(
    q: str = Query(
        ...,
        min_length=2,
    ),
):
    try:
        return await location_service.search(q)

    except Exception as exc:
        raise HTTPException(
            status_code=502,
            detail="No fue posible buscar la ubicación.",
        ) from exc


@router.get("/reverse")
async def reverse_location(
    lat: float,
    lon: float,
):
    try:
        return await location_service.reverse(
            lat,
            lon,
        )

    except Exception as exc:
        raise HTTPException(
            status_code=502,
            detail="No fue posible obtener la ubicación.",
        ) from exc