from datetime import (
    date,
    datetime,
    time,
)
from typing import Optional

from fastapi import (
    APIRouter,
    HTTPException,
)
from pydantic import (
    BaseModel,
    EmailStr,
    Field,
)

from app.core.supabase import supabase_admin


router = APIRouter(
    prefix="/account-profile",
    tags=["Account Profile"],
)


# ============================================================
# RESPONSE MODELS
# ============================================================

class BirthInformationResponse(BaseModel):
    birth_date: Optional[date] = None
    birth_time: Optional[str] = None
    birth_place: Optional[str] = None


class AccountInformationResponse(BaseModel):
    email: Optional[str] = None
    username: Optional[str] = None
    member_since: Optional[datetime] = None


class AccountPreferencesResponse(BaseModel):
    """
    Por ahora son valores de presentación/default.

    El idioma actualmente se persiste localmente en Flutter
    mediante SharedPreferences.

    Theme y notifications todavía no están persistidos
    en Supabase.
    """

    language: str = "en"
    theme: str = "light"
    notifications_enabled: bool = True


class AccountProfileResponse(BaseModel):
    user_id: str
    display_name: str
    initials: str
    zodiac_sign: Optional[str] = None
    birth: BirthInformationResponse
    account: AccountInformationResponse
    preferences: AccountPreferencesResponse


# ============================================================
# UPDATE MODELS
# ============================================================

class UpdateAccountProfileRequest(BaseModel):
    """
    Campos editables desde Account Settings.

    NO modifica información de nacimiento ni datos astrológicos.
    """

    display_name: Optional[str] = Field(
        default=None,
        min_length=1,
        max_length=100,
    )

    username: Optional[str] = Field(
        default=None,
        min_length=3,
        max_length=40,
    )

    email: Optional[EmailStr] = None


class UpdateAccountProfileResponse(BaseModel):
    message: str
    display_name: str
    initials: str
    username: Optional[str] = None
    email: Optional[str] = None


# ============================================================
# HELPERS
# ============================================================

def build_initials(
    display_name: str,
) -> str:
    clean_name = display_name.strip()

    if not clean_name:
        return "?"

    parts = [
        part
        for part in clean_name.split()
        if part
    ]

    if not parts:
        return "?"

    if len(parts) == 1:
        return parts[0][0].upper()

    return (
        parts[0][0]
        + parts[-1][0]
    ).upper()


def build_birth_time(
    hour,
    minute,
) -> Optional[str]:
    if hour is None:
        return None

    try:
        parsed_hour = int(hour)
        parsed_minute = int(minute or 0)

        value = time(
            hour=parsed_hour,
            minute=parsed_minute,
        )

        return value.strftime("%H:%M")

    except (
        TypeError,
        ValueError,
    ):
        return None


def parse_date(
    value,
) -> Optional[date]:
    if value is None:
        return None

    if isinstance(value, date):
        return value

    try:
        return date.fromisoformat(str(value))

    except ValueError:
        return None


def parse_datetime(
    value,
) -> Optional[datetime]:
    if value is None:
        return None

    if isinstance(value, datetime):
        return value

    try:
        return datetime.fromisoformat(
            str(value).replace(
                "Z",
                "+00:00",
            )
        )

    except ValueError:
        return None


def normalize_display_name(
    value: str,
) -> str:
    return " ".join(
        value.strip().split()
    )


def normalize_username(
    value: str,
) -> str:
    return (
        value
        .strip()
        .lower()
    )


# ============================================================
# GET ACCOUNT PROFILE
#
# GET /api/account-profile/{user_id}
# ============================================================

