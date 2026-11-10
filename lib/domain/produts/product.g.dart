// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: json['id'] as String,
  category: json['category'] as String,
  createdAt: json['createdAt'] as String,
  description: json['description'] as String,
  isAvailable: json['isAvailable'] as bool,
  location: Location.fromJson(json['location'] as Map<String, dynamic>),
  name: json['name'] as String,
  thumbnail: json['thumbnail'] as String,
  updatedAt: json['updatedAt'] as String,
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'id': instance.id,
  'category': instance.category,
  'createdAt': instance.createdAt,
  'description': instance.description,
  'isAvailable': instance.isAvailable,
  'location': instance.location,
  'name': instance.name,
  'thumbnail': instance.thumbnail,
  'updatedAt': instance.updatedAt,
};

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
  id: (json['id'] as num).toInt(),
  city: json['city'] as String,
  country: Country.fromJson(json['country'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
  'id': instance.id,
  'city': instance.city,
  'country': instance.country,
};

Country _$CountryFromJson(Map<String, dynamic> json) =>
    Country(id: (json['id'] as num).toInt(), name: json['name'] as String);

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};
