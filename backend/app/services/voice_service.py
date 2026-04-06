from app.core.config import settings


class VoiceService:
    def detect_activation(self, transcript: str) -> bool:
        return settings.voice_activation_keyword.lower() in transcript.lower()

    def synthesize(self, text: str, voice_profile: str = "pt-BR-default") -> dict[str, str]:
        escaped = text.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
        ssml = f"<speak><voice name='{voice_profile}'>{escaped}</voice></speak>"
        return {"text": text, "ssml": ssml}
