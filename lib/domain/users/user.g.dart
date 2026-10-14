// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['id'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  userName: json['userName'] as String,
  email: json['email'] as String,
  image: json['image'] as String,
  alternativeName: json['alternativeName'] as String,
  fullName: json['fullName'] as String,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'userName': instance.userName,
  'email': instance.email,
  'image': instance.image,
  'alternativeName': instance.alternativeName,
  'fullName': instance.fullName,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
