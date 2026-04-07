.PHONY: help backend-venv backend-install backend-run backend-compile smoke-api mobile-help

help:
	@echo "Targets disponíveis:"
	@echo "  make backend-venv      -> cria venv do backend"
	@echo "  make backend-install   -> instala dependências backend"
	@echo "  make backend-run       -> sobe FastAPI em :8000"
	@echo "  make backend-compile   -> valida backend via compileall"
	@echo "  make smoke-api         -> executa smoke test de endpoints"
	@echo "  make mobile-help       -> mostra comandos Flutter"

backend-venv:
	cd backend && python -m venv .venv

backend-install:
	cd backend && . .venv/bin/activate && pip install -r requirements.txt

backend-run:
	cd backend && . .venv/bin/activate && uvicorn app.main:app --reload --port 8000

backend-compile:
	python -m compileall backend/app

smoke-api:
	bash scripts/smoke_api.sh

mobile-help:
	@echo "cd mobile"
	@echo "flutter pub get"
	@echo "flutter run --dart-define=API_URL=http://10.0.2.2:8000/api/v1"
