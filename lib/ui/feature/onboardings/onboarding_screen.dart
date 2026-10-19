import 'dart:ui' show ImageFilter;

import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:yecontinuity/ui/core/ui/components/app_photo.dart';
import 'package:yecontinuity/ui/core/ui/widgets/primary_button.dart';

import 'package:yecontinuity/ui/core/themes/tag_chip_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, required this.onFinished});

  final VoidCallback onFinished;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const _steps = [
    _Step(
      image: AppImages.onboardingShare,
      icon: Icons.volunteer_activism_rounded,
      tag: 'Partilha',
      title: 'O que te sobra pode fazer falta a alguém',
      body: 'Publica o que já não usas, como roupa, móveis ou brinquedos, e dá-lhe uma segunda vida.',
      imageLabel: 'Pessoa a entregar um presente',
    ),
    _Step(
      image: AppImages.onboardingFind,
      icon: Icons.favorite_border_rounded,
      tag: 'Encontra',
      title: 'Encontra artigos úteis em bom estado',
      body: 'Partilha na app, nunca sabes se o teu vizinho ao lado pode precisar.',
      imageLabel: 'Encontrar artigos é na YEContinuity',
    ),
    _Step(
      image: AppImages.onboardingConnect,
      icon: Icons.chat_bubble_outline_rounded,
      tag: 'Conecta',
      title: 'Uma conversa, um gesto, uma ponte',
      body: 'Fala diretamente com a outra pessoa e combina a entrega ao teu ritmo.',
      imageLabel: 'Duas pessoas a conversar',
    ),
  ];

  final _controller = PageController();
  int _index = 0;

  bool get _isLast => _index == _steps.length - 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    for (final s in _steps) {
      precacheImage(AssetImage(s.image), context, onError: (_, __) {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_isLast) {
      widget.onFinished();
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: _steps.length,
                    onPageChanged: (i) {
                      HapticFeedback.selectionClick();
                      setState(() => _index = i);
                    },
                    itemBuilder: (_, i) => _StepPage(
                      step: _steps[i],
                      index: i,
                      controller: _controller,
                    ),
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _Dots(count: _steps.length, index: _index),
                        const SizedBox(height: 20),
                        PrimaryButton(
                          label: _isLast ? 'Começar' : 'Continuar',
                          trailing: Icons.arrow_forward_rounded,
                          onTap: _next,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Positioned(
              top: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 16, 0),
                  child: AnimatedOpacity(
                    opacity: _isLast ? 0 : 1,
                    duration: const Duration(milliseconds: 200),
                    child: IgnorePointer(
                      ignoring: _isLast,
                      child: _SkipPill(onPressed: widget.onFinished),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Step {
  const _Step({
    required this.image,
    required this.icon,
    required this.tag,
    required this.title,
    required this.body,
    required this.imageLabel,
    this.imageAlignment = Alignment.center,
  });

  final String image;
  final IconData icon;
  final String tag;
  final String title;
  final String body;
  final String imageLabel;
  final Alignment imageAlignment;
}

class _StepPage extends StatelessWidget {
  const _StepPage({
    required this.step,
    required this.index,
    required this.controller,
  });

  final _Step step;
  final int index;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;
    final tag = theme.extension<TagChipTheme>()!;

    return Column(
      children: [
        Expanded(
          flex: 6,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(36),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                AnimatedBuilder(
                  animation: controller,
                  builder: (_, child) {
                    var delta = 0.0;
                    if (controller.hasClients &&
                        controller.position.haveDimensions) {
                      delta = ((controller.page ?? index.toDouble()) - index)
                          .clamp(-1.0, 1.0)
                          .toDouble();
                    }
                    return Transform.translate(
                      offset: Offset(-delta * 36, 0),
                      child: Transform.scale(scale: 1.14, child: child),
                    );
                  },
                  child: AppPhoto(
                    step.image,
                    alignment: step.imageAlignment,
                    fallbackIcon: step.icon,
                    semanticLabel: step.imageLabel,
                  ),
                ),

                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 0.28, 0.6, 1.0],
                      colors: [
                        Color(0x73000000),
                        Color(0x00000000),
                        Color(0x00000000),
                        Color(0x8C000000),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  left: 24,
                  bottom: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        color: tag.chipColor,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(step.icon, size: 16, color: tag.onChipColor),
                            const SizedBox(width: 6),
                            Text(
                              step.tag,
                              style: TextStyle(
                                color: tag.onChipColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(28, 28, 28, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  header: true,
                  child: Text(
                    step.title,
                    style: text.headlineLarge?.copyWith(
                      fontSize: 28,
                      height: 1.15,
                      color: scheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  step.body,
                  style: text.bodyLarge?.copyWith(
                    height: 1.45,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Semantics(
      label: 'Passo ${index + 1} de $count',
      child: ExcludeSemantics(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < count; i++)
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: i == index ? 28 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: i == index ? scheme.primary : scheme.outlineVariant,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SkipPill extends StatelessWidget {
  const _SkipPill({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: scheme.surface.withValues(alpha: .88),
      shape: const StadiumBorder(),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onPressed,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 44, minWidth: 44),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              widthFactor: 1,
              child: Text(
                'Saltar',
                style: TextStyle(
                  color: scheme.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
