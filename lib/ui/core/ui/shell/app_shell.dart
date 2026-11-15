// lib/ui/core/ui/shell/app_shell.dart
import 'package:cupertino_native_better/cupertino_native_better.dart'
    show CNSymbol, CNTabBar, CNTabBarItem;
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

// ===========================================================================
// DESTINATIONS (order MUST match the StatefulShellBranches in router.dart:
// ProductsBranch, ExplorerBranch, AddBranch, ChatsBranch, ProfileBranch)
// ===========================================================================

class AppDestination {
  const AppDestination({
    required this.path,
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.sfSymbol,
    required this.sfSymbolSelected,
  });

  /// Root path of the branch. Any other location inside the shell
  /// (e.g. /profile/settings) is a "detail" page and hides the bar.
  final String path;
  final String label;

  /// Material icons (Android).
  final IconData icon;
  final IconData selectedIcon;

  /// SF Symbols (iOS glass tab bar).
  final String sfSymbol;
  final String sfSymbolSelected;
}

const appDestinations = <AppDestination>[
  AppDestination(
    path: '/',
    label: 'Início',
    icon: Icons.home_outlined,
    selectedIcon: Icons.home_rounded,
    sfSymbol: 'house',
    sfSymbolSelected: 'house.fill',
  ),
  AppDestination(
    path: '/explorer',
    label: 'Explorar',
    icon: Icons.map_outlined,
    selectedIcon: Icons.map_rounded,
    sfSymbol: 'map',
    sfSymbolSelected: 'map.fill',
  ),
  AppDestination(
    path: '/publish',
    label: 'Adicionar',
    icon: Icons.add_circle_outline_rounded,
    selectedIcon: Icons.add_circle_rounded,
    sfSymbol: 'plus.circle',
    sfSymbolSelected: 'plus.circle.fill',
  ),
  AppDestination(
    path: '/chats',
    label: 'Conversas',
    icon: Icons.chat_bubble_outline_rounded,
    selectedIcon: Icons.chat_bubble_rounded,
    sfSymbol: 'bubble.left',
    sfSymbolSelected: 'bubble.left.fill',
  ),
  AppDestination(
    path: '/profile',
    label: 'Perfil',
    icon: Icons.person_outline_rounded,
    selectedIcon: Icons.person_rounded,
    sfSymbol: 'person',
    sfSymbolSelected: 'person.fill',
  ),
];

// ===========================================================================
// SHELL
// ===========================================================================

/// Authenticated app shell: body = active branch, bottom = navigation bar.
///
/// The bar is only visible on the root page of each tab. On detail pages
/// (e.g. Settings) it slides away but stays mounted, so the native iOS bar is
/// not destroyed and recreated, which is what made the return so slow.
class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.navigationShell,
    required this.location,
  });

  final StatefulNavigationShell navigationShell;

  /// Current full location, e.g. `/profile` or `/profile/settings`.
  final String location;

  bool get _showBar => appDestinations.any((d) => d.path == location);

  void _onSelected(int index) {
    HapticFeedback.selectionClick();
    navigationShell.goBranch(
      index,
      // Tapping the active tab returns to its root.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final hidden = !_showBar;

    return Scaffold(
      // iOS: content scrolls behind the glass bar.
      extendBody: isIOS,
      body: navigationShell,
      bottomNavigationBar: isIOS
          ? _SlideAwayBar(
              hidden: hidden,
              child: _IosGlassTabBar(
                currentIndex: navigationShell.currentIndex,
                onSelected: _onSelected,
              ),
            )
          : _CollapseBar(
              hidden: hidden,
              child: _AndroidNavBar(
                currentIndex: navigationShell.currentIndex,
                onSelected: _onSelected,
              ),
            ),
    );
  }
}

// ===========================================================================
// Show / hide helpers
// ===========================================================================

/// iOS: slides the native bar off-screen without changing its size or
/// removing it from the tree (keeps the platform view alive).
class _SlideAwayBar extends StatelessWidget {
  const _SlideAwayBar({required this.hidden, required this.child});

  final bool hidden;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: hidden,
      child: AnimatedSlide(
        offset: hidden ? const Offset(0, 1.2) : Offset.zero,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        child: child,
      ),
    );
  }
}

/// Android: collapses the bar's height so the page uses the full screen.
class _CollapseBar extends StatelessWidget {
  const _CollapseBar({required this.hidden, required this.child});

  final bool hidden;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedAlign(
        alignment: Alignment.topCenter,
        heightFactor: hidden ? 0 : 1,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        child: child,
      ),
    );
  }
}

// ===========================================================================
// iOS: native glass tab bar
// ===========================================================================

class _IosGlassTabBar extends StatelessWidget {
  const _IosGlassTabBar({required this.currentIndex, required this.onSelected});

  final int currentIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return CNTabBar(
      items: [
        for (final d in appDestinations)
          CNTabBarItem(
            label: d.label,
            icon: CNSymbol(d.sfSymbol),
            activeIcon: CNSymbol(d.sfSymbolSelected),
          ),
      ],
      currentIndex: currentIndex,
      onTap: onSelected,
      tint: Theme.of(context).colorScheme.primary,
    );
  }
}

// ===========================================================================
// ANDROID: Material 3, no indicator behind the icon
// ===========================================================================

class _AndroidNavBar extends StatelessWidget {
  const _AndroidNavBar({required this.currentIndex, required this.onSelected});

  final int currentIndex;
  final ValueChanged<int> onSelected;

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
          indicatorColor: Colors.transparent, // no pill behind the icon
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
          destinations: [
            for (final d in appDestinations)
              NavigationDestination(
                icon: Icon(d.icon),
                selectedIcon: Icon(d.selectedIcon),
                label: d.label,
                tooltip: '',
              ),
          ],
        ),
      ),
    );
  }
}
