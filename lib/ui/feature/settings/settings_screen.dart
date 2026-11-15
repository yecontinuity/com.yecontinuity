// lib/ui/feature/settings/settings_screen.dart
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:yecontinuity/config/providers/theme_mode_provider.dart';
import 'package:yecontinuity/l10n/app_localizations.dart';
import 'package:yecontinuity/ui/feature/settings/providers/locale_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const _nativeNames = {
    'pt': 'Português',
    'en': 'English',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentLanguage = ref.watch(localeProvider)?.languageCode;
    final localeNotifier = ref.read(localeProvider.notifier);
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _SettingsSection(
            title: l10n.languageTitle,
            children: [
              _ChoiceTile(
                title: l10n.languageSystem,
                selected: currentLanguage == null,
                onTap: () => localeNotifier.setLocale(null),
              ),
              for (final locale in AppLocalizations.supportedLocales)
                _ChoiceTile(
                  title:
                      _nativeNames[locale.languageCode] ?? locale.languageCode,
                  selected: currentLanguage == locale.languageCode,
                  onTap: () => localeNotifier.setLocale(locale),
                ),
            ],
          ),

          const SizedBox(height: 24),

          _SettingsSection(
            title: l10n.appearanceTitle,
            padding: const EdgeInsets.all(12),
            children: [
              SegmentedButton<ThemeMode>(
                showSelectedIcon: false,
                expandedInsets: EdgeInsets.zero,
                segments: [
                  ButtonSegment(
                    value: ThemeMode.system,
                    label: Text(l10n.themeSystem),
                  ),
                  ButtonSegment(
                    value: ThemeMode.light,
                    label: Text(l10n.themeLight),
                  ),
                  ButtonSegment(
                    value: ThemeMode.dark,
                    label: Text(l10n.themeDark),
                  ),
                ],
                selected: {themeMode},
                onSelectionChanged: (selection) {
                  HapticFeedback.selectionClick();
                  ref
                      .read(themeModeProvider.notifier)
                      .setThemeMode(selection.first);
                },
              ),
            ],
          ),

          // Add more sections here (notifications, account, about...).
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.title,
    required this.children,
    this.padding = EdgeInsets.zero,
  });

  final String title;
  final List<Widget> children;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
          child: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              color: colors.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.zero,
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          color: colors.surfaceContainerLow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: colors.outlineVariant.withValues(alpha: 0.6),
            ),
          ),
          child: Padding(
            padding: padding,
            child: Column(
              children: [
                for (var i = 0; i < children.length; i++) ...[
                  if (i > 0)
                    Divider(
                      height: 1,
                      indent: 16,
                      color: colors.outlineVariant.withValues(alpha: 0.5),
                    ),
                  children[i],
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ChoiceTile extends StatelessWidget {
  const _ChoiceTile({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Semantics(
      selected: selected,
      inMutuallyExclusiveGroup: true,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            fontSize: 12,
          ),
        ),
        trailing: AnimatedOpacity(
          opacity: selected ? 1 : 0,
          duration: const Duration(milliseconds: 150),
          child: Icon(Icons.check_rounded, color: colors.primary),
        ),
        onTap: () {
          if (selected) return;
          HapticFeedback.selectionClick();
          onTap();
        },
      ),
    );
  }
}
