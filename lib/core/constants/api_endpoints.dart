class ApiEndpoints {
  String get baseUrl => 'https://www.server.thereflectivespiritapp.com/api/v1';

  /// Auth
  String get registerUser => '$baseUrl/users';
  String get loginUser => '$baseUrl/auth/login';
  String get verifyOtp => '$baseUrl/otp/verify-otp';
}
