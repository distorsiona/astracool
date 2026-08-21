import hashlib
import secrets
import traceback

from datetime import (
    datetime,
    timedelta,
    timezone,
)

from fastapi import (
    APIRouter,
    HTTPException,
    status,
)
from pydantic import BaseModel

from app.core.supabase import supabase_admin

from app.schemas.auth import (
    LoginRequest,
    LoginResponse,
    RegisterRequest,
    RegisterResponse,
)

from app.services.auth_service import (
    auth_service,
)

from app.services.email_service import (
    EmailServiceError,
    send_verification_email,
)


router = APIRouter(
    prefix="/auth",
    tags=["Auth"],
)


# ============================================================
# REQUEST MODELS
# ============================================================

class EmailVerificationSendRequest(BaseModel):
    user_id: str


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


# ============================================================
# SEND EMAIL VERIFICATION
#
# POST /api/auth/email/verification/send
# ============================================================

@router.post(
    "/email/verification/send",
    summary="Send email verification",
)
async def send_email_verification(
    payload: EmailVerificationSendRequest,
):
    try:
        # ========================================================
        # 1. OBTENER PERFIL
        # ========================================================

        profile_response = (
            supabase_admin
            .table("profiles")
            .select(
                "id,"
                "display_name,"
                "email_verified"
            )
            .eq(
                "id",
                payload.user_id,
            )
            .limit(1)
            .execute()
        )

        if not profile_response.data:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=(
                    "No existe un perfil "
                    "asociado a este usuario."
                ),
            )

        profile = profile_response.data[0]

        # ========================================================
        # 2. SI YA ESTÁ VERIFICADO, NO ENVIAR OTRO
        # ========================================================

        if profile.get("email_verified") is True:
            return {
                "message":
                    "El correo ya está verificado.",

                "email_verified":
                    True,
            }

        # ========================================================
        # 3. OBTENER EMAIL DESDE SUPABASE AUTH
        # ========================================================

        try:
            auth_response = (
                supabase_admin
                .auth
                .admin
                .get_user_by_id(
                    payload.user_id
                )
            )

            auth_user = auth_response.user

        except Exception as exc:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=(
                    "No fue posible obtener "
                    "la cuenta del usuario."
                ),
            ) from exc

        if (
            auth_user is None
            or not auth_user.email
        ):
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=(
                    "La cuenta no tiene "
                    "un correo válido."
                ),
            )

        # ========================================================
        # 4. INVALIDAR TOKENS DE VERIFICACIÓN ANTERIORES
        # ========================================================

        now = datetime.now(
            timezone.utc
        )

        (
            supabase_admin
            .table(
                "email_action_tokens"
            )
            .update({
                "used_at":
                    now.isoformat(),
            })
            .eq(
                "user_id",
                payload.user_id,
            )
            .eq(
                "action",
                "verify_email",
            )
            .is_(
                "used_at",
                "null",
            )
            .execute()
        )

        # ========================================================
        # 5. GENERAR TOKEN SEGURO
        # ========================================================

        token = secrets.token_urlsafe(
            48
        )

        # ========================================================
        # 6. GENERAR HASH
        #
        # SOLO guardamos el hash.
        # El token real solamente viaja por correo.
        # ========================================================

        token_hash = hashlib.sha256(
            token.encode(
                "utf-8"
            )
        ).hexdigest()

        # ========================================================
        # 7. EXPIRACIÓN
        # ========================================================

        expires_at = (
            now
            + timedelta(
                minutes=30
            )
        )

        # ========================================================
        # 8. GUARDAR TOKEN
        # ========================================================

        insert_response = (
            supabase_admin
            .table(
                "email_action_tokens"
            )
            .insert({
                "user_id":
                    payload.user_id,

                "token_hash":
                    token_hash,

                "action":
                    "verify_email",

                "expires_at":
                    expires_at.isoformat(),
            })
            .execute()
        )

        if not insert_response.data:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=(
                    "No fue posible crear "
                    "el token de verificación."
                ),
            )

        # ========================================================
        # 9. ENVIAR CORREO MEDIANTE BREVO
        # ========================================================

        try:
            await send_verification_email(
                recipient_email=
                    auth_user.email,

                recipient_name=
                    profile.get(
                        "display_name"
                    ),

                token=
                    token,
            )

        except EmailServiceError as exc:
            print(
                "EMAIL VERIFICATION "
                "BREVO ERROR:",
                repr(exc),
            )

            # marcamos el token como usado para que un token cuyo
            # correo nunca salió no quede activo.
            (
                supabase_admin
                .table(
                    "email_action_tokens"
                )
                .update({
                    "used_at":
                        datetime.now(
                            timezone.utc
                        ).isoformat(),
                })
                .eq(
                    "token_hash",
                    token_hash,
                )
                .execute()
            )

            raise HTTPException(
                status_code=status.HTTP_502_BAD_GATEWAY,
                detail=(
                    "No fue posible enviar "
                    "el correo de verificación."
                ),
            ) from exc

        # ========================================================
        # 10. RESPONSE
        # ========================================================

        return {
            "message": (
                "Correo de verificación "
                "enviado correctamente."
            ),
            "email_verified":
                False,
        }

    except HTTPException:
        raise

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