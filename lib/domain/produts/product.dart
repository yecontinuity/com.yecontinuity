import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final String id;
  final String category;
  final String createdAt;
  final String description;
  final bool isAvailable;
  final Location location;
  final String name;
  final String thumbnail;
  final String updatedAt;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  new({
    required this.id,
    required this.category,
    required this.createdAt,
    required this.description,
    required this.isAvailable,
    required this.location,
    required this.name,
    required this.thumbnail,
    required this.updatedAt,
  });
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class Location {
  final int id;
  final String city;
  final Country country;

  new({required this.id, required this.city, required this.country});

  Map<String, dynamic> toJson() => _$LocationToJson(this);
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

@JsonSerializable()
class Country {
  final int id;
  final String name;

  new({required this.id, required this.name});
  Map<String, dynamic> toJson() => _$CountryToJson(this);
  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
}
