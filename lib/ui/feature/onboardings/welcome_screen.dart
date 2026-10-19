import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:yecontinuity/routing/router.dart';
import 'package:yecontinuity/ui/core/ui/components/app_photo.dart';
import 'package:yecontinuity/ui/core/ui/widgets/logo_avatar.dart';
import 'package:yecontinuity/ui/core/ui/widgets/primary_button.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const _onPhoto = Colors.white;
  static const _scrim = Color(0xFF001F21);

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarContrastEnforced: false,
      ),
      child: Scaffold(
        backgroundColor: _scrim,
        body: Stack(
          fit: StackFit.expand,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: reduceMotion ? 1.0 : 1.1, end: 1.0),
              duration: reduceMotion
                  ? Duration.zero
                  : const Duration(milliseconds: 1600),
              curve: Curves.easeOutCubic,
              builder: (_, scale, child) =>
                  Transform.scale(scale: scale, child: child),
              child: const AppPhoto(
                AppImages.welcome,
                alignment: Alignment(0, -0.2),
                semanticLabel: 'Escolher com qualidade o que doar para o outro',
              ),
            ),

            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.3, 0.55, 1.0],
                  colors: [
                    Color(0x99001F21),
                    Color(0x00001F21),
                    Color(0x8C001F21),
                    Color(0xF2001F21),
                  ],
                ),
              ),
            ),

            SafeArea(
              child: CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const LogoAvatar(),
                          const Spacer(),
                          _FadeSlideIn(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Semantics(
                                  header: true,
                                  child: Text(
                                    'Conectamos\nnecessidade\ncom generosidade.',
                                    style: text.headlineLarge?.copyWith(
                                      fontSize: 40,
                                      height: 1.08,
                                      fontWeight: FontWeight.w600,
                                      color: _onPhoto,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  'Criamos pontes de solidariedade.',
                                  style: text.bodyLarge?.copyWith(
                                    color: _onPhoto.withValues(alpha: .86),
                                  ),
                                ),
                                const SizedBox(height: 32),
                                PrimaryButton(
                                  label: 'Começar',
                                  trailing: Icons.arrow_forward_rounded,
                                  onTap: () =>
                                      const RegisterRoute().push(context),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  height: 54,
                                  child: OutlinedButton(
                                    onPressed: () =>
                                        const LoginRoute().push(context),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: _onPhoto,
                                      backgroundColor: Colors.white.withValues(
                                        alpha: .12,
                                      ),
                                      side: BorderSide(
                                        color: Colors.white.withValues(
                                          alpha: .55,
                                        ),
                                      ),
                                      shape: const StadiumBorder(),
                                      minimumSize: const Size.fromHeight(54),
                                    ),
                                    child: const Text('Já tenho conta'),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Center(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(text: 'sobre a '),
                                        TextSpan(
                                          text: 'YEContinuity',
                                          style: TextStyle(
                                            // decorationStyle:
                                            //     TextDecoration.underline,
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () async {
                                              await launchUrl(
                                                Uri.parse(
                                                  'https://yecontinuity.com/about',
                                                ),
                                              );
                                              print(
                                                'clicou em sobre a YEContinuity',
                                              );
                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FadeSlideIn extends StatelessWidget {
  const _FadeSlideIn({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: reduceMotion ? 1.0 : 0.0, end: 1.0),
      duration: reduceMotion
          ? Duration.zero
          : const Duration(milliseconds: 900),
      curve: Curves.easeOutCubic,
      builder: (_, t, child) => Opacity(
        opacity: t,
        child: Transform.translate(
          offset: Offset(0, 24 * (1 - t)),
          child: child,
        ),
      ),
      child: child,
    );
  }
}
