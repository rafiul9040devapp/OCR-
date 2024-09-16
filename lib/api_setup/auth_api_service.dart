import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ocr_medical_department/api_setup/constants.dart';
import 'package:ocr_medical_department/api_setup/models/updated_user_profile/updated_user_profile.dart';
import 'package:ocr_medical_department/api_setup/models/user/user.dart';
import 'package:ocr_medical_department/api_setup/otp_response.dart';
import 'package:ocr_medical_department/api_setup/preferences/token_storage.dart';
import 'package:ocr_medical_department/api_setup/preferences/user_id_storage.dart';
import 'package:ocr_medical_department/api_setup/resource/api_exception.dart';

class AuthApiService {
  final Dio _dio;
  final TokenStorage _tokenStorage;
  final UserIdStorage _userIdStorage;

  AuthApiService(this._dio, this._tokenStorage, this._userIdStorage) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers['Accept'] = 'accept/json';
          if (options.extra['requiresAuth'] ?? true) {
            String? token = await _tokenStorage.getToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            } else {
              print(
                  'Warning: Trying to make an authenticated request without a token');
            }
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          if (e.response?.statusCode == 401) {
            print('Unauthorized: Token might be invalid or expired');
            _tokenStorage.clearToken();
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<Either<ApiException, OtpData>> registerUser(int phoneNumber) async {
    try {
      final response = await _dio.post(registerEndPoint,
          options: Options(
            extra: {'requiresAuth': false},
          ),
          data: {"number": phoneNumber});
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.data);
        if (responseData['status'] == 1) {
          OtpData data = OtpData.fromJson(responseData['data']);
          _userIdStorage.saveUserID(data.id);
          return Right(data);
        } else {
          return Left(ApiException('Something Went Wrong'));
        }
      } else {
        return Left(ApiException.fromStatusCode(response.statusCode ?? 0));
      }
    } on DioException catch (e) {
      return Left(ApiException.fromDioError(e));
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }

  Future<Either<ApiException, User>> verifyUserWithOtp(int otpNumber) async {
    try {
      final response = await _dio.post(registerOTPEndPoint,
          options: Options(
            extra: {'requiresAuth': false},
          ),
          data: {
            "user_id": _userIdStorage.getUserID(),
            "otp": otpNumber,
          });

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.data);
        if (responseData['status'] == 1) {
          _tokenStorage.saveToken(responseData['token']);
          User responseUser = User.fromJson(responseData['data']);
          return Right(responseUser);
        } else {
          return Left(ApiException(responseData['message']));
        }
      } else {
        return Left(ApiException.fromStatusCode(response.statusCode ?? 0));
      }
    } on DioException catch (e) {
      return Left(ApiException.fromDioError(e));
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }

  Future<Either<ApiException, String>> resendUserOtp() async {
    try {
      final response = await _dio.post(resendOTPEndPoint,
          options: Options(
            extra: {'requiresAuth': false},
          ),
          data: {
            "user_id": _userIdStorage.getUserID(),
          });

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.data);
        if (responseData['status'] == 1) {
          return Right(responseData['message']);
        } else {
          return Left(ApiException(responseData['message']));
        }
      } else {
        return Left(ApiException.fromStatusCode(response.statusCode ?? 0));
      }
    } on DioException catch (e) {
      return Left(ApiException.fromDioError(e));
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }

  Future<Either<ApiException, String>> updateUserProfile(
      UpdatedUserProfile userProfile) async {
    try {
      final response = await _dio.post(
        profileUpdateEndPoint,
        data: {
          'user_id': _userIdStorage.getUserID(),
          'name': userProfile.name,
          'email': userProfile.email,
          'password': userProfile.password,
          'photo': userProfile.photo,
          'blood_group': userProfile.bloodGroup,
          'date_of_birth': userProfile.dateOfBirth,
          'weight': userProfile.weight,
          'height_ft': userProfile.heightFt,
          'height_in': userProfile.heightIn,
          'gender': userProfile.gender,
          'address': userProfile.address,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.data);
        if (responseData['status'] == 1) {
          return Right(responseData['message']);
        } else {
          return Left(ApiException(responseData['message']));
        }
      } else {
        return Left(ApiException.fromStatusCode(response.statusCode ?? 0));
      }
    } on DioException catch (e) {
      return Left(ApiException.fromDioError(e));
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }

  Future<Either<ApiException, String>> logoutUser() async {
    try {
      final response = await _dio.post(logoutEndPoint);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.data);
        if (responseData['status'] == 1) {
          _tokenStorage.clearToken();
          _userIdStorage.clearUserID();
          return Right(responseData['message']);
        } else {
          return Left(ApiException(responseData['message']));
        }
      } else {
        return Left(ApiException.fromStatusCode(response.statusCode ?? 0));
      }
    } on DioException catch (e) {
      return Left(ApiException.fromDioError(e));
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }

  Future<Either<ApiException, String>> loginUser(
      int phoneNumber, String password) async {
    try {
      final response = await _dio.post(
        loginEndPoint,
        options: Options(
          extra: {'requiresAuth': false},
        ),
        data: {
          'number': phoneNumber,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.data);
        if (responseData['status'] == 1) {
          _tokenStorage.saveToken(responseData['token']);
          return Right(responseData['message']);
        } else {
          return Left(ApiException(responseData['message']));
        }
      } else {
        return Left(ApiException.fromStatusCode(response.statusCode ?? 0));
      }
    } on DioException catch (e) {
      return Left(ApiException.fromDioError(e));
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }
}
