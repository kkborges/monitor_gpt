import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/chat_models.dart';
import '../services/api_client.dart';
import '../services/voice_controller.dart';

class AssistantState extends ChangeNotifier {
  AssistantState({ApiClient? apiClient, VoiceController? voiceController})
      : _apiClient = apiClient ?? ApiClient(),
        _voiceController = voiceController ?? VoiceController();

  final ApiClient _apiClient;
  final VoiceController _voiceController;

  List<ChatMessage> messages = [];
  List<String> suggestions = [];
  bool listening = false;
  bool offlineMode = false;
  int? conversationId;

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    offlineMode = prefs.getBool('offline_mode') ?? false;
    final historyRaw = prefs.getStringList('offline_history') ?? [];
    messages = historyRaw
        .map((item) => ChatMessage.fromJson(jsonDecode(item) as Map<String, dynamic>))
        .toList();
    await _voiceController.init();
    notifyListeners();
  }

  Future<void> toggleOffline(bool value) async {
    offlineMode = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('offline_mode', value);
    try {
      await _apiClient.savePreference('offline_mode', value.toString());
    } catch (_) {
      // app permanece funcional localmente
    }
    notifyListeners();
  }

  Future<void> startListening() async {
    listening = true;
    notifyListeners();
    await _voiceController.listen((text) async {
      final activated = text.toLowerCase().contains('jarvis') || await _apiClient.detectActivation(text);
      if (activated) {
        await send(text.replaceAll(RegExp('jarvis', caseSensitive: false), '').trim());
      }
    });
  }

  Future<void> stopListening() async {
    listening = false;
    await _voiceController.stop();
    notifyListeners();
  }

  Future<void> send(String text) async {
    if (text.isEmpty) return;

    if (offlineMode) {
      final user = ChatMessage(role: 'user', content: text, createdAt: DateTime.now());
      final assistant = ChatMessage(
        role: 'assistant',
        content: 'Modo offline ativo. Registrei: "$text" e responderei localmente.',
        createdAt: DateTime.now(),
      );
      messages.addAll([user, assistant]);
      suggestions = [
        'Quando online, deseja sincronizar este histórico?',
        'Posso transformar isso em automação depois.',
      ];
      await _persistOfflineHistory();
      await _voiceController.speak(assistant.content);
      notifyListeners();
      return;
    }

    try {
      final response = await _apiClient.sendMessage(text: text, conversationId: conversationId);
      conversationId = response.conversationId;
      messages.add(response.userMessage);
      messages.add(response.assistantMessage);
      suggestions = response.suggestions;
      await _voiceController.speak(response.assistantMessage.content);
    } catch (_) {
      final fallback = ChatMessage(
        role: 'assistant',
        content: 'Não consegui acessar o backend. Ative o modo offline para continuar.',
        createdAt: DateTime.now(),
      );
      messages.add(fallback);
    }
    notifyListeners();
  }

  Future<void> _persistOfflineHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = messages
        .map((m) => jsonEncode({'role': m.role, 'content': m.content, 'created_at': m.createdAt.toIso8601String()}))
        .toList();
    await prefs.setStringList('offline_history', encoded);
  }
}
