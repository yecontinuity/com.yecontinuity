import 'package:material_ui/material_ui.dart';

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
