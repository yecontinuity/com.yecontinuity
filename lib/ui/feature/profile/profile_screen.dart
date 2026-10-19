import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:yecontinuity/ui/core/ui/widgets/primary_button.dart';
import 'package:yecontinuity/ui/feature/auth/models/auth_state.dart';
import 'package:yecontinuity/ui/feature/auth/providers/auth_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isMe = authState is AuthStateAuthenticated;

    return Scaffold(
      body: isMe
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Olá!'),
                  Text(authState.user.fullName),
                  Text(
                    'Registado desde: ${(DateTime.parse(authState.user.createdAt)).day}/${(DateTime.parse(authState.user.createdAt)).month}/${(DateTime.parse(authState.user.createdAt)).year}',
                  ),
                  SizedBox(
                    width: 200,
                    child: Consumer(
                      builder: (context, ref, child) {
                        return PrimaryButton(
                          label: 'Sair',
                          onTap: () =>
                              ref.watch(authProvider.notifier).logout(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: Text('Não estás authenticado(a)'),
            ),
    );
  }
}
