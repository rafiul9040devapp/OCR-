import 'dart:io'; // For handling File type
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ocr_medical_department/api_setup/utils/file_json_converter.dart';

part 'updated_user_profile.freezed.dart';

part 'updated_user_profile.g.dart';

@freezed
class UpdatedUserProfile with _$UpdatedUserProfile {
  const factory UpdatedUserProfile({
    required int userId,
    required String? name,
    required String? email,
    required String? password,
    @FileJsonConverter() File? photo,
    required String? bloodGroup,
    required String? dateOfBirth,
    required String? weight,
    required String? heightFt,
    required String? heightIn,
    String? gender,
    String? address,
  }) = _UpdatedUserProfile;

  factory UpdatedUserProfile.fromJson(Map<String, dynamic> json) =>
      _$UpdatedUserProfileFromJson(json);
}
