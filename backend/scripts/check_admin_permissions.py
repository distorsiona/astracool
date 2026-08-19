"""
Script temporal de desarrollo.

Verifica, de forma aislada, si supabase_admin (service role key)
tiene permisos administrativos reales, sin ejecutar todo el
flujo de REGISTER.

Uso (desde backend/, con el venv activo):
    python scripts/check_admin_permissions.py
"""

from app.core.supabase import supabase_admin
from supabase_auth.errors import AuthApiError


def main() -> None:
    print("Probando permisos admin (list_users)...")

    try:
        result = supabase_admin.auth.admin.list_users()

        print(
            f"OK -> permisos admin confirmados. "
            f"Usuarios encontrados: {len(result)}"
        )

    except AuthApiError as exc:
        print("FALLA -> la service role key no tiene permisos admin.")
        print(f"Detalle: {exc}")
        print()
        print(
            "Revisar: SUPABASE_SERVICE_ROLE_KEY, que corresponda "
            "al mismo proyecto que SUPABASE_URL, que sea realmente "
            "service_role/secret (no anon/publishable), y la "
            "configuración del proyecto en Supabase."
        )


if __name__ == "__main__":
    main()
