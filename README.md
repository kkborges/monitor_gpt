# Jarvis Assistant MVP (FastAPI + Flutter)

Guia completo para **executar de ponta a ponta** o projeto (backend + app mobile), incluindo validação por API.

---

## 1) Pré-requisitos

### Backend
- Python 3.10+
- `pip`

### Mobile
- Flutter 3.x
- SDK Android (para emulador) ou dispositivo físico

### Ferramentas úteis
- `curl`
- `make` (opcional, mas recomendado)

---

## 2) Estrutura do projeto

```text
/workspace/monitor_gpt
├── backend/
│   ├── app/
│   │   ├── api/routes/
│   │   ├── core/
│   │   ├── db/
│   │   ├── models/
│   │   ├── schemas/
│   │   └── services/
│   ├── requirements.txt
│   └── README.md
├── mobile/
│   ├── lib/
│   │   ├── models/
│   │   ├── screens/
│   │   ├── services/
│   │   └── state/
│   ├── pubspec.yaml
│   └── README.md
├── scripts/
│   └── smoke_api.sh
├── .env.example
└── Makefile
```

---

## 3) Configuração rápida (Backend)

### Opção A: com Makefile

```bash
cd /workspace/monitor_gpt
make backend-venv
make backend-install
make backend-run
```

### Opção B: manual

```bash
cd /workspace/monitor_gpt/backend
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload --port 8000
```

Backend ficará em:
- `http://127.0.0.1:8000`
- docs Swagger: `http://127.0.0.1:8000/docs`

---

## 4) Teste de API (smoke test)

Com backend rodando:

```bash
cd /workspace/monitor_gpt
make smoke-api
```

Ou manual:

```bash
bash scripts/smoke_api.sh http://127.0.0.1:8000/api/v1
```

Esse teste valida:
1. healthcheck
2. ativação por voz
3. persistência de preferências
4. chat com resposta
5. automação simulada

---

## 5) Rodando o app Flutter

```bash
cd /workspace/monitor_gpt/mobile
flutter pub get
flutter run --dart-define=API_URL=http://10.0.2.2:8000/api/v1
```

> `10.0.2.2` funciona para Android Emulator acessando backend local da máquina host.

Se estiver em dispositivo físico, use IP da sua máquina:

```bash
flutter run --dart-define=API_URL=http://<SEU_IP_LOCAL>:8000/api/v1
```

---

## 6) Problemas comuns e solução

### A) `MissingPluginException` (flutter_tts / speech_to_text)
O app já tem fallback: se plugin de voz não estiver disponível na plataforma, ele segue funcional em texto.

### B) Backend não responde no app
- verifique se backend está em execução
- confirme a URL em `--dart-define=API_URL=...`
- confira firewall/porta 8000

### C) `git push` pedindo autenticação
Use token (PAT) ou SSH no seu ambiente local.

### D) Erro `RawKeyboard ... Scroll Lock` no Linux
É uma assertiva conhecida do Flutter em algumas versões/combinações GTK. Não impacta o backend e não é bloqueador para validar API/chat.

---

## 7) Comandos úteis

```bash
# validar backend
python -m compileall backend/app

# abrir docs da API
xdg-open http://127.0.0.1:8000/docs
```
