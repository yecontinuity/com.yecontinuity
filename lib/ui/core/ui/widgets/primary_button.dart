import 'package:material_ui/material_ui.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.trailing,
    this.leading,
  });

  final String label;
  final IconData? trailing;
  final IconData? leading;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 22),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leading != null) ...[
                  Icon(leading, size: 22),
                  const SizedBox(width: 10),
                ],
                Text(label),
              ],
            ),
            if (trailing != null)
              Align(
                alignment: Alignment.centerRight,
                child: Icon(trailing, size: 20),
              ),
          ],
        ),
      ),
    );
  }
}
