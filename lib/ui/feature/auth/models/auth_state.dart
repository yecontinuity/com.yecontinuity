import 'package:yecontinuity/ui/feature/auth/models/aut_response.dart';

sealed class AuthState {
  const new();
}

class AuthStateInitial extends AuthState {
  const new();
}

class AuthStateLoading extends AuthState {
  const new();
}

class AuthStateAuthenticated extends AuthState {
  final AutResponse user;
  const new(this.user);
}

class AuthStateError extends AuthState {
  final String message;

  const new({required this.message});
}
