import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yecontinuity/config/providers/onboarding_provider.dart';
import 'package:yecontinuity/core/constants.dart';
import 'package:yecontinuity/core/dio_client.dart';
import 'package:yecontinuity/ui/feature/auth/models/aut_response.dart';
import 'package:yecontinuity/ui/feature/auth/models/auth_state.dart';

class AuthNotifier extends Notifier<AuthState> {
  static const _userDataKey = 'user_data';

  @override
  AuthState build() {
    final prefs = ref.read(sharedPreferencesProvider);

    final token = prefs.getString(AppConstants.tokenKey);
    final rawUser = prefs.getString(_userDataKey);
    if (token == null || rawUser == null) return const AuthStateInitial();

    try {
      final user = AutResponse.fromJson(
        jsonDecode(rawUser) as Map<String, dynamic>,
      );
      return AuthStateAuthenticated(user);
    } catch (_) {
      unawaited(_clearSession(prefs));
      return const AuthStateInitial();
    }
  }

  Future<void> login(String email, String password) async {
    state = const AuthStateLoading();

    try {
      final dio = ref.read(dioProvider);
      final response = await dio.post(
        ApiConstants.login,
        data: {'email': email, 'password': password},
      );

      final user = AutResponse.fromJson(response.data as Map<String, dynamic>);

      await _saveSession(user);
      state = AuthStateAuthenticated(user);
    } on DioException catch (e) {
      state = AuthStateError(message: _errorMessage(e));
    } catch (_) {
      state = AuthStateError(message: 'An unexpected error occured.');
    }
  }

  Future<void> logout() async {
    await _clearSession(ref.read(sharedPreferencesProvider));
    state = const AuthStateInitial();
  }

  Future<void> _saveSession(AutResponse user) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(AppConstants.tokenKey, user.token);
    await prefs.setString(AppConstants.userIdKey, user.id);
    await prefs.setString(_userDataKey, jsonEncode(user.toJson()));
  }

  Future<void> _clearSession(SharedPreferences prefs) async {
    await prefs.remove(AppConstants.tokenKey);
    await prefs.remove(AppConstants.userIdKey);
    await prefs.remove(_userDataKey);
  }

  String _errorMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      final message = data['message'];
      if (message is String) return message;
      if (message is Map<String, dynamic> && message['message'] is String) {
        return message['message'] as String;
      }
    }
    return _httpsErrorMessage(e.response?.statusCode);
  }

  String _httpsErrorMessage(int? code) => switch (code) {
    400 => 'Bad request. Please check your input.',
    401 => 'Unauthorized. Please check your credentials.',
    403 => 'Forbidden. You dont have access.',
    404 => 'Not found. The resource does not exist.',
    429 => 'Too many request. Please wait and try again.',
    500 => 'Server error. Please try again later.',
    null => 'Network error.',
    _ => 'An unexpected error occured. Please try again.',
  };
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
