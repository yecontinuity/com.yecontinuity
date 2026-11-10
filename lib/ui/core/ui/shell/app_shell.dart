import 'dart:ui' show ImageFilter;

import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onSelected(int index) {
    HapticFeedback.selectionClick();
    navigationShell.goBranch(
      index,

      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return Scaffold(
      extendBody: isIOS,
      body: navigationShell,
      bottomNavigationBar: isIOS
          ? _IosGlassTabBar(
              currentIndex: navigationShell.currentIndex,
              onSelected: _onSelected,
            )
          : _AndroidNavBar(
              currentIndex: navigationShell.currentIndex,
              onSelected: _onSelected,
            ),
    );
  }
}

class _AndroidNavBar extends StatelessWidget {
  const _AndroidNavBar({required this.currentIndex, required this.onSelected});

  final int currentIndex;
  final ValueChanged<int> onSelected;

  static const _destinations = <NavigationDestination>[
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home_rounded),
      label: 'Início',
      tooltip: '',
    ),
    NavigationDestination(
      icon: Icon(Icons.add_circle_outline_rounded),
      selectedIcon: Icon(Icons.add_circle_rounded),
      label: 'Adicionar',
      tooltip: '',
    ),
    NavigationDestination(
      icon: Icon(Icons.chat_bubble_outline_rounded),
      selectedIcon: Icon(Icons.chat_bubble_rounded),
      label: 'Conversas',
      tooltip: '',
    ),
    NavigationDestination(
      icon: Icon(Icons.person_outline_rounded),
      selectedIcon: Icon(Icons.person_rounded),
      label: 'Perfil',
      tooltip: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          top: BorderSide(
            color: colors.outlineVariant.withValues(alpha: 0.6),
            width: 0.5,
          ),
        ),
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          height: 64,
          elevation: 0,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,

          indicatorColor: Colors.transparent,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          iconTheme: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return IconThemeData(
              size: 24,
              color: selected ? colors.primary : colors.onSurfaceVariant,
            );
          }),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return TextStyle(
              fontSize: 12,
              letterSpacing: 0.2,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              color: selected ? colors.primary : colors.onSurfaceVariant,
            );
          }),
        ),
        child: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: onSelected,
          destinations: _destinations,
        ),
      ),
    );
  }
}

class _TabItem {
  const _TabItem(this.label, this.icon, this.selectedIcon);

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

class _IosGlassTabBar extends StatelessWidget {
  const _IosGlassTabBar({required this.currentIndex, required this.onSelected});

  final int currentIndex;
  final ValueChanged<int> onSelected;

  static const _items = <_TabItem>[
    _TabItem('Início', CupertinoIcons.house, CupertinoIcons.house_fill),
    _TabItem(
      'Adicionar',
      CupertinoIcons.plus_circle,
      CupertinoIcons.plus_circle_fill,
    ),
    _TabItem(
      'Conversas',
      CupertinoIcons.chat_bubble,
      CupertinoIcons.chat_bubble_fill,
    ),
    _TabItem('Perfil', CupertinoIcons.person, CupertinoIcons.person_fill),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final glassColor = isDark
        ? const Color(0xFF1C1C1E).withValues(alpha: 0.55)
        : Colors.white.withValues(alpha: 0.60);
    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.12)
        : Colors.white.withValues(alpha: 0.70);

    const radius = BorderRadius.all(Radius.circular(32));

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: radius,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.12),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: radius,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
              child: Container(
                height: 64,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: glassColor,
                  borderRadius: radius,
                  border: Border.all(color: borderColor, width: 0.8),
                ),
                child: Row(
                  children: [
                    for (var i = 0; i < _items.length; i++)
                      Expanded(
                        child: _GlassTabButton(
                          item: _items[i],
                          selected: i == currentIndex,
                          onTap: () => onSelected(i),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassTabButton extends StatelessWidget {
  const _GlassTabButton({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final _TabItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final color = selected ? colors.primary : colors.onSurfaceVariant;

    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: selected
                ? colors.primary.withValues(alpha: 0.14)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                selected ? item.selectedIcon : item.icon,
                size: 24,
                color: color,
              ),
              const SizedBox(height: 2),
              Text(
                item.label,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
