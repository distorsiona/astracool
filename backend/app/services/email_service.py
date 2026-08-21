from html import escape

import httpx

from app.core.config import settings


BREVO_EMAIL_URL = "https://api.brevo.com/v3/smtp/email"


class EmailServiceError(Exception):
    """error controlado al enviar correos mediante brevo."""


def _validate_brevo_config() -> None:
    """comprueba que brevo esté configurado antes de intentar enviar."""

    if not settings.brevo_api_key.strip():
        raise EmailServiceError(
            "BREVO_API_KEY no está configurada."
        )

    if not settings.brevo_sender_email.strip():
        raise EmailServiceError(
            "BREVO_SENDER_EMAIL no está configurado."
        )


async def _send_email(
    *,
    recipient_email: str,
    recipient_name: str | None,
    subject: str,
    html_content: str,
) -> None:
    """envía un correo mediante la api transaccional de brevo."""

    _validate_brevo_config()

    recipient = {
        "email": recipient_email.strip(),
    }

    if recipient_name and recipient_name.strip():
        recipient["name"] = recipient_name.strip()

    payload = {
        "sender": {
            "name": settings.brevo_sender_name,
            "email": settings.brevo_sender_email,
        },
        "to": [
            recipient,
        ],
        "subject": subject,
        "htmlContent": html_content,
    }

    headers = {
        "accept": "application/json",
        "content-type": "application/json",
        "api-key": settings.brevo_api_key,
    }

    try:
        async with httpx.AsyncClient(
            timeout=15.0,
        ) as client:
            response = await client.post(
                BREVO_EMAIL_URL,
                headers=headers,
                json=payload,
            )

    except httpx.RequestError as exc:
        raise EmailServiceError(
            "No fue posible conectar con Brevo."
        ) from exc

    if response.status_code < 200 or response.status_code >= 300:
        print(
            "BREVO EMAIL ERROR:",
            response.status_code,
            response.text,
        )

        raise EmailServiceError(
            "Brevo rechazó el envío del correo."
        )


async def send_verification_email(
    *,
    recipient_email: str,
    recipient_name: str | None,
    token: str,
    next_action: str | None = None,
) -> None:
    """envía el enlace utilizado para verificar el correo."""

    verify_url = (
        f"{settings.frontend_verify_email_url}"
        f"?token={token}"
    )

    if next_action:
        verify_url += (
            f"&next_action={next_action}"
        )

    safe_name = escape(
        recipient_name or "Sacred User"
    )

    safe_url = escape(
        verify_url,
        quote=True,
    )

    html_content = f"""
    <div style="
        font-family: Arial, sans-serif;
        max-width: 560px;
        margin: 0 auto;
        padding: 32px;
    ">
        <h1>Verify your email</h1>

        <p>
            Hi {safe_name},
        </p>

        <p>
            Confirm your email address to verify
            your Sacred account.
        </p>

        <p style="margin: 32px 0;">
            <a
                href="{safe_url}"
                style="
                    display: inline-block;
                    padding: 12px 20px;
                    background: #111111;
                    color: #ffffff;
                    text-decoration: none;
                    border-radius: 8px;
                "
            >
                Verify email
            </a>
        </p>

        <p>
            If you did not request this,
            you can ignore this email.
        </p>
    </div>
    """

    await _send_email(
        recipient_email=recipient_email,
        recipient_name=recipient_name,
        subject="Verify your Sacred email",
        html_content=html_content,
    )


async def send_password_reset_email(
    *,
    recipient_email: str,
    recipient_name: str | None,
    token: str,
) -> None:
    """envía el enlace utilizado para cambiar la contraseña."""

    reset_url = (
        f"{settings.frontend_reset_password_url}"
        f"?token={token}"
    )

    safe_name = escape(
        recipient_name or "Sacred User"
    )

    safe_url = escape(
        reset_url,
        quote=True,
    )

    html_content = f"""
    <div style="
        font-family: Arial, sans-serif;
        max-width: 560px;
        margin: 0 auto;
        padding: 32px;
    ">
        <h1>Reset your password</h1>

        <p>
            Hi {safe_name},
        </p>

        <p>
            We received a request to reset
            your Sacred password.
        </p>

        <p style="margin: 32px 0;">
            <a
                href="{safe_url}"
                style="
                    display: inline-block;
                    padding: 12px 20px;
                    background: #111111;
                    color: #ffffff;
                    text-decoration: none;
                    border-radius: 8px;
                "
            >
                Reset password
            </a>
        </p>

        <p>
            If you did not request this,
            you can ignore this email.
        </p>
    </div>
    """

    await _send_email(
        recipient_email=recipient_email,
        recipient_name=recipient_name,
        subject="Reset your Sacred password",
        html_content=html_content,
    )