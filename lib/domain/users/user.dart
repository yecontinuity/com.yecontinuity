import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String image;
  final String alternativeName;
  final String fullName;
  final String createdAt;
  final String updatedAt;
  Map<String, dynamic> toJson() => _$UserToJson(this);

  new({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.image,
    required this.alternativeName,
    required this.fullName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
