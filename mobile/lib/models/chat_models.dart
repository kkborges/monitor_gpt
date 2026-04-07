class ChatMessage {
  final String role;
  final String content;
  final DateTime createdAt;

  ChatMessage({required this.role, required this.content, required this.createdAt});

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      role: json['role'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}

class ChatResponseModel {
  final int conversationId;
  final ChatMessage userMessage;
  final ChatMessage assistantMessage;
  final List<String> suggestions;

  ChatResponseModel({
    required this.conversationId,
    required this.userMessage,
    required this.assistantMessage,
    required this.suggestions,
  });

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatResponseModel(
      conversationId: json['conversation_id'] as int,
      userMessage: ChatMessage.fromJson(json['user_message'] as Map<String, dynamic>),
      assistantMessage: ChatMessage.fromJson(json['assistant_message'] as Map<String, dynamic>),
      suggestions: (json['suggestions'] as List<dynamic>).cast<String>(),
    );
  }
}
