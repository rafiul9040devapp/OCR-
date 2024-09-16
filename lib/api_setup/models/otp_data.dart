import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_data.freezed.dart';
part 'otp_data.g.dart';

@freezed
class OtpData with _$OtpData {
  const factory OtpData({
    required String number,
    required String role,
    @JsonKey(name: 'updated_at') required String updatedAt,
    @JsonKey(name: 'created_at') required String createdAt,
    required int id,
  }) = _OtpData;

  // Method to generate the factory for JSON serialization
  factory OtpData.fromJson(Map<String, dynamic> json) => _$OtpDataFromJson(json);
}
