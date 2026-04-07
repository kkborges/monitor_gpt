from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.db.database import get_db
from app.schemas.preferences import PreferenceItem, PreferenceRead
from app.services.preferences_service import PreferencesService

router = APIRouter(prefix="/preferences", tags=["preferences"])
service = PreferencesService()


@router.get("", response_model=list[PreferenceRead])
def list_preferences(db: Session = Depends(get_db)) -> list[PreferenceRead]:
    return service.list_all(db)


@router.post("", response_model=PreferenceRead)
def set_preference(payload: PreferenceItem, db: Session = Depends(get_db)) -> PreferenceRead:
    return service.set(db, payload.key, payload.value)
