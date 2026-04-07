# Mobile - Jarvis (Flutter)

## Rodar app

```bash
cd /workspace/monitor_gpt/mobile
flutter pub get
flutter run --dart-define=API_URL=http://10.0.2.2:8000/api/v1
```

## URL da API por ambiente

- Android Emulator: `http://10.0.2.2:8000/api/v1`
- iOS Simulator: `http://127.0.0.1:8000/api/v1` (em geral)
- Dispositivo físico: `http://<IP_DA_MAQUINA>:8000/api/v1`

## Fluxo esperado

1. Abra tela principal
2. Digite ou fale um comando
3. Receba resposta em texto e, quando disponível, por voz
4. Veja histórico na aba "Histórico"
5. Ative/desative modo offline na aba "Config"

## Compatibilidade de voz

Se plugins de voz não estiverem disponíveis na plataforma, o app entra em fallback para texto sem quebrar.