@router.get(
    "/{user_id}",
    response_model=AccountProfileResponse,
    summary="Get account profile",
)
async def get_account_profile(
    user_id: str,
) -> AccountProfileResponse:
    try:
        # ========================================================
        # 1. PROFILE
        # ========================================================

        profile_response = (
            supabase_admin
            .table("profiles")
            .select(
                "id,"
                "display_name,"
                "username,"
                "email,"
                "email_verified,"
                "email_verified_at,"
                "birth_date,"
                "birth_hour,"
                "birth_minute,"
                "birth_place,"
                "sun_sign,"
                "created_at"
            )
            .eq(
                "id",
                user_id,
            )
            .limit(1)
            .execute()
        )

        if not profile_response.data:
            raise HTTPException(
                status_code=404,
                detail=(
                    "No existe un perfil "
                    "asociado a este usuario."
                ),
            )

        profile = profile_response.data[0]

        # ========================================================
        # 2. AUTH USER
        # ========================================================

        try:
            auth_response = (
                supabase_admin
                .auth
                .admin
                .get_user_by_id(user_id)
            )

            auth_user = auth_response.user

        except Exception as exc:
            raise HTTPException(
                status_code=500,
                detail=(
                    "No fue posible obtener "
                    "la información de la cuenta."
                ),
            ) from exc

        if auth_user is None:
            raise HTTPException(
                status_code=404,
                detail=(
                    "No existe el usuario "
                    "en Supabase Auth."
                ),
            )

        # ========================================================
        # 3. DISPLAY NAME
        # ========================================================

        display_name = str(
            profile.get("display_name")
            or ""
        ).strip()

        if not display_name:
            display_name = "Sacred User"

        # ========================================================
        # 4. BIRTH INFO
        # ========================================================

        birth_time = build_birth_time(
            profile.get("birth_hour"),
            profile.get("birth_minute"),
        )

        # ========================================================
        # 5. MEMBER SINCE
        # ========================================================

        member_since = parse_datetime(
            profile.get("created_at")
        )

        if (
            member_since is None
            and getattr(
                auth_user,
                "created_at",
                None,
            ) is not None
        ):
            member_since = parse_datetime(
                auth_user.created_at
            )

        # ========================================================
        # 6. RESPONSE
        # ========================================================

        return AccountProfileResponse(
            user_id=user_id,
            display_name=display_name,
            initials=build_initials(
                display_name
            ),
            zodiac_sign=profile.get(
                "sun_sign"
            ),
            birth=BirthInformationResponse(
                birth_date=parse_date(
                    profile.get(
                        "birth_date"
                    )
                ),
                birth_time=birth_time,
                birth_place=profile.get(
                    "birth_place"
                ),
            ),
            account=AccountInformationResponse(
                email=(
                    auth_user.email
                    or profile.get("email")
                ),
                username=profile.get(
                    "username"
                ),
                member_since=member_since,
            ),
            preferences=AccountPreferencesResponse(),
        )

    except HTTPException:
        raise

    except Exception as exc:
        print(
            "ACCOUNT PROFILE ERROR:",
            repr(exc),
        )

        raise HTTPException(
            status_code=500,
            detail=(
                "No fue posible cargar "
                "el perfil de la cuenta."
            ),
        ) from exc


# ============================================================
# UPDATE ACCOUNT PROFILE
#
# PATCH /api/account-profile/{user_id}
#
# Edita:
# - display_name
# - username
# - email
#
# NO modifica:
# - birth_date
# - birth_hour
# - birth_minute
# - birth_place
# - datos astrológicos
# ============================================================

