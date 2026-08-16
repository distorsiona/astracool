from fastapi import APIRouter

from app.schemas.profile import ProfileUpsertRequest
from app.services.profile_service import profile_service


router = APIRouter(
    prefix="/profile",
    tags=["Profile"],
)


@router.put("")
async def upsert_profile(
    payload: ProfileUpsertRequest,
):
    return await profile_service.upsert_profile(
        payload
    )


@router.get("/{user_id}")
async def get_profile(
    user_id: str,
):
    return profile_service.get_profile(
        user_id
    )
