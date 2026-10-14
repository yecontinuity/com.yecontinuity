import 'package:material_ui/material_ui.dart';
import 'package:yecontinuity/ui/core/ui/widgets/logo_avatar.dart';

class ChatsScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Chats'),
            LogoAvatar(),
          ],
        ),
      ),
    );
  }
}
