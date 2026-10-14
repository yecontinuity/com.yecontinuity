import 'package:material_ui/material_ui.dart';
import 'package:yecontinuity/ui/core/themes/theme.dart';

class LogoAvatar extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final double size = 90;
    return SizedBox(
      height: size,
      width: size,
      child: CircleAvatar(
        child: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.cover,
          width: size,
        ),
        backgroundColor: AppTheme.lightTheme.primaryColor,
        radius: 90,
      ),
    );
  }
}
