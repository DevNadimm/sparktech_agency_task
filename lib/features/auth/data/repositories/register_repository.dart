import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sparktech_agency_task/core/constants/api_endpoints.dart';
import 'package:sparktech_agency_task/core/services/app_preferences.dart';

class RegisterRepository {
  static Future<Map<String, dynamic>> registerUser({
    required String firstName,
    required String email,
    required String password,
    String? profileImagePath,
  }) async {
    final Dio dio = Dio();
    final ApiEndpoints api = ApiEndpoints();

    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      validateStatus: (status) => true,
    );

    try {
      final formData = FormData();

      formData.fields.addAll([
        MapEntry("firstName", firstName),
        MapEntry("email", email),
        MapEntry("password", password),
      ]);

      if (profileImagePath != null && profileImagePath.isNotEmpty) {
        formData.files.add(
          MapEntry(
            "profile",
            await MultipartFile.fromFile(
              profileImagePath,
              filename: profileImagePath.split('/').last,
            ),
          ),
        );
      }

      final response = await dio.post(
        api.registerUser,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final otpToken = response.data?['data']?['otpToken']?['token'] ?? '';
        debugPrint("OTP Token: $otpToken");

        AppPreferences.setOtpToken(otpToken);

        return response.data;
      } else {
        throw Exception(response.data?['message'] ?? 'Registration failed. Please try again.');
      }
    } catch (e) {
      if (e is DioException) {
        debugPrint("Registration Dio Error: ${e.response?.data}");
        throw Exception(e.response?.data?['message'] ?? 'Server error. Please try again letter.');
      }
      debugPrint("Registration Error: $e");
      throw Exception('Failed to register user.');
    }
  }
}
