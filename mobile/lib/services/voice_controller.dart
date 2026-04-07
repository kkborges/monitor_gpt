import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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
  bool get _isKnownUnsupportedPlatform =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.linux;

  Future<bool> init() async {
    if (_isKnownUnsupportedPlatform) {
      _ttsAvailable = false;
      _sttAvailable = false;
      return false;
    }

    try {
      await _tts.setLanguage('pt-BR');
      await _tts.setSpeechRate(0.46);
      _ttsAvailable = true;
    } on MissingPluginException {
      _ttsAvailable = false;
    } catch (_) {
      _ttsAvailable = false;
    }

    try {
      _sttAvailable = await _stt.initialize();
    } on MissingPluginException {
      _sttAvailable = false;
    } catch (_) {
      _sttAvailable = false;
    }
    return _sttAvailable;
  }

  Future<void> listen(void Function(String text) onText) async {
    if (!_sttAvailable) return;
    try {
      await _stt.listen(
        localeId: 'pt_BR',
        onResult: (result) {
          if (result.finalResult) {
            onText(result.recognizedWords);
          }
        },
      );
    } on MissingPluginException {
      _sttAvailable = false;
    } catch (_) {
      _sttAvailable = false;
    }
  }

  Future<void> stop() async => _stt.stop();

  Future<void> speak(String text) async {
    if (!_ttsAvailable) return;
    try {
      await _tts.stop();
      await _tts.speak(text);
    } on MissingPluginException {
      _ttsAvailable = false;
    } catch (_) {
      _ttsAvailable = false;
    }
  }
}
