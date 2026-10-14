import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yecontinuity/core/constants.dart';
import 'package:yecontinuity/core/dio_client.dart';
import 'package:yecontinuity/ui/feature/auth/models/aut_response.dart';
import 'package:yecontinuity/ui/feature/auth/models/auth_state.dart';

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    // _restoreSession();
    return const AuthStateInitial();
  }

  // Future<void> _restoreSession() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final savedToken = prefs.getString(AppConstants.tokenKey);

  //   if (savedToken == null) return;

  //   try {
  //     final dio = ref.read(dioProvider);
  //     final response = await dio.get(
  //       AppConstants.productsRoute,
  //       options: Options(headers: {'Authorization': 'Bearer $savedToken'}),
  //     );

  //     final user = User.fromJson(response.data['user'] as Map<String, dynamic>);
  //     state = AuthStateAuthenticated(user);
  //   } catch (_) {}
  // }

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
      final message =
          (e.response?.data['message'] as Map<String, dynamic>?)?['message'] ??
          _httpsErrorMessage(e.response?.statusCode);

      state = AuthStateError(message: 'message');
    } catch (err) {
      print(err);
    }
  }

  Future<void> logout() async {
    await _clearSession();

    // invalidate providers
    // ref.invalidate();

    state = const AuthStateInitial();
  }

  Future<void> _saveSession(AutResponse user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.tokenKey, user.token);
    await prefs.setString(AppConstants.userIdKey, user.id);
    await prefs.setString('user_data', jsonEncode(user.toJson()));
  }

  Future<void> _clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.tokenKey);
    await prefs.remove(AppConstants.userIdKey);
    await prefs.remove('user_data');
  }

  String _httpsErrorMessage(int? code) => switch (code) {
    400 => 'Bad request. Please check your input.',
    401 => 'Unauthorized. Please check your credentials.',
    4003 => 'Forbidden. you dont have access.',
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
