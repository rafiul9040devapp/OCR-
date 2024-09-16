import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart'; // For JSON serialization

@freezed
class User with _$User {
  const factory User({
    required int id,
    String? name,
    String? email,
    required String number,
    @JsonKey(name: 'register_at') String? registerAt,
    String? photo,
    required String role,
    @JsonKey(name: 'email_verified_at') String? emailVerifiedAt,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _User;

  // Factory for JSON deserialization
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
