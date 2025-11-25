import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sparktech_agency_task/core/constants/api_endpoints.dart';

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
        return response.data;
      } else {
        throw Exception(response.data['message'] ?? 'Something went wrong.');
      }
    } catch (e) {
      if (e is DioException) {
        debugPrint("Registration Dio Error: ${e.response?.data}");
        throw Exception(e.response?.data['message'] ?? 'Server error occurred.');
      }
      debugPrint("Registration Error: $e");
      throw Exception('Failed to register user.');
    }
  }
}
