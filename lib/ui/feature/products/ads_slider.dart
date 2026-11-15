import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:yecontinuity/ui/feature/products/providers/products_provider.dart';
import 'package:yecontinuity/ui/feature/products/widgets/ads_placeholder.dart';
import 'package:yecontinuity/ui/feature/products/widgets/shimmer_box.dart';

class AdsSlider extends ConsumerStatefulWidget {
  const AdsSlider({super.key});

  @override
  ConsumerState<AdsSlider> createState() => _AdsSliderState();
}

class _AdsSliderState extends ConsumerState<AdsSlider> {
  final _pageController = PageController(viewportFraction: 0.92);
  Timer? _timer;
  int _current = 0;

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay(int length) {
    _timer?.cancel();
    if (length <= 1) return;
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!_pageController.hasClients) return;
      final next = (_current + 1) % length;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final adsAsync = ref.watch(adsProvider);

    return adsAsync.when(
      loading: () => const AdsPlaceholder(),
      error: (_, __) => const SizedBox.shrink(),
      data: (ads) {
        if (ads.isEmpty) return const SizedBox.shrink();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && _timer == null) _startAutoPlay(ads.length);
        });

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              SizedBox(
                height: 160,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: ads.length,
                  onPageChanged: (i) => setState(() => _current = i),
                  itemBuilder: (context, index) {
                    final ad = ads[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: GestureDetector(
                        onTap: () {},
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                ad.imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                loadingBuilder: (context, child, progress) =>
                                    progress == null
                                    ? child
                                    : const ShimmerBox(),
                                errorBuilder: (_, __, ___) => Container(
                                  color: Colors.grey.shade200,
                                  child: const Icon(
                                    Icons.broken_image_outlined,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(165, 0, 0, 0),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            Positioned(
                              left: 10,
                              top: 10,
                              child: SizedBox(
                                width: 290,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ad.title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      ad.subTitle,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // child: Expanded(
                              //   child: Text.rich(
                              //     maxLines: 3,
                              //     TextSpan(
                              //       style: const TextStyle(color: Colors.white),
                              //       children: [
                              //         TextSpan(
                              //           text: '${ad.title}\n',
                              //           style: TextStyle(fontSize: 16),
                              //         ),
                              //         TextSpan(
                              //           text: ad.subTitle,
                              //           style: const TextStyle(
                              //             fontSize: 24,
                              //             fontWeight: FontWeight.bold,
                              //             overflow: TextOverflow.clip,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(ads.length, (i) {
                  final active = i == _current;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    height: 6,
                    width: active ? 18 : 6,
                    decoration: BoxDecoration(
                      color: active
                          ? Theme.of(context).primaryColor
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
