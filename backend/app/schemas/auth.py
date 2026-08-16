from datetime import date, time

from pydantic import BaseModel, EmailStr, Field


# ============================================================
# REGISTER
# ============================================================

class RegisterRequest(BaseModel):
    full_name: str = Field(
        min_length=1,
        max_length=100,
    )

    username: str = Field(
        min_length=3,
        max_length=30,
    )

    email: EmailStr

    password: str = Field(
        min_length=6,
    )

    birth_date: date
    birth_time: time

    birth_place: str = Field(
        min_length=2,
        max_length=200,
    )


class UserProfileResponse(BaseModel):
    id: str
    full_name: str
    username: str
    email: EmailStr

    birth_date: date
    birth_time: time
    birth_place: str


class RegisterResponse(BaseModel):
    message: str
    user: UserProfileResponse


# ============================================================
# LOGIN
# ============================================================

class LoginRequest(BaseModel):
    identifier: str = Field(
        ...,
        min_length=1,
        max_length=150,
    )

    password: str = Field(
        ...,
        min_length=1,
        max_length=128,
    )

class LoginUser(BaseModel):
    id: str
    email: EmailStr


class LoginResponse(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str
    user: LoginUser
