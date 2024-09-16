// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'updated_user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdatedUserProfileImpl _$$UpdatedUserProfileImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdatedUserProfileImpl(
      userId: (json['userId'] as num).toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      photo: const FileJsonConverter().fromJson(json['photo'] as String?),
      bloodGroup: json['bloodGroup'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      weight: json['weight'] as String?,
      heightFt: json['heightFt'] as String?,
      heightIn: json['heightIn'] as String?,
      gender: json['gender'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$$UpdatedUserProfileImplToJson(
        _$UpdatedUserProfileImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'photo': const FileJsonConverter().toJson(instance.photo),
      'bloodGroup': instance.bloodGroup,
      'dateOfBirth': instance.dateOfBirth,
      'weight': instance.weight,
      'heightFt': instance.heightFt,
      'heightIn': instance.heightIn,
      'gender': instance.gender,
      'address': instance.address,
    };
