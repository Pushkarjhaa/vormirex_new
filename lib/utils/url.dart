class ApiUrls {
  static const String baseUrl = 'https://www.vormirex.com/api';

  // Auth
  static const String login = '$baseUrl/auth/login';
  static const String signup = '$baseUrl/auth/signup';

  // User
  static const String changePassword = '$baseUrl/users/me/password';

  // Courses
  static const String courses = '$baseUrl/courses';

  // Course Detail
  static String courseDetail(String courseId) => '$baseUrl/courses/$courseId';
}
