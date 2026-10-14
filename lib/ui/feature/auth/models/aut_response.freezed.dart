// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'aut_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AutResponse implements DiagnosticableTreeMixin {

 String get firstName; String get id; String get lastName; String get fullName; String get userName; String get email; String get image; String get createdAt; String? get updatedAt; String get token; String get refreshToken; String get accessTokenExpiry; String get refreshTokenExpiry;
/// Create a copy of AutResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AutResponseCopyWith<AutResponse> get copyWith => _$AutResponseCopyWithImpl<AutResponse>(this as AutResponse, _$identity);

  /// Serializes this AutResponse to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as AutResponse;
  properties
    ..add(DiagnosticsProperty('type', 'AutResponse'))
    ..add(DiagnosticsProperty('firstName', _this.firstName))..add(DiagnosticsProperty('id', _this.id))..add(DiagnosticsProperty('lastName', _this.lastName))..add(DiagnosticsProperty('fullName', _this.fullName))..add(DiagnosticsProperty('userName', _this.userName))..add(DiagnosticsProperty('email', _this.email))..add(DiagnosticsProperty('image', _this.image))..add(DiagnosticsProperty('createdAt', _this.createdAt))..add(DiagnosticsProperty('updatedAt', _this.updatedAt))..add(DiagnosticsProperty('token', _this.token))..add(DiagnosticsProperty('refreshToken', _this.refreshToken))..add(DiagnosticsProperty('accessTokenExpiry', _this.accessTokenExpiry))..add(DiagnosticsProperty('refreshTokenExpiry', _this.refreshTokenExpiry));
}

@override
bool operator ==(Object other) {
  final _this = this as AutResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AutResponse&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName)&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.lastName, _this.lastName) || other.lastName == _this.lastName)&&(identical(other.fullName, _this.fullName) || other.fullName == _this.fullName)&&(identical(other.userName, _this.userName) || other.userName == _this.userName)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.image, _this.image) || other.image == _this.image)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.token, _this.token) || other.token == _this.token)&&(identical(other.refreshToken, _this.refreshToken) || other.refreshToken == _this.refreshToken)&&(identical(other.accessTokenExpiry, _this.accessTokenExpiry) || other.accessTokenExpiry == _this.accessTokenExpiry)&&(identical(other.refreshTokenExpiry, _this.refreshTokenExpiry) || other.refreshTokenExpiry == _this.refreshTokenExpiry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AutResponse;
  return Object.hash(runtimeType,_this.firstName,_this.id,_this.lastName,_this.fullName,_this.userName,_this.email,_this.image,_this.createdAt,_this.updatedAt,_this.token,_this.refreshToken,_this.accessTokenExpiry,_this.refreshTokenExpiry);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as AutResponse;
  return 'AutResponse(firstName: ${_this.firstName}, id: ${_this.id}, lastName: ${_this.lastName}, fullName: ${_this.fullName}, userName: ${_this.userName}, email: ${_this.email}, image: ${_this.image}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, token: ${_this.token}, refreshToken: ${_this.refreshToken}, accessTokenExpiry: ${_this.accessTokenExpiry}, refreshTokenExpiry: ${_this.refreshTokenExpiry})';
}


}

