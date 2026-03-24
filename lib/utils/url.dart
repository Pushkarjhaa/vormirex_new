class ApiUrls {
  static const String baseUrl = 'https://www.vormirex.com/api';

  // Auth
  static const String login = '$baseUrl/auth/login';
  static const String signup = '$baseUrl/auth/signup';
  static const String getProfile = '$baseUrl/auth/me';

  // User
  static const String changePassword = '$baseUrl/users/me/password';
  static const String updateProfile = '$baseUrl/users/me/profile';
  static const String updateProfilePhoto = '$baseUrl/users/me/profile-photo';

  // Courses
  static const String courses = '$baseUrl/courses';

  // Course Detail
  static String courseDetail(String courseId) => '$baseUrl/courses/$courseId';
}
