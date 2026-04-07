import 'package:flutter/material.dart';

import '../state/assistant_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.state});

  final AssistantState state;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SwitchListTile(
          title: const Text('Modo offline básico'),
          subtitle: const Text('Mantém comandos locais quando a API estiver indisponível'),
          value: state.offlineMode,
          onChanged: (value) => state.toggleOffline(value),
        ),
        const ListTile(
          title: Text('Integrações futuras'),
          subtitle: Text('Outlook, Alexa, Siri, Home Assistant e apps do celular já previstos no backend'),
        ),
        if (!state.voiceAvailable)
          const ListTile(
            leading: Icon(Icons.warning_amber_rounded),
            title: Text('Plugin de voz indisponível neste dispositivo'),
            subtitle: Text('O app seguirá funcional via texto e modo offline.'),
          ),
      ],
    );
  }
}
