// lib/ui/feature/onboardings/splash_screen.dart
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:yecontinuity/ui/core/ui/widgets/logo_avatar.dart';

/// Splash em Flutter: aparece enquanto se verifica a sessão.
///
/// Não navega: o `redirect` do router tira o utilizador daqui assim que a
/// sessão e o onboarding estão resolvidos. Segue o tema light/dark.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Android: statusBarIconBrightness. iOS: statusBarBrightness (invertido).
      value: (isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark)
          .copyWith(statusBarColor: Colors.transparent),
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Brilho suave em teal atrás do logótipo.
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, -0.1),
                  radius: 0.85,
                  colors: [
                    scheme.primaryContainer.withValues(alpha: .6),
                    scheme.surface,
                  ],
                ),
              ),
            ),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: reduceMotion ? 1.0 : 0.0, end: 1.0),
              duration: reduceMotion
                  ? Duration.zero
                  : const Duration(milliseconds: 1400),
              curve: Curves.linear,
              builder: (_, t, __) {
                // Logo: 0 → 60% da animação. Loader: 60% → 100%.
                final logoT = Curves.easeOutCubic.transform(
                  (t / 0.6).clamp(0, 1),
                );
                final loaderT = ((t - 0.6) / 0.4).clamp(0.0, 1.0);

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Center(
                      child: Opacity(
                        opacity: logoT,
                        child: Transform.scale(
                          scale: 0.85 + 0.15 * logoT,
                          child: Semantics(
                            label: 'YEContinuity',
                            child: LogoAvatar(),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 48),
                          child: Opacity(
                            opacity: loaderT,
                            child: SizedBox.square(
                              dimension: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: scheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
