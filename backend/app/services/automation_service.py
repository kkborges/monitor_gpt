from sqlalchemy.orm import Session

from app.models.entities import CommandLog


class AutomationService:
    SUPPORTED_INTEGRATIONS = ["local", "outlook", "alexa", "siri", "home_assistant", "mobile_apps"]

    def execute(self, db: Session, command: str, integration: str) -> dict:
        integration_final = integration if integration in self.SUPPORTED_INTEGRATIONS else "local"
        result = f"Comando '{command}' encaminhado para integração '{integration_final}' (simulação MVP)."
        log = CommandLog(command=command, result=result, success=True, source="api")
        db.add(log)
        db.commit()
        db.refresh(log)
        return {"command": command, "integration": integration_final, "result": result, "success": True}

    def log_chat_command(self, db: Session, command: str, result: str, source: str = "mobile") -> None:
        db.add(CommandLog(command=command, result=result, success=True, source=source))
        db.commit()
