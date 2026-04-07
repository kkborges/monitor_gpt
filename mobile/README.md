# Jarvis Mobile (Flutter)

## Run
```bash
cd mobile
flutter pub get
flutter run --dart-define=API_URL=http://10.0.2.2:8000/api/v1
```

## MVP features
- ativação por voz via palavra-chave "jarvis"
- reconhecimento de fala (speech_to_text)
- síntese de voz (flutter_tts)
- chat texto/voz
- histórico local
- modo offline básico
- tela de configurações com preferências
