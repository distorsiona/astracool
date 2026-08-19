from supabase import Client, create_client

from app.core.config import settings


# ============================================================
# SUPABASE ADMIN
#
# Exclusivo del backend.
# Usa SERVICE ROLE.
#
# NO usar para iniciar sesión de usuarios.
# ============================================================

supabase_admin: Client = create_client(
    settings.supabase_url,
    settings.supabase_service_role_key,
)


# ============================================================
# SUPABASE AUTH
#
# Cliente para autenticación normal de usuarios.
# Puede mantener una sesión sin afectar al cliente admin.
# ============================================================

supabase_auth: Client = create_client(
    settings.supabase_url,
    settings.supabase_anon_key,
)