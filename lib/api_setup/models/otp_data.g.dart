// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OtpDataImpl _$$OtpDataImplFromJson(Map<String, dynamic> json) =>
    _$OtpDataImpl(
      number: json['number'] as String,
      role: json['role'] as String,
      updatedAt: json['updated_at'] as String,
      createdAt: json['created_at'] as String,
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$$OtpDataImplToJson(_$OtpDataImpl instance) =>
    <String, dynamic>{
      'number': instance.number,
      'role': instance.role,
      'updated_at': instance.updatedAt,
      'created_at': instance.createdAt,
      'id': instance.id,
    };
