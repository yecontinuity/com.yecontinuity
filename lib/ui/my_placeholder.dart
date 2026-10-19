import 'package:material_ui/material_ui.dart';
import 'package:yecontinuity/ui/core/ui/widgets/logo_avatar.dart';

class MyPlaceholder extends StatelessWidget {
  const MyPlaceholder(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 16),
          const LogoAvatar(),
        ],
      ),
    );
  }
}
