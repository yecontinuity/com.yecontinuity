// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aut_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AutResponse _$AutResponseFromJson(Map<String, dynamic> json) => _AutResponse(
  firstName: json['firstName'] as String,
  id: json['id'] as String,
  lastName: json['lastName'] as String,
  fullName: json['fullName'] as String,
  userName: json['userName'] as String,
  email: json['email'] as String,
  image: json['image'] as String,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String?,
  token: json['token'] as String,
  refreshToken: json['refreshToken'] as String,
  accessTokenExpiry: json['accessTokenExpiry'] as String,
  refreshTokenExpiry: json['refreshTokenExpiry'] as String,
);

Map<String, dynamic> _$AutResponseToJson(_AutResponse instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'id': instance.id,
      'lastName': instance.lastName,
      'fullName': instance.fullName,
      'userName': instance.userName,
      'email': instance.email,
      'image': instance.image,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'accessTokenExpiry': instance.accessTokenExpiry,
      'refreshTokenExpiry': instance.refreshTokenExpiry,
    };
