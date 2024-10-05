// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OtpData _$OtpDataFromJson(Map<String, dynamic> json) {
  return _OtpData.fromJson(json);
}

/// @nodoc
mixin _$OtpData {
  String get number => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;

  /// Serializes this OtpData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OtpData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OtpDataCopyWith<OtpData> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpDataCopyWith<$Res> {
  factory $OtpDataCopyWith(OtpData value, $Res Function(OtpData) then) =
      _$OtpDataCopyWithImpl<$Res, OtpData>;
  @useResult
  $Res call(
      {String number,
      String role,
      @JsonKey(name: 'updated_at') String updatedAt,
      @JsonKey(name: 'created_at') String createdAt,
      int id});
}

/// @nodoc
class _$OtpDataCopyWithImpl<$Res, $Val extends OtpData>
    implements $OtpDataCopyWith<$Res> {
  _$OtpDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtpData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
    Object? role = null,
    Object? updatedAt = null,
    Object? createdAt = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OtpDataImplCopyWith<$Res> implements $OtpDataCopyWith<$Res> {
  factory _$$OtpDataImplCopyWith(
          _$OtpDataImpl value, $Res Function(_$OtpDataImpl) then) =
      __$$OtpDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String number,
      String role,
      @JsonKey(name: 'updated_at') String updatedAt,
      @JsonKey(name: 'created_at') String createdAt,
      int id});
}

/// @nodoc
class __$$OtpDataImplCopyWithImpl<$Res>
    extends _$OtpDataCopyWithImpl<$Res, _$OtpDataImpl>
    implements _$$OtpDataImplCopyWith<$Res> {
  __$$OtpDataImplCopyWithImpl(
      _$OtpDataImpl _value, $Res Function(_$OtpDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of OtpData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
    Object? role = null,
    Object? updatedAt = null,
    Object? createdAt = null,
    Object? id = null,
  }) {
    return _then(_$OtpDataImpl(
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OtpDataImpl implements _OtpData {
  const _$OtpDataImpl(
      {required this.number,
      required this.role,
      @JsonKey(name: 'updated_at') required this.updatedAt,
      @JsonKey(name: 'created_at') required this.createdAt,
      required this.id});

  factory _$OtpDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtpDataImplFromJson(json);

  @override
  final String number;
  @override
  final String role;
  @override
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  final int id;

  @override
  String toString() {
    return 'OtpData(number: $number, role: $role, updatedAt: $updatedAt, createdAt: $createdAt, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpDataImpl &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, number, role, updatedAt, createdAt, id);

  /// Create a copy of OtpData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpDataImplCopyWith<_$OtpDataImpl> get copyWith =>
      __$$OtpDataImplCopyWithImpl<_$OtpDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OtpDataImplToJson(
      this,
    );
  }
}

abstract class _OtpData implements OtpData {
  const factory _OtpData(
      {required final String number,
      required final String role,
      @JsonKey(name: 'updated_at') required final String updatedAt,
      @JsonKey(name: 'created_at') required final String createdAt,
      required final int id}) = _$OtpDataImpl;

  factory _OtpData.fromJson(Map<String, dynamic> json) = _$OtpDataImpl.fromJson;

  @override
  String get number;
  @override
  String get role;
  @override
  @JsonKey(name: 'updated_at')
  String get updatedAt;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  int get id;

  /// Create a copy of OtpData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpDataImplCopyWith<_$OtpDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
