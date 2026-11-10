import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:yecontinuity/domain/produts/product.dart';
import 'package:yecontinuity/ui/feature/auth/providers/auth_provider.dart';
import 'package:yecontinuity/ui/feature/products/providers/products_provider.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  const ProductsScreen({super.key});

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 300) {
      ref.read(paginatedProductsProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(paginatedProductsProvider, (_, next) {
      final error = next.error;
      if (error is DioException && error.response?.statusCode == 401) {
        ref.read(authProvider.notifier).logout();
      }
    });

    final productsAsync = ref.watch(paginatedProductsProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(adsProvider);
            await ref.read(paginatedProductsProvider.notifier).refresh();
          },
          child: CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                pinned: false,
                toolbarHeight: 72,
                automaticallyImplyLeading: false,
                titleSpacing: 0,
                elevation: 0,
                scrolledUnderElevation: 0,
                surfaceTintColor: Colors.transparent,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: const HomeHeader(),
              ),
              const SliverToBoxAdapter(child: AdsSlider()),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SectionTitle(title: 'Artigos disponíveis'),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              ..._buildProductsSlivers(productsAsync),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 24 + MediaQuery.paddingOf(context).bottom,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildProductsSlivers(AsyncValue<PaginatedProducts> async) {
    return async.when(
      loading: () => [const _ProductsGridSkeleton()],
      error: (error, _) => [
        SliverToBoxAdapter(
          child: _ErrorView(
            error: error,
            onRetry: () => ref.invalidate(paginatedProductsProvider),
          ),
        ),
      ],
      data: (data) {
        if (data.items.isEmpty) {
          return [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(48),
                child: Center(child: Text('Nenhum artigo encontrado')),
              ),
            ),
          ];
        }

        return [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 20,
                childAspectRatio: 0.7,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => ProductCard(
                  product: data.items[index],
                  onPress: () {},
                ),
                childCount: data.items.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _PaginationFooter(
              isLoading: data.isLoadingMore,
              failed: data.loadMoreFailed,
              hasMore: data.hasMore,
              onRetry: () =>
                  ref.read(paginatedProductsProvider.notifier).loadMore(),
            ),
          ),
        ];
      },
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Expanded(child: SearchField()),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
    );
  }
}

class SearchField extends ConsumerStatefulWidget {
  const SearchField({super.key});

  @override
  ConsumerState<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends ConsumerState<SearchField> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    setState(() {});
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(productsSearchQueryProvider.notifier).set(value);
    });
  }

  void _clear() {
    _controller.clear();
    _debounce?.cancel();
    ref.read(productsSearchQueryProvider.notifier).set('');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide.none,
    );

    return TextField(
      controller: _controller,
      onChanged: _onChanged,
      textInputAction: TextInputAction.search,
      onSubmitted: (v) {
        _debounce?.cancel();
        ref.read(productsSearchQueryProvider.notifier).set(v);
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF979797).withValues(alpha: 0.1),
        hintText: 'O que procuras?',
        hintStyle: const TextStyle(color: Color(0xFF757575)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _controller.text.isEmpty
            ? null
            : IconButton(icon: const Icon(Icons.close), onPressed: _clear),
      ),
    );
  }
}

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
      loading: () => const _AdsPlaceholder(),
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
                                    : const _ShimmerBox(),
                                errorBuilder: (_, __, ___) => Container(
                                  color: Colors.grey.shade200,
                                  child: const Icon(
                                    Icons.broken_image_outlined,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              child: const Text.rich(
                                TextSpan(
                                  style: TextStyle(color: Colors.white),
                                  children: [
                                    TextSpan(text: "21Media o seu estúdio\n"),
                                    TextSpan(
                                      text: "Audio visual agora\n é mais fácil",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              left: 10,
                              top: 10,
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

class _AdsPlaceholder extends StatelessWidget {
  const _AdsPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: const SizedBox(height: 160, child: _ShimmerBox()),
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox();

  @override
  Widget build(BuildContext context) =>
      Container(color: Colors.grey.shade200, width: double.infinity);
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title, this.press});

  final String title;
  final GestureTapCallback? press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        if (press != null)
          TextButton(
            onPressed: press,
            style: TextButton.styleFrom(foregroundColor: Colors.grey),
            child: const Text('Ver mais'),
          ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onPress,
  });

  final Product product;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.02,

              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                ),
                child: Image.network(
                  product.thumbnail,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  loadingBuilder: (context, child, progress) =>
                      progress == null ? child : const _ShimmerBox(),
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image_not_supported_outlined),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        product.location.city,
                        style: const TextStyle(fontSize: 12),
                      ),
                      Spacer(),
                      Text(
                        product.createdAt,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
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

class _ProductsGridSkeleton extends StatelessWidget {
  const _ProductsGridSkeleton();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 20,
          childAspectRatio: 0.7,
        ),
        delegate: SliverChildBuilderDelegate(
          (_, __) => ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: const _ShimmerBox(),
          ),
          childCount: 6,
        ),
      ),
    );
  }
}

class _PaginationFooter extends StatelessWidget {
  const _PaginationFooter({
    required this.isLoading,
    required this.failed,
    required this.hasMore,
    required this.onRetry,
  });

  final bool isLoading, failed, hasMore;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (failed) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Falhou. Tentar novamente'),
          ),
        ),
      );
    }
    if (!hasMore) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(
          child: Text('Chegaste ao fim', style: TextStyle(color: Colors.grey)),
        ),
      );
    }
    return const SizedBox(height: 24);
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (error is DioException &&
        (error as DioException).response?.statusCode == 401) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Icon(Icons.error_outline, size: 48),
          const SizedBox(height: 16),
          Text(
            'Não foi possível carregar os artigos',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            error is DioException
                ? ((error as DioException).message ?? 'Erro de rede')
                : error.toString(),
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }
}
