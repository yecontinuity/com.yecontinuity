import 'package:material_ui/material_ui.dart';

/// Tema para chips/tags sobrepostos a imagens (ex.: categoria no card do artigo).
///
/// Uso:
/// ```dart
/// final tag = Theme.of(context).extension<TagChipTheme>()!;
/// // ou, com a extensão abaixo:
/// final tag = context.tagChipTheme;
/// ```
@immutable
class TagChipTheme extends ThemeExtension<TagChipTheme> {
  const TagChipTheme({required this.chipColor, required this.onChipColor});

  /// Fundo do chip (normalmente semitransparente).
  final Color chipColor;

  /// Cor do texto/ícone sobre o chip.
  final Color onChipColor;

  @override
  TagChipTheme copyWith({Color? chipColor, Color? onChipColor}) {
    return TagChipTheme(
      chipColor: chipColor ?? this.chipColor,
      onChipColor: onChipColor ?? this.onChipColor,
    );
  }

  @override
  TagChipTheme lerp(ThemeExtension<TagChipTheme>? other, double t) {
    if (other is! TagChipTheme) return this;
    return TagChipTheme(
      chipColor: Color.lerp(chipColor, other.chipColor, t)!,
      onChipColor: Color.lerp(onChipColor, other.onChipColor, t)!,
    );
  }
}

extension TagChipThemeX on BuildContext {
  /// Atalho para `Theme.of(this).extension<TagChipTheme>()!`.
  TagChipTheme get tagChipTheme => Theme.of(this).extension<TagChipTheme>()!;
}
