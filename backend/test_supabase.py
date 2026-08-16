from app.core.supabase import supabase


print("Probando profiles...")

result = (
    supabase
    .table("profiles")
    .select("*")
    .limit(1)
    .execute()
)

print(result.data)