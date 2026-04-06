from datetime import datetime

from pydantic import BaseModel, Field


class MessageCreate(BaseModel):
    conversation_id: int | None = None
    text: str = Field(min_length=1, max_length=5000)
    source: str = "mobile"


class MessageRead(BaseModel):
    id: int
    conversation_id: int
    role: str
    content: str
    created_at: datetime

    class Config:
        from_attributes = True


class ChatResponse(BaseModel):
    conversation_id: int
    user_message: MessageRead
    assistant_message: MessageRead
    suggestions: list[str]
    should_speak: bool = True


class ConversationRead(BaseModel):
    id: int
    title: str
    created_at: datetime
    messages: list[MessageRead]

    class Config:
        from_attributes = True
