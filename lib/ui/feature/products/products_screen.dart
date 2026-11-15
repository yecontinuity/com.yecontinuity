import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:yecontinuity/ui/feature/auth/providers/auth_provider.dart';
import 'package:yecontinuity/ui/feature/products/ads_slider.dart';
import 'package:yecontinuity/ui/feature/products/widgets/error_view.dart';
import 'package:yecontinuity/ui/feature/products/widgets/products_header.dart';
import 'package:yecontinuity/ui/feature/products/widgets/section_title.dart';
import 'package:yecontinuity/ui/feature/products/widgets/product_card.dart';
import 'package:yecontinuity/ui/feature/products/widgets/products_grid_skeleton.dart';
import 'package:yecontinuity/ui/feature/products/widgets/pagination_footer.dart';
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
                title: const ProductsHeader(),
              ),
              const SliverToBoxAdapter(child: AdsSlider()),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
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
      loading: () => [const ProductsGridSkeleton()],
      error: (error, _) => [
        SliverToBoxAdapter(
          child: ErrorView(
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
            padding: const EdgeInsets.symmetric(horizontal: 8),
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
            child: PaginationFooter(
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
