import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sparktech_agency_task/core/constants/api_endpoints.dart';
// import 'package:sparktech_agency_task/core/services/app_preferences.dart';

class OtpRepository {
  static Future<Map<String, dynamic>> verifyOtp({
    required String otp,
  }) async {
    final Dio dio = Dio();
    final ApiEndpoints api = ApiEndpoints();

    //final otpToken = await AppPreferences.getOtpToken();

    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        //"token": otpToken,
        "Content-Type": "application/json",
      },
    );

    try {
      final body = {
        "otp": otp,
      };

      final response = await dio.post(
        api.verifyOtp,
        data: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(response.data?["message"] ?? "OTP verification failed. Please try again.");
      }
    } catch (e) {
      if (e is DioException) {
        debugPrint("OTP Dio Error: ${e.response?.data}");
        throw Exception(e.response?.data?['message'] ?? "Server error. Please try again letter.");
      }
      debugPrint("OTP Error: $e");
      throw Exception("Failed to verify OTP.");
    }
  }
}
