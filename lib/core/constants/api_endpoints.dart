class ApiEndpoints {
  String get baseUrl => 'https://www.server.thereflectivespiritapp.com/api/v1';

  /// Auth
  String get registerUser => '/users';
  String get loginUser => '/auth/login';
  String get verifyOtp => '/otp/verify-otp';
}
