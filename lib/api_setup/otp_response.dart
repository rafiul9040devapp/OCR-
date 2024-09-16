class OtpResponse {
  final int status;
  final String message;
  final OtpData? data;

  OtpResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? OtpData.fromJson(json['data']) : null,
    );
  }
}

class OtpData {
  final String number;
  final String role;
  final String updatedAt;
  final String createdAt;
  final int id;

  OtpData({
    required this.number,
    required this.role,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory OtpData.fromJson(Map<String, dynamic> json) {
    return OtpData(
      number: json['number'],
      role: json['role'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }
}
