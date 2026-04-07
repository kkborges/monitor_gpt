from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.db.database import get_db
from app.schemas.chat import ChatResponse, ConversationRead, MessageCreate
from app.services.ai_service import AIService
from app.services.automation_service import AutomationService
from app.services.history_service import HistoryService
from app.services.preferences_service import PreferencesService

router = APIRouter(prefix="/chat", tags=["chat"])

ai_service = AIService()
history_service = HistoryService()
automation_service = AutomationService()
preferences_service = PreferencesService()


@router.post("", response_model=ChatResponse)
def send_message(payload: MessageCreate, db: Session = Depends(get_db)) -> ChatResponse:
    try:
        convo = history_service.get_or_create_conversation(db, payload.conversation_id)
        user_msg = history_service.add_message(db, convo.id, "user", payload.text)
        context = history_service.recent_context(db, convo.id)
        offline_mode = preferences_service.get_bool(db, "offline_mode", default=False)
        answer = ai_service.answer(payload.text, context=context, offline=offline_mode)
        assistant_msg = history_service.add_message(db, convo.id, "assistant", answer)
        automation_service.log_chat_command(db, command=payload.text, result=answer, source=payload.source)
        return ChatResponse(
            conversation_id=convo.id,
            user_message=user_msg,
            assistant_message=assistant_msg,
            suggestions=ai_service.suggestions(payload.text),
            should_speak=True,
        )
    except Exception as exc:
        raise HTTPException(status_code=500, detail=f"Erro ao processar chat: {exc}") from exc


@router.get("/history", response_model=list[ConversationRead])
def history(db: Session = Depends(get_db)) -> list[ConversationRead]:
    convos = history_service.list_conversations(db)
    return convos
