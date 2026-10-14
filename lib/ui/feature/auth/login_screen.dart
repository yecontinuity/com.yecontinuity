import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:yecontinuity/ui/core/ui/widgets/logo_avatar.dart';
import 'package:yecontinuity/ui/feature/auth/models/auth_state.dart';

import 'providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: 24.0),
          child: switch (authState) {
            AuthStateInitial() ||
            AuthStateError() => _buildLoginForm(context, isLoading: false),
            AuthStateLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            AuthStateAuthenticated() => const Center(
              child: SizedBox.shrink(),
            ),
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildLoginForm(BuildContext context, {required bool isLoading}) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LogoAvatar(),
          Text(
            'YECONTINUITY',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'user@email.com'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }

              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email';
              }

              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Password'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }

              return null;
            },
          ),
          const SizedBox(
            height: 32,
          ),
          SubmitButton(
            text: 'Entrar',
            isLoading: isLoading,
            onLoginPressed: _onLoginPressed,
          ),
          SizedBox(height: 16),
          SubmitButton(
            text: 'Registar',
            isLoading: isLoading,
            onLoginPressed: _onLoginPressed,
          ),
        ],
      ),
    );
  }

  void _onLoginPressed() {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    print('$email :: $password');

    ref.read(authProvider.notifier).login(email, password);
  }
}

class SubmitButton extends StatelessWidget {
  const new({
    super.key,
    required this.text,
    required this.isLoading,
    required this.onLoginPressed,
  });

  final String text;
  final bool isLoading;
  final void Function() onLoginPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onLoginPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
