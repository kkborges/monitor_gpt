from sqlalchemy import select
from sqlalchemy.orm import Session

from app.models.entities import Preference


class PreferencesService:
    def set(self, db: Session, key: str, value: str) -> Preference:
        pref = db.get(Preference, key)
        if pref:
            pref.value = value
        else:
            pref = Preference(key=key, value=value)
            db.add(pref)
        db.commit()
        db.refresh(pref)
        return pref

    def list_all(self, db: Session) -> list[Preference]:
        return list(db.scalars(select(Preference)).all())

    def get_bool(self, db: Session, key: str, default: bool) -> bool:
        pref = db.get(Preference, key)
        if not pref:
            return default
        return pref.value.lower() in {"1", "true", "yes", "on"}
