from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.api.routes.astrology import router as astrology_router
from app.api.routes.profile import router as profile_router
from app.api.routes.location import router as location_router
from app.api.routes.astra import router as astra_router
from app.api.routes.auth import router as auth_router

from app.core.config import settings
from app.api.routes.chart import (
    router as chart_router,
)


app = FastAPI(
    title=settings.app_name,
    version="0.1.0",
)


app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:3000",
        "http://localhost:5173",
        "http://localhost:8080",
        "http://127.0.0.1:8080",
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


app.include_router(
    astrology_router,
    prefix="/api",
)

app.include_router(
    profile_router,
    prefix="/api",
)

app.include_router(
    location_router,
    prefix="/api",
)

app.include_router(
    astra_router,
    prefix="/api",
)

app.include_router(
    auth_router,
    prefix="/api",
)

app.include_router(
    chart_router,
    prefix="/api",
)


@app.get("/")
async def root():
    return {
        "name": settings.app_name,
        "status": "running",
    }


@app.get("/health")
async def health():
    return {
        "status": "healthy",
    }