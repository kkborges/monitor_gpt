from pydantic import BaseModel


class AutomationRequest(BaseModel):
    command: str
    integration: str = "local"


class AutomationResponse(BaseModel):
    command: str
    integration: str
    result: str
    success: bool