@router.patch(
    "/{user_id}",
    response_model=UpdateAccountProfileResponse,
    summary="Update account profile",
)
async def update_account_profile(
    user_id: str,
    payload: UpdateAccountProfileRequest,
) -> UpdateAccountProfileResponse:
    try:
        # ========================================================
        # 1. VALIDAR QUE VENGA AL MENOS UN CAMPO
        # ========================================================

        if (
            payload.display_name is None
            and payload.username is None
            and payload.email is None
        ):
            raise HTTPException(
                status_code=400,
                detail=(
                    "Debes enviar al menos "
                    "un campo para actualizar."
                ),
            )

        # ========================================================
        # 2. OBTENER PERFIL ACTUAL
        # ========================================================

        profile_response = (
            supabase_admin
            .table("profiles")
            .select(
                "id,"
                "display_name,"
                "username,"
                "email,"
                "email_verified,"
                "email_verified_at"
            )
            .eq(
                "id",
                user_id,
            )
            .limit(1)
            .execute()
        )

        if not profile_response.data:
            raise HTTPException(
                status_code=404,
                detail=(
                    "No existe un perfil "
                    "asociado a este usuario."
                ),
            )

        current_profile = profile_response.data[0]

        current_display_name = str(
            current_profile.get(
                "display_name"
            )
            or ""
        ).strip()

        current_username = str(
            current_profile.get(
                "username"
            )
            or ""
        ).strip()

        # ========================================================
        # 3. OBTENER USUARIO AUTH
        # ========================================================

        try:
            auth_response = (
                supabase_admin
                .auth
                .admin
                .get_user_by_id(user_id)
            )

            auth_user = auth_response.user

        except Exception as exc:
            raise HTTPException(
                status_code=500,
                detail=(
                    "No fue posible obtener "
                    "la cuenta del usuario."
                ),
            ) from exc

        if auth_user is None:
            raise HTTPException(
                status_code=404,
                detail=(
                    "No existe el usuario "
                    "en Supabase Auth."
                ),
            )

        current_email = str(
            auth_user.email or ""
        ).strip().lower()

        # ========================================================
        # 4. PREPARAR NUEVOS VALORES
        # ========================================================

        new_display_name = current_display_name
        new_username = current_username
        new_email = current_email

        profile_updates: dict[str, object] = {}

        # ========================================================
        # DISPLAY NAME
        # ========================================================

        if payload.display_name is not None:
            display_name = normalize_display_name(
                payload.display_name
            )

            if not display_name:
                raise HTTPException(
                    status_code=400,
                    detail=(
                        "El nombre no puede "
                        "estar vacío."
                    ),
                )

            new_display_name = display_name

            if display_name != current_display_name:
                profile_updates[
                    "display_name"
                ] = display_name

        # ========================================================
        # USERNAME
        # ========================================================

        if payload.username is not None:
            username = normalize_username(
                payload.username
            )

            if " " in username:
                raise HTTPException(
                    status_code=400,
                    detail=(
                        "El nombre de usuario "
                        "no puede contener espacios."
                    ),
                )

            if username != current_username:
                username_response = (
                    supabase_admin
                    .table("profiles")
                    .select("id")
                    .eq(
                        "username",
                        username,
                    )
                    .neq(
                        "id",
                        user_id,
                    )
                    .limit(1)
                    .execute()
                )

                if username_response.data:
                    raise HTTPException(
                        status_code=409,
                        detail=(
                            "El nombre de usuario "
                            "ya está en uso."
                        ),
                    )

                profile_updates[
                    "username"
                ] = username

            new_username = username

        # ========================================================
        # EMAIL
        #
        # auth.users sigue siendo la fuente principal del correo.
        # profiles.email mantiene una copia sincronizada.
        #
        # si el correo cambia:
        # - actualizamos auth
        # - actualizamos profiles.email
        # - quitamos la verificación anterior
        # ========================================================

        email_changed = False

        if payload.email is not None:
            email = str(
                payload.email
            ).strip().lower()

            new_email = email

            if new_email != current_email:
                email_changed = True

        # ========================================================
        # 5. ACTUALIZAR EMAIL EN AUTH PRIMERO
        #
        # Auth sigue siendo la fuente principal del correo.
        # Si Auth acepta el cambio, sincronizamos profiles.email
        # y reiniciamos el estado de verificación.
        # ========================================================

        if email_changed:
            try:
                (
                    supabase_admin
                    .auth
                    .admin
                    .update_user_by_id(
                        user_id,
                        {
                            "email": new_email,
                        },
                    )
                )

            except Exception as exc:
                print(
                    "UPDATE AUTH EMAIL ERROR:",
                    repr(exc),
                )

                raise HTTPException(
                    status_code=400,
                    detail=(
                        "No fue posible actualizar "
                        "el correo electrónico. "
                        "Verifica que sea válido y "
                        "que no esté registrado por "
                        "otra cuenta."
                    ),
                ) from exc

            profile_updates[
                "email"
            ] = new_email

            profile_updates[
                "email_verified"
            ] = False

            profile_updates[
                "email_verified_at"
            ] = None

        # ========================================================
        # 6. ACTUALIZAR PROFILES
        # ========================================================

        if profile_updates:
            update_response = (
                supabase_admin
                .table("profiles")
                .update(
                    profile_updates
                )
                .eq(
                    "id",
                    user_id,
                )
                .execute()
            )

            if not update_response.data:
                raise HTTPException(
                    status_code=500,
                    detail=(
                        "Supabase no devolvió "
                        "el perfil actualizado."
                    ),
                )

        # ========================================================
        # 7. ACTUALIZAR METADATA AUTH
        #
        # Es complementario. Si falla, profiles y email ya
        # contienen los valores principales.
        # ========================================================

        try:
            (
                supabase_admin
                .auth
                .admin
                .update_user_by_id(
                    user_id,
                    {
                        "user_metadata": {
                            "display_name": (
                                new_display_name
                            ),
                            "username": (
                                new_username
                            ),
                        },
                    },
                )
            )

        except Exception as exc:
            print(
                "ACCOUNT PROFILE "
                "AUTH METADATA WARNING:",
                repr(exc),
            )

        # ========================================================
        # 8. RESPONSE
        # ========================================================

        return UpdateAccountProfileResponse(
            message=(
                "Perfil actualizado "
                "correctamente."
            ),
            display_name=new_display_name,
            initials=build_initials(
                new_display_name
            ),
            username=new_username,
            email=new_email,
        )

    except HTTPException:
        raise

    except Exception as exc:
        print(
            "UPDATE ACCOUNT PROFILE ERROR:",
            repr(exc),
        )

        raise HTTPException(
            status_code=500,
            detail=(
                "No fue posible actualizar "
                "el perfil."
            ),
        ) from exc
