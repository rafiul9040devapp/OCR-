import 'dart:io';
import 'package:json_annotation/json_annotation.dart';


class FileJsonConverter implements JsonConverter<File?, String?> {
  const FileJsonConverter();

  @override
  File? fromJson(String? json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return File(json); // Convert JSON string to File
  }

  @override
  String? toJson(File? file) {
    if (file == null) {
      return null;
    }
    return file.path; // Convert File to its path
  }
}