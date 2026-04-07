from sqlalchemy import select
from sqlalchemy.orm import Session

from app.models.entities import Conversation, Message


class HistoryService:
    def get_or_create_conversation(self, db: Session, conversation_id: int | None) -> Conversation:
        if conversation_id:
            convo = db.get(Conversation, conversation_id)
            if convo:
                return convo
        convo = Conversation(title="Conversa via app")
        db.add(convo)
        db.commit()
        db.refresh(convo)
        return convo

    def add_message(self, db: Session, conversation_id: int, role: str, content: str) -> Message:
        msg = Message(conversation_id=conversation_id, role=role, content=content)
        db.add(msg)
        db.commit()
        db.refresh(msg)
        return msg

    def recent_context(self, db: Session, conversation_id: int, limit: int = 8) -> list[str]:
        stmt = (
            select(Message)
            .where(Message.conversation_id == conversation_id)
            .order_by(Message.created_at.desc())
            .limit(limit)
        )
        return [row.content for row in db.scalars(stmt).all()][::-1]

    def list_conversations(self, db: Session) -> list[Conversation]:
        stmt = select(Conversation).order_by(Conversation.created_at.desc())
        return list(db.scalars(stmt).all())
