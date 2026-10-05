import 'package:material_ui/material_ui.dart';

/// Paleta YEContinuity — seed #00676C
///
/// Regra 60-30-10 aplicada ao ColorScheme:
///  • 60% NEUTROS   → surface, surfaceContainer*, onSurface (fundos, listas, texto)
///  • 30% SECUNDÁRIO → secondaryContainer, primaryContainer (tints de teal:
///                     nav bar, chips, cards destacados, banners)
///  • 10% ACENTO    → primary (CTA principal, FAB, links, foco, ícones ativos)
abstract final class AppColors {
  // ── Brand ────────────────────────────────────────────────
  static const brand = Color(0xFF00676C);

  // ── Neutros auxiliares (mantidos para usos fora do ColorScheme) ──
  static const whiteTransparent = Color(0x4DFFFFFF);
  static const blackTransparent = Color(0x4D000000);

  // ── Semânticas extra (não existem no ColorScheme) ────────
  static const successLight = Color(0xFF2E7D32);
  static const successDark = Color(0xFF81C995);
  static const warningLight = Color(0xFFFFB95C);
  static const warningDark = Color(0xFFFFB95C);

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,

    // 10% — acento
    primary: brand,
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFF9CF0F5),
    onPrimaryContainer: Color(0xFF002022),

    // 30% — secundário (teal suave)
    secondary: Color(0xFF4A6364),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFCCE8E9),
    onSecondaryContainer: Color(0xFF051F21),

    // Terciário (azul-acinzentado, para destaques pontuais)
    tertiary: Color(0xFF4E5F7D),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFD6E3FF),
    onTertiaryContainer: Color(0xFF081B36),

    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),

    // 60% — neutros (com ligeiro tint teal)
    surface: Color(0xFFF4FAFA),
    onSurface: Color(0xFF161D1D),
    onSurfaceVariant: Color(0xFF3F4949),
    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerLow: Color(0xFFEEF5F5),
    surfaceContainer: Color(0xFFE9EFEF),
    surfaceContainerHigh: Color(0xFFE3E9E9),
    surfaceContainerHighest: Color(0xFFDDE4E4),
    surfaceDim: Color(0xFFD5DBDB),
    surfaceBright: Color(0xFFF4FAFA),

    outline: Color(0xFF6F7979),
    outlineVariant: Color(0xFFBEC8C9),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFF2B3231),
    onInverseSurface: Color(0xFFECF2F2),
    inversePrimary: Color(0xFF80D4D9),
    surfaceTint: brand,
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,

    // 10% — acento (tom mais claro para contraste em fundo escuro)
    primary: Color(0xFF80D4D9),
    onPrimary: Color(0xFF003739),
    primaryContainer: Color(0xFF004F53),
    onPrimaryContainer: Color(0xFF9CF0F5),

    // 30% — secundário
    secondary: Color(0xFFB1CCCD),
    onSecondary: Color(0xFF1C3536),
    secondaryContainer: Color(0xFF334B4C),
    onSecondaryContainer: Color(0xFFCCE8E9),

    tertiary: Color(0xFFB6C7E9),
    onTertiary: Color(0xFF1F2F4C),
    tertiaryContainer: Color(0xFF364764),
    onTertiaryContainer: Color(0xFFD6E3FF),

    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),

    // 60% — neutros
    surface: Color(0xFF0E1415),
    onSurface: Color(0xFFDDE4E4),
    onSurfaceVariant: Color(0xFFBEC8C9),
    surfaceContainerLowest: Color(0xFF090F10),
    surfaceContainerLow: Color(0xFF161D1D),
    surfaceContainer: Color(0xFF1A2121),
    surfaceContainerHigh: Color(0xFF252B2C),
    surfaceContainerHighest: Color(0xFF303636),
    surfaceDim: Color(0xFF0E1415),
    surfaceBright: Color(0xFF343A3B),

    outline: Color(0xFF899393),
    outlineVariant: Color(0xFF3F4949),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFFDDE4E4),
    onInverseSurface: Color(0xFF2B3231),
    inversePrimary: brand,
    surfaceTint: Color(0xFF80D4D9),
  );
}
