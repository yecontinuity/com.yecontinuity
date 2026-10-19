import 'package:material_ui/material_ui.dart';

/// Caminhos das fotografias da app.
///
/// Coloca os ficheiros em `assets/images/` e declara a pasta no pubspec.yaml:
///
/// ```yaml
/// flutter:
///   assets:
///     - assets/images/
/// ```
abstract final class AppImages {
  /// Vertical (9:16, ~1080x1920): pessoa a oferecer um presente.
  static const welcome = 'assets/images/welcome_gift.jpg';

  /// Verticais 4:5 (~1080x1350), um por passo do onboarding.
  static const onboardingShare = 'assets/images/onboarding_share.jpg';
  static const onboardingFind = 'assets/images/onboarding_find.jpg';
  static const onboardingConnect = 'assets/images/onboarding_connect.jpg';
}

/// Fotografia a preencher o espaço (cover), com fallback na paleta do tema.
///
/// Se o asset ainda não existir, mostra um gradiente teal com um ícone em vez
/// de rebentar, por isso podes desenvolver o ecrã antes de teres as fotos.
class AppPhoto extends StatelessWidget {
  const AppPhoto(
    this.asset, {
    super.key,
    this.alignment = Alignment.center,
    this.fallbackIcon = Icons.volunteer_activism_rounded,
    this.semanticLabel,
  });

  final String asset;
  final Alignment alignment;
  final IconData fallbackIcon;

  /// Descrição para leitores de ecrã. Se for `null`, a imagem é decorativa
  /// e é ignorada pelo TalkBack/VoiceOver.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Image.asset(
      asset,
      fit: BoxFit.cover,
      alignment: alignment,
      width: double.infinity,
      height: double.infinity,
      gaplessPlayback: true,
      semanticLabel: semanticLabel,
      excludeFromSemantics: semanticLabel == null,
      errorBuilder: (_, __, ___) => DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [scheme.primaryContainer, scheme.secondaryContainer],
          ),
        ),
        child: Center(
          child: Icon(
            fallbackIcon,
            size: 72,
            color: scheme.onPrimaryContainer.withValues(alpha: .55),
          ),
        ),
      ),
    );
  }
}
