# Monitor GPT - Jarvis Assistant MVP

## 1) Arquitetura geral
- `backend/` com FastAPI modular por domínios (voz, IA, histórico, preferências e automações).
- `mobile/` com Flutter consumindo API REST e mantendo fallback offline.
- Persistência no SQLite (MVP) pronta para PostgreSQL via variável `DATABASE_URL`.

## 2) Estrutura de alto nível
- `backend/app/api/routes`: endpoints REST
- `backend/app/services`: regras de negócio desacopladas
- `backend/app/models`: entidades SQLAlchemy
- `mobile/lib/screens`: telas principais
- `mobile/lib/state`: estado global da assistente

## 3) Execução rápida
Veja `backend/README.md` e `mobile/README.md`.
