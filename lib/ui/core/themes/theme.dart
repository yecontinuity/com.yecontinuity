import 'package:material_ui/material_ui.dart';
import 'package:yecontinuity/ui/core/themes/colors.dart';
import 'package:yecontinuity/ui/core/themes/tag_chip_theme.dart';

abstract final class AppTheme {
  static final ThemeData lightTheme = _build(
    AppColors.lightColorScheme,
    tagChip: const TagChipTheme(
      chipColor: AppColors.whiteTransparent,
      onChipColor: Colors.white,
    ),
  );

  static final ThemeData darkTheme = _build(
    AppColors.darkColorScheme,
    tagChip: const TagChipTheme(
      chipColor: AppColors.blackTransparent,
      onChipColor: Colors.white,
    ),
  );

  static TextTheme _textTheme(ColorScheme s) => TextTheme(
    headlineLarge: const TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
    headlineSmall: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
    titleMedium: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    bodyLarge: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
    bodyMedium: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: s.onSurfaceVariant,
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: s.onSurfaceVariant,
    ),
    labelLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: s.onSurfaceVariant,
    ),
  );

  static ThemeData _build(ColorScheme s, {required TagChipTheme tagChip}) {
    final radius12 = BorderRadius.circular(12);
    final radius16 = BorderRadius.circular(16);

    OutlineInputBorder border(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: radius12,
          borderSide: BorderSide(color: color, width: width),
        );

    return ThemeData(
      useMaterial3: true,
      brightness: s.brightness,
      colorScheme: s,
      textTheme: _textTheme(s),

      // ── 60% neutros: fundos e superfícies ──
      scaffoldBackgroundColor: s.surface,
      canvasColor: s.surface,
      dividerTheme: DividerThemeData(color: s.outlineVariant, space: 1),
      appBarTheme: AppBarTheme(
        backgroundColor: s.surface,
        foregroundColor: s.onSurface,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: false,
      ),

      cardTheme: CardThemeData(
        color: s.surfaceContainerLow,
        elevation: 0,
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: radius16,
          side: BorderSide(color: s.outlineVariant),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: s.surfaceContainerHigh,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: s.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: s.inverseSurface,
        contentTextStyle: TextStyle(color: s.onInverseSurface, fontSize: 14),
        shape: RoundedRectangleBorder(borderRadius: radius12),
      ),

      // ── 30% secundário: navegação, chips, inputs ──
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: s.surfaceContainer,
        surfaceTintColor: Colors.transparent,
        indicatorColor: s.secondaryContainer,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? s.onSecondaryContainer
                : s.onSurfaceVariant,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 12,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w600
                : FontWeight.w500,
            color: states.contains(WidgetState.selected)
                ? s.onSurface
                : s.onSurfaceVariant,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: s.surfaceContainerHigh,
        selectedColor: s.secondaryContainer,
        labelStyle: TextStyle(color: s.onSurface, fontSize: 14),
        secondaryLabelStyle: TextStyle(
          color: s.onSecondaryContainer,
          fontSize: 14,
        ),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationThemeData(
        filled: true,
        fillColor: s.surfaceContainerHigh,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: s.primary, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: s.onPrimary, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: s.primary, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: s.error, width: 1.0),
        ),
      ),

      // inputDecorationTheme: InputDecorationTheme(
      //   filled: true,
      //   fillColor: s.surfaceContainerHigh,
      //   hintStyle: TextStyle(
      //     color: s.onSurfaceVariant,
      //     fontSize: 18,
      //     fontWeight: FontWeight.w400,
      //   ),
      //   contentPadding: const EdgeInsets.symmetric(
      //     horizontal: 16,
      //     vertical: 16,
      //   ),
      //   border: border(Colors.transparent, 0),
      //   enabledBorder: border(Colors.transparent, 0),
      //   focusedBorder: border(s.primary, 2),
      //   errorBorder: border(s.error),
      //   focusedErrorBorder: border(s.error, 2),
      // ),

      // ── 10% acento: ações principais ──
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: s.primary,
          foregroundColor: s.onPrimary,
          minimumSize: const Size.fromHeight(52),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: radius12),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: s.primary,
          minimumSize: const Size.fromHeight(52),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          side: BorderSide(color: s.outline),
          shape: RoundedRectangleBorder(borderRadius: radius12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: s.primary,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: s.primary,
        foregroundColor: s.onPrimary,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: radius16),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: s.primary,
        linearTrackColor: s.primaryContainer,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.selected) ? s.onPrimary : s.outline,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? s.primary
              : s.surfaceContainerHighest,
        ),
      ),

      extensions: [tagChip],
    );
  }
}
