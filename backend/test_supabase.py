from app.core.supabase import supabase_admin


print("Probando profiles...")

result = (
    supabase_admin
    .table("profiles")
    .select("*")
    .limit(1)
    .execute()
)

print(result.data)