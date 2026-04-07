# Jarvis Backend (FastAPI)

## Run
```bash
cd backend
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload --port 8000
```

## Main endpoints
- `POST /api/v1/chat`
- `GET /api/v1/chat/history`
- `POST /api/v1/voice/activate`
- `POST /api/v1/voice/synthesize`
- `GET/POST /api/v1/preferences`
- `POST /api/v1/automations/execute`
