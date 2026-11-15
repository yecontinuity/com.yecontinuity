import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yecontinuity/core/constants.dart';
import 'package:yecontinuity/core/dio_client.dart';
import 'package:yecontinuity/domain/produts/product.dart';

class AdBanner {
  final String id;
  final String imageUrl;
  final String? link;
  final String title;
  final String subTitle;

  const AdBanner({
    required this.id,
    required this.imageUrl,
    this.link,
    required this.title,
    required this.subTitle,
  });
}

class PaginatedProducts {
  final List<Product> items;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;
  final bool loadMoreFailed;

  const PaginatedProducts({
    required this.items,
    required this.page,
    required this.hasMore,
    this.isLoadingMore = false,
    this.loadMoreFailed = false,
  });

  PaginatedProducts copyWith({
    List<Product>? items,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
    bool? loadMoreFailed,
  }) {
    return PaginatedProducts(
      items: items ?? this.items,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      loadMoreFailed: loadMoreFailed ?? this.loadMoreFailed,
    );
  }
}

// ---------------------------------------------------------------------------
// Anúncios (slider)
// ---------------------------------------------------------------------------

/// TODO: substituir por chamada ao teu endpoint de anúncios, quando existir.
/// Por agora devolve imagens de exemplo para veres o slider a funcionar.
final adsProvider = FutureProvider<List<AdBanner>>((ref) async {
  return const [
    AdBanner(
      id: '1',
      imageUrl: 'https://picsum.photos/id/1035/800/400',
      title: 'Está um belo dia ☀️',
      subTitle: 'Se não poderes fazer tudo, faça tudo o que poderes.',
    ),
    AdBanner(
      id: '2',
      imageUrl: 'https://picsum.photos/id/1011/800/400',
      title: '21Media Studio',
      subTitle: 'Audio visual! Não precisa ser uma sonho.',
    ),
    AdBanner(
      id: '3',
      imageUrl: 'https://picsum.photos/id/1025/800/400',
      title: 'Três Mundos',
      subTitle: 'A remodelação não precisa esperar muito',
    ),
  ];
});

// ---------------------------------------------------------------------------
// Pesquisa
// ---------------------------------------------------------------------------

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void set(String value) => state = value.trim();
}

final productsSearchQueryProvider =
    NotifierProvider<SearchQueryNotifier, String>(SearchQueryNotifier.new);

// ---------------------------------------------------------------------------
// Lista paginada (infinite scroll)
// ---------------------------------------------------------------------------

class PaginatedProductsNotifier extends AsyncNotifier<PaginatedProducts> {
  /// Ao mudar a pesquisa, o build() corre outra vez e a lista reinicia na página 1.
  @override
  Future<PaginatedProducts> build() async {
    final query = ref.watch(productsSearchQueryProvider);
    final items = await _fetchPage(page: 1, query: query);

    return PaginatedProducts(
      items: items,
      page: 1,
      // A API não devolve o tamanho da página: se vier vazia, acabou.
      hasMore: items.isNotEmpty,
    );
  }

  Future<List<Product>> _fetchPage({
    required int page,
    required String query,
  }) async {
    final dio = ref.read(authenticatedDioProvider);

    final response = await dio.get(
      '${ApiConstants.baseUrl}${ApiConstants.products}',
      queryParameters: {
        'page': page,
        'searchTerm': query,
        'availableOnly': true,
      },
    );

    final data = response.data['items'] as List<dynamic>;

    return data
        .map((json) => Product.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;

    state = AsyncData(
      current.copyWith(isLoadingMore: true, loadMoreFailed: false),
    );

    try {
      final nextPage = current.page + 1;
      final newItems = await _fetchPage(
        page: nextPage,
        query: ref.read(productsSearchQueryProvider),
      );

      state = AsyncData(
        current.copyWith(
          items: [...current.items, ...newItems],
          page: nextPage,
          hasMore: newItems.isNotEmpty,
          isLoadingMore: false,
        ),
      );
    } catch (_) {
      // Mantém os itens já carregados e mostra "tentar novamente" no fim.
      state = AsyncData(
        current.copyWith(isLoadingMore: false, loadMoreFailed: true),
      );
    }
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

final paginatedProductsProvider =
    AsyncNotifierProvider<PaginatedProductsNotifier, PaginatedProducts>(
      PaginatedProductsNotifier.new,
    );
