from app.services.proactive_service import ProactiveService


class AIService:
    def __init__(self) -> None:
        self.proactive_service = ProactiveService()

    def answer(self, prompt: str, context: list[str] | None = None, offline: bool = False) -> str:
        prompt_lower = prompt.lower()
        if offline:
            return "Estou em modo offline básico. Posso registrar tarefas e responder comandos essenciais."
        if "agenda" in prompt_lower:
            return "Posso integrar com Outlook em seguida. No momento, registrei sua intenção de organizar a agenda."
        if "casa" in prompt_lower or "luz" in prompt_lower:
            return "Arquitetura pronta para Home Assistant. No MVP, simulo o comando e registro execução."
        if context:
            return f"Entendi com base no histórico recente: {context[-1]}. Como posso aprofundar?"
        return "Comando processado. Posso responder por voz, texto e registrar automações para você."

    def suggestions(self, prompt: str) -> list[str]:
        return self.proactive_service.generate(prompt)
