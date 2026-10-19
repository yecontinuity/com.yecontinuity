import 'package:material_ui/material_ui.dart';

/// Botão de submit (Login / Registar).
///
/// Não define nenhuma cor: herda tudo do `AppTheme`
/// (filledButtonTheme / outlinedButtonTheme), por isso muda sozinho
/// entre light e dark.
///
///  • primary = true  → FilledButton   (acento, ~10%)
///  • primary = false → OutlinedButton (ação secundária)
class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.primary = true,
  });

  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    // Com onPressed == null o botão fica "disabled" e usa as cores de
    // disabled do tema; o spinner acompanha essa cor.
    final child = isLoading
        ? SizedBox.square(
            dimension: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: scheme.onSurface.withValues(alpha: 0.38),
            ),
          )
        : Text(text);

    final callback = isLoading ? null : onPressed;

    return primary
        ? FilledButton(onPressed: callback, child: child)
        : OutlinedButton(onPressed: callback, child: child);
  }
}
