import 'package:material_ui/material_ui.dart';
import 'package:yecontinuity/ui/feature/products/widgets/shimmer_box.dart';

class const ProductsGridSkeleton({super.key}) extends StatelessWidget {
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
            child: const ShimmerBox(),
          ),
          childCount: 6,
        ),
      ),
    );
  }
}
