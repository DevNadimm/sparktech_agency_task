import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sparktech_agency_task/core/constants/api_endpoints.dart';
import 'package:sparktech_agency_task/core/services/app_preferences.dart';

class LoginRepository {
  static Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    final Dio dio = Dio();
    final ApiEndpoints api = ApiEndpoints();

    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    );

    try {
      final data = {
        "email": email,
        "password": password,
      };

      final response = await dio.post(
        api.loginUser,
        data: data,
      );

      debugPrint("Login Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final accessToken = response.data?['data']?['accessToken'] ?? '';
        final refreshToken = response.data?['data']?['refreshToken'] ?? '';

        await AppPreferences.setAccessToken(accessToken);
        await AppPreferences.setRefreshToken(refreshToken);

        return response.data;
      } else {
        throw Exception(response.data?['message'] ?? 'Login failed. Please try again.');
      }
    } catch (e) {
      if (e is DioException) {
        debugPrint("Login Dio Error: ${e.response?.data}");
        throw Exception(e.response?.data?['message'] ?? 'Server error. Please try again later.');
      }
      debugPrint("Login Error: $e");
      throw Exception('Failed to login. Please try again.');
    }
  }
}
