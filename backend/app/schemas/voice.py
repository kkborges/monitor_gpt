from pydantic import BaseModel


class ActivationRequest(BaseModel):
    transcript: str


class ActivationResponse(BaseModel):
    activated: bool
    keyword: str


class SpeechSynthesisRequest(BaseModel):
    text: str
    voice_profile: str = "pt-BR-default"


class SpeechSynthesisResponse(BaseModel):
    text: str
    ssml: str
