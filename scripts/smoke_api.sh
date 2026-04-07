#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${1:-http://127.0.0.1:8000/api/v1}"

echo "[1/5] Health"
curl -fsS "$BASE_URL/health" | sed 's/.*/OK health: &/'

echo "[2/5] Voice activation"
curl -fsS -X POST "$BASE_URL/voice/activate" \
  -H 'Content-Type: application/json' \
  -d '{"transcript":"jarvis abrir agenda"}' | sed 's/.*/OK voice activate: &/'

echo "[3/5] Save preference"
curl -fsS -X POST "$BASE_URL/preferences" \
  -H 'Content-Type: application/json' \
  -d '{"key":"offline_mode","value":"false"}' | sed 's/.*/OK preference: &/'

echo "[4/5] Chat"
curl -fsS -X POST "$BASE_URL/chat" \
  -H 'Content-Type: application/json' \
  -d '{"text":"jarvis, organizar minha agenda", "source":"smoke"}' | sed 's/.*/OK chat: &/'

echo "[5/5] Automations"
curl -fsS -X POST "$BASE_URL/automations/execute" \
  -H 'Content-Type: application/json' \
  -d '{"command":"acender luz da sala","integration":"home_assistant"}' | sed 's/.*/OK automation: &/'

echo "Smoke test finalizado com sucesso."