/// @nodoc
abstract mixin class $AutResponseCopyWith<$Res>  {
  factory $AutResponseCopyWith(AutResponse value, $Res Function(AutResponse) _then) = _$AutResponseCopyWithImpl;
@useResult
$Res call({
 String firstName, String id, String lastName, String fullName, String userName, String email, String image, String createdAt, String? updatedAt, String token, String refreshToken, String accessTokenExpiry, String refreshTokenExpiry
});




}
/// @nodoc
class _$AutResponseCopyWithImpl<$Res>
    implements $AutResponseCopyWith<$Res> {
  _$AutResponseCopyWithImpl(this._self, this._then);

  final AutResponse _self;
  final $Res Function(AutResponse) _then;

/// Create a copy of AutResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = null,Object? id = null,Object? lastName = null,Object? fullName = null,Object? userName = null,Object? email = null,Object? image = null,Object? createdAt = null,Object? updatedAt = freezed,Object? token = null,Object? refreshToken = null,Object? accessTokenExpiry = null,Object? refreshTokenExpiry = null,}) {
  return _then(AutResponse(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,accessTokenExpiry: null == accessTokenExpiry ? _self.accessTokenExpiry : accessTokenExpiry // ignore: cast_nullable_to_non_nullable
as String,refreshTokenExpiry: null == refreshTokenExpiry ? _self.refreshTokenExpiry : refreshTokenExpiry // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AutResponse].
extension AutResponsePatterns on AutResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AutResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AutResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AutResponse value)  $default,){
final _that = this;
switch (_that) {
case _AutResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AutResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AutResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String firstName,  String id,  String lastName,  String fullName,  String userName,  String email,  String image,  String createdAt,  String? updatedAt,  String token,  String refreshToken,  String accessTokenExpiry,  String refreshTokenExpiry)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AutResponse() when $default != null:
return $default(_that.firstName,_that.id,_that.lastName,_that.fullName,_that.userName,_that.email,_that.image,_that.createdAt,_that.updatedAt,_that.token,_that.refreshToken,_that.accessTokenExpiry,_that.refreshTokenExpiry);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String firstName,  String id,  String lastName,  String fullName,  String userName,  String email,  String image,  String createdAt,  String? updatedAt,  String token,  String refreshToken,  String accessTokenExpiry,  String refreshTokenExpiry)  $default,) {final _that = this;
switch (_that) {
case _AutResponse():
return $default(_that.firstName,_that.id,_that.lastName,_that.fullName,_that.userName,_that.email,_that.image,_that.createdAt,_that.updatedAt,_that.token,_that.refreshToken,_that.accessTokenExpiry,_that.refreshTokenExpiry);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String firstName,  String id,  String lastName,  String fullName,  String userName,  String email,  String image,  String createdAt,  String? updatedAt,  String token,  String refreshToken,  String accessTokenExpiry,  String refreshTokenExpiry)?  $default,) {final _that = this;
switch (_that) {
case _AutResponse() when $default != null:
return $default(_that.firstName,_that.id,_that.lastName,_that.fullName,_that.userName,_that.email,_that.image,_that.createdAt,_that.updatedAt,_that.token,_that.refreshToken,_that.accessTokenExpiry,_that.refreshTokenExpiry);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AutResponse with DiagnosticableTreeMixin implements AutResponse {
  const _AutResponse({required this.firstName, required this.id, required this.lastName, required this.fullName, required this.userName, required this.email, required this.image, required this.createdAt, required this.updatedAt, required this.token, required this.refreshToken, required this.accessTokenExpiry, required this.refreshTokenExpiry});
  factory _AutResponse.fromJson(Map<String, dynamic> json) => _$AutResponseFromJson(json);

@override final  String firstName;
@override final  String id;
@override final  String lastName;
@override final  String fullName;
@override final  String userName;
@override final  String email;
@override final  String image;
@override final  String createdAt;
@override final  String? updatedAt;
@override final  String token;
@override final  String refreshToken;
@override final  String accessTokenExpiry;
@override final  String refreshTokenExpiry;

/// Create a copy of AutResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AutResponseCopyWith<_AutResponse> get copyWith => __$AutResponseCopyWithImpl<_AutResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AutResponseToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'AutResponse'))
    ..add(DiagnosticsProperty('firstName', firstName))..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('lastName', lastName))..add(DiagnosticsProperty('fullName', fullName))..add(DiagnosticsProperty('userName', userName))..add(DiagnosticsProperty('email', email))..add(DiagnosticsProperty('image', image))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('token', token))..add(DiagnosticsProperty('refreshToken', refreshToken))..add(DiagnosticsProperty('accessTokenExpiry', accessTokenExpiry))..add(DiagnosticsProperty('refreshTokenExpiry', refreshTokenExpiry));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AutResponse&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.id, id) || other.id == id)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.email, email) || other.email == email)&&(identical(other.image, image) || other.image == image)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.token, token) || other.token == token)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.accessTokenExpiry, accessTokenExpiry) || other.accessTokenExpiry == accessTokenExpiry)&&(identical(other.refreshTokenExpiry, refreshTokenExpiry) || other.refreshTokenExpiry == refreshTokenExpiry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,firstName,id,lastName,fullName,userName,email,image,createdAt,updatedAt,token,refreshToken,accessTokenExpiry,refreshTokenExpiry);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'AutResponse(firstName: $firstName, id: $id, lastName: $lastName, fullName: $fullName, userName: $userName, email: $email, image: $image, createdAt: $createdAt, updatedAt: $updatedAt, token: $token, refreshToken: $refreshToken, accessTokenExpiry: $accessTokenExpiry, refreshTokenExpiry: $refreshTokenExpiry)';
}


}

/// @nodoc
abstract mixin class _$AutResponseCopyWith<$Res> implements $AutResponseCopyWith<$Res> {
  factory _$AutResponseCopyWith(_AutResponse value, $Res Function(_AutResponse) _then) = __$AutResponseCopyWithImpl;
@override @useResult
$Res call({
 String firstName, String id, String lastName, String fullName, String userName, String email, String image, String createdAt, String? updatedAt, String token, String refreshToken, String accessTokenExpiry, String refreshTokenExpiry
});




}
/// @nodoc
class __$AutResponseCopyWithImpl<$Res>
    implements _$AutResponseCopyWith<$Res> {
  __$AutResponseCopyWithImpl(this._self, this._then);

  final _AutResponse _self;
  final $Res Function(_AutResponse) _then;

/// Create a copy of AutResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? id = null,Object? lastName = null,Object? fullName = null,Object? userName = null,Object? email = null,Object? image = null,Object? createdAt = null,Object? updatedAt = freezed,Object? token = null,Object? refreshToken = null,Object? accessTokenExpiry = null,Object? refreshTokenExpiry = null,}) {
  return _then(_AutResponse(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,accessTokenExpiry: null == accessTokenExpiry ? _self.accessTokenExpiry : accessTokenExpiry // ignore: cast_nullable_to_non_nullable
as String,refreshTokenExpiry: null == refreshTokenExpiry ? _self.refreshTokenExpiry : refreshTokenExpiry // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
