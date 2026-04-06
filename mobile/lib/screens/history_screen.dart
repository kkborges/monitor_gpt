import 'package:flutter/material.dart';

import '../state/assistant_state.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key, required this.state});

  final AssistantState state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.messages.length,
      itemBuilder: (context, index) {
        final item = state.messages[index];
        return ListTile(
          title: Text(item.content),
          subtitle: Text('${item.role} • ${item.createdAt.toLocal()}'),
          leading: Icon(item.role == 'user' ? Icons.person : Icons.smart_toy),
        );
      },
    );
  }
}
