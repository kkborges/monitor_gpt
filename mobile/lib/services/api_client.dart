import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/chat_models.dart';

class ApiClient {
  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  final String baseUrl = const String.fromEnvironment('API_URL', defaultValue: 'http://10.0.2.2:8000/api/v1');

  Future<ChatResponseModel> sendMessage({required String text, int? conversationId}) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/chat'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'text': text, 'conversation_id': conversationId, 'source': 'mobile'}),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return ChatResponseModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }
    throw Exception('Falha na API: ${response.statusCode} ${response.body}');
  }

  Future<bool> detectActivation(String transcript) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/voice/activate'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'transcript': transcript}),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return (jsonDecode(response.body) as Map<String, dynamic>)['activated'] as bool;
    }
    return false;
  }

  Future<void> savePreference(String key, String value) async {
    await _client.post(
      Uri.parse('$baseUrl/preferences'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'key': key, 'value': value}),
    );
  }
}
