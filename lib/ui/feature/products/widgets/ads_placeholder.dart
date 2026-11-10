import 'package:material_ui/material_ui.dart';
import 'package:yecontinuity/ui/feature/products/widgets/shimmer_box.dart';

class AdsPlaceholder extends StatelessWidget {
  const AdsPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: const SizedBox(height: 160, child: ShimmerBox()),
      ),
    );
  }
}
