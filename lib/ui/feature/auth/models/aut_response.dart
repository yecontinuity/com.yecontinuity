import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'aut_response.freezed.dart';
part 'aut_response.g.dart';

@freezed
abstract class AutResponse with _$AutResponse {
  const factory AutResponse({
    required String firstName,
    required String id,
    required String lastName,
    required String fullName,
    required String userName,
    required String email,
    required String image,
    required String createdAt,
    required String? updatedAt,
    required String token,
    required String refreshToken,
    required String accessTokenExpiry,
    required String refreshTokenExpiry,
  }) = _AutResponse;

  factory AutResponse.fromJson(Map<String, dynamic> json) =>
      _$AutResponseFromJson(json);
}
