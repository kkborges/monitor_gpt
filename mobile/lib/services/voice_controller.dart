import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceController {
  VoiceController({SpeechToText? stt, FlutterTts? tts})
      : _stt = stt ?? SpeechToText(),
        _tts = tts ?? FlutterTts();

  final SpeechToText _stt;
  final FlutterTts _tts;
  bool _ttsAvailable = true;
  bool _sttAvailable = true;
  bool get ttsAvailable => _ttsAvailable;
  bool get sttAvailable => _sttAvailable;

  Future<bool> init() async {
    try {
      await _tts.setLanguage('pt-BR');
      await _tts.setSpeechRate(0.46);
      _ttsAvailable = true;
    } catch (_) {
      _ttsAvailable = false;
    }

    try {
      _sttAvailable = await _stt.initialize();
    } catch (_) {
      _sttAvailable = false;
    }
    return _sttAvailable;
  }

  Future<void> listen(void Function(String text) onText) async {
    if (!_sttAvailable) return;
    await _stt.listen(
      localeId: 'pt_BR',
      onResult: (result) {
        if (result.finalResult) {
          onText(result.recognizedWords);
        }
      },
    );
  }

  Future<void> stop() async => _stt.stop();

  Future<void> speak(String text) async {
    if (!_ttsAvailable) return;
    try {
      await _tts.stop();
      await _tts.speak(text);
    } catch (_) {
      _ttsAvailable = false;
    }
  }
}
