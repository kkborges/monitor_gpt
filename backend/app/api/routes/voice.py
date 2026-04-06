from fastapi import APIRouter

from app.schemas.voice import (
    ActivationRequest,
    ActivationResponse,
    SpeechSynthesisRequest,
    SpeechSynthesisResponse,
)
from app.services.voice_service import VoiceService

router = APIRouter(prefix="/voice", tags=["voice"])
voice_service = VoiceService()


@router.post("/activate", response_model=ActivationResponse)
def activate(payload: ActivationRequest) -> ActivationResponse:
    activated = voice_service.detect_activation(payload.transcript)
    return ActivationResponse(activated=activated, keyword="jarvis")


@router.post("/synthesize", response_model=SpeechSynthesisResponse)
def synthesize(payload: SpeechSynthesisRequest) -> SpeechSynthesisResponse:
    result = voice_service.synthesize(payload.text, payload.voice_profile)
    return SpeechSynthesisResponse(**result)
