import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:yecontinuity/core/constants.dart';

import 'dart:io';

import 'package:yecontinuity/ui/feature/auth/providers/auth_provider.dart';
import 'package:yecontinuity/ui/feature/auth/models/auth_state.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: ApiConstants.headers,
    ),
  );

  // bypass development backend
  // if (kDebugMode) {
  //   (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
  //     final client = HttpClient();
  //     client.badCertificateCallback =
  //         (X509Certificate cert, String host, int port) {
  //           return host == 'localhost'; // restrict to your dev host only
  //         };
  //     return client;
  //   };
  // }

  dio.interceptors.add(
    LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ),
  );

  return dio;
});

final authenticatedDioProvider = Provider<Dio>((ref) {
  final authState = ref.watch(authProvider);
  final dio = ref.watch(dioProvider);
  const String authString = 'Authorization';

  final token = authState is AuthStateAuthenticated
      ? authState.user.token
      : null;

  if (token != null) {
    dio.options.headers[authString] = 'Bearer $token';
  } else {
    dio.options.headers.remove(authString);
  }

  return dio;
});
