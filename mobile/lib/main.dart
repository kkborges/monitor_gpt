import 'package:flutter/material.dart';

import 'screens/history_screen.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'state/assistant_state.dart';

void main() {
  runApp(const JarvisApp());
}

class JarvisApp extends StatefulWidget {
  const JarvisApp({super.key});

  @override
  State<JarvisApp> createState() => _JarvisAppState();
}

class _JarvisAppState extends State<JarvisApp> {
  final AssistantState state = AssistantState();
  final TextEditingController textController = TextEditingController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    state.initialize();
    state.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(state: state, controller: textController),
      HistoryScreen(state: state),
      SettingsScreen(state: state),
    ];

    return MaterialApp(
      title: 'Jarvis Mobile',
      home: Scaffold(
        appBar: AppBar(title: const Text('Jarvis Assistant')),
        body: pages[currentIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) => setState(() => currentIndex = index),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.mic), label: 'Assistente'),
            NavigationDestination(icon: Icon(Icons.history), label: 'Histórico'),
            NavigationDestination(icon: Icon(Icons.settings), label: 'Config'),
          ],
        ),
      ),
    );
  }
}
