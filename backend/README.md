# Backend - Jarvis (FastAPI)

## Subir localmente

```bash
cd /workspace/monitor_gpt/backend
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload --port 8000
```

## Endpoints principais

- `GET /api/v1/health`
- `POST /api/v1/chat`
- `GET /api/v1/chat/history`
- `POST /api/v1/voice/activate`
- `POST /api/v1/voice/synthesize`
- `GET /api/v1/preferences`
- `POST /api/v1/preferences`
- `POST /api/v1/automations/execute`

## Exemplo rápido (chat)

```bash
curl -X POST http://127.0.0.1:8000/api/v1/chat \
  -H 'Content-Type: application/json' \
  -d '{"text":"jarvis organizar agenda","source":"manual"}'
```

## Variáveis de ambiente

Copie de `.env.example` na raiz e ajuste se necessário:
- `DATABASE_URL` (SQLite ou PostgreSQL)
- `VOICE_ACTIVATION_KEYWORD`
