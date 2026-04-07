from datetime import datetime

from pydantic import BaseModel


class PreferenceItem(BaseModel):
    key: str
    value: str


class PreferenceRead(PreferenceItem):
    updated_at: datetime

    class Config:
        from_attributes = True
