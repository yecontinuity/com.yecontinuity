// lib/ui/shell/app_shell.dart
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// Casca da app autenticada: corpo = branch ativo, em baixo a barra.
///
/// O índice vem do `StatefulNavigationShell`, que é a única fonte de verdade.
/// Por isso já não é preciso o `bottomNavigationProvider` nem o `MainScreen`.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  // Mesma ordem dos `TypedStatefulShellBranch` em router.dart.
  static const _destinations = <NavigationDestination>[
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.add_circle_outline),
      selectedIcon: Icon(Icons.add_circle),
      label: 'Add',
    ),
    NavigationDestination(
      icon: Icon(Icons.chat_bubble_outline),
      selectedIcon: Icon(Icons.chat_bubble),
      label: 'Chats',
    ),
    NavigationDestination(
      icon: Icon(Icons.person_outline),
      selectedIcon: Icon(Icons.person),
      label: 'Me',
    ),
  ];

  void _onSelected(int index) {
    HapticFeedback.selectionClick();
    navigationShell.goBranch(
      index,
      // Tocar no separador já ativo volta à raiz dele.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // `navigationShell` já é o Navigator do branch ativo.
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onSelected,
        destinations: _destinations,
      ),
    );
  }
}
