from fastapi import FastAPI

from app.core.logging_config import configure_logging
from app.routes.health import router as health_router

configure_logging()

app = FastAPI(
    title="AI Workforce Automation API",
    version="0.1.0",
    description="Production-ready FastAPI foundation for AI automation workflows.",
)

app.include_router(health_router)
