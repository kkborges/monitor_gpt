from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.db.database import get_db
from app.schemas.automation import AutomationRequest, AutomationResponse
from app.services.automation_service import AutomationService

router = APIRouter(prefix="/automations", tags=["automations"])
service = AutomationService()


@router.post("/execute", response_model=AutomationResponse)
def execute(payload: AutomationRequest, db: Session = Depends(get_db)) -> AutomationResponse:
    result = service.execute(db, payload.command, payload.integration)
    return AutomationResponse(**result)
