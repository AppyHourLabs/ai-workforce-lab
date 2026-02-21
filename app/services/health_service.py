from app.core.config import settings
from app.schemas.health import HealthResponse


class HealthService:
    """Service for health and readiness status checks."""

    def get_health_status(self) -> HealthResponse:
        return HealthResponse(status="ok", service=settings.app_name, environment=settings.environment)
