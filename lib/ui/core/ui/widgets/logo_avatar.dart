import 'package:material_ui/material_ui.dart';
import 'package:yecontinuity/ui/core/themes/theme.dart';

class LogoAvatar extends StatelessWidget {
  final double size;
  final double radius;

  const new({
    super.key,
    this.size = 90,
    this.radius = 90,
  });

  @override
  Widget build(BuildContext context) {
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
        radius: radius,
      ),
    );
  }
}
