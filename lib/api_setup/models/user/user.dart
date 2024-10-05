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
    required String? registerAt,
    required String? photo,
    required String role,
    required String? emailVerifiedAt,
    required String createdAt,
    required String updatedAt,
  }) = _User;

  // Factory for JSON deserialization
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
