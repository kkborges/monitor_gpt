import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceController {
  VoiceController({SpeechToText? stt, FlutterTts? tts})
      : _stt = stt ?? SpeechToText(),
        _tts = tts ?? FlutterTts();

  final SpeechToText _stt;
  final FlutterTts _tts;

  Future<bool> init() async {
    await _tts.setLanguage('pt-BR');
    await _tts.setSpeechRate(0.46);
    return _stt.initialize();
  }

  Future<void> listen(void Function(String text) onText) async {
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
    await _tts.stop();
    await _tts.speak(text);
  }
}
