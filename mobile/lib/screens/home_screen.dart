import 'package:flutter/material.dart';

import '../state/assistant_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.state, required this.controller});

  final AssistantState state;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            reverse: true,
            itemCount: state.messages.length,
            itemBuilder: (context, index) {
              final item = state.messages[state.messages.length - 1 - index];
              final isUser = item.role == 'user';
              return Align(
                alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isUser ? Colors.blue.shade100 : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(item.content),
                ),
              );
            },
          ),
        ),
        if (state.suggestions.isNotEmpty)
          Wrap(
            spacing: 8,
            children: state.suggestions
                .map((s) => ActionChip(label: Text(s), onPressed: () => state.send(s)))
                .toList(),
          ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(hintText: 'Fale ou digite um comando...'),
                ),
              ),
              IconButton(
                onPressed: () {
                  state.send(controller.text);
                  controller.clear();
                },
                icon: const Icon(Icons.send),
              ),
              FloatingActionButton(
                mini: true,
                onPressed: state.listening ? state.stopListening : state.startListening,
                child: Icon(state.listening ? Icons.mic_off : Icons.mic),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
