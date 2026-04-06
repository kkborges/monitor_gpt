from contextlib import asynccontextmanager

from fastapi import FastAPI

from app.api.routes import automations, chat, health, preferences, voice
from app.core.config import settings
from app.db.database import Base, engine


@asynccontextmanager
async def lifespan(_: FastAPI):
    Base.metadata.create_all(bind=engine)
    yield


app = FastAPI(title=settings.app_name, lifespan=lifespan)

app.include_router(health.router, prefix=settings.api_prefix)
app.include_router(chat.router, prefix=settings.api_prefix)
app.include_router(voice.router, prefix=settings.api_prefix)
app.include_router(preferences.router, prefix=settings.api_prefix)
app.include_router(automations.router, prefix=settings.api_prefix)
