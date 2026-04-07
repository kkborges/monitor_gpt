class ProactiveService:
    def generate(self, last_prompt: str) -> list[str]:
        base = [
            "Deseja salvar isso como rotina diária?",
            "Posso criar um lembrete para este comando.",
            "Quer que eu execute em modo silencioso na próxima vez?",
        ]
        if "reunião" in last_prompt.lower():
            base[0] = "Posso preparar um resumo pré-reunião com seus tópicos principais."
        return base
