import traceback

from fastapi import (
    APIRouter,
    HTTPException,
    status,
)

from app.schemas.auth import (
    LoginRequest,
    LoginResponse,
    RegisterRequest,
    RegisterResponse,
)

from app.services.auth_service import (
    auth_service,
)


router = APIRouter(
    prefix="/auth",
    tags=["Auth"],
)


# ============================================================
# REGISTER
# ============================================================

@router.post(
    "/register",
    response_model=RegisterResponse,
    status_code=status.HTTP_201_CREATED,
)
async def register(
    data: RegisterRequest,
) -> RegisterResponse:
    try:
        print(
            "\n================ REGISTER ================="
        )
        print(
            data.model_dump()
        )
        print(
            "===========================================\n"
        )

        return await auth_service.register(
            data
        )

    except ValueError as exc:
        traceback.print_exc()

        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail=str(exc),
        ) from exc

    except Exception as exc:
        traceback.print_exc()

        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail={
                "type":
                    type(exc).__name__,

                "message":
                    str(exc),
            },
        ) from exc


# ============================================================
# LOGIN
# ============================================================

@router.post(
    "/login",
    response_model=LoginResponse,
)
async def login(
    data: LoginRequest,
) -> LoginResponse:
    try:
        result = await auth_service.login(
            identifier=data.identifier,
            password=data.password,
        )

        return LoginResponse(
            **result
        )

    except ValueError as exc:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=str(exc),
        ) from exc

    except Exception as exc:
        traceback.print_exc()

        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail={
                "type":
                    type(exc).__name__,

                "message":
                    str(exc),
            },
        ) from exc