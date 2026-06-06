class Endpoints {
  static String baseAuthUrl =
      "https://auth.learnefy.tech"; //"http://44.200.213.126:5000";
  static String loginUrl = "/api/v1/auth/login";
  static String activateUrl = "/api/v1/auth/activate";
  static String refreshTokenUrl = "/api/v1/auth/refresh";
  static String resetPasswordUrl = "/api/v1/auth/reset-password";
  static String forgotPasswordUrl = "/api/v1/auth/forgot-password";
  static String resendOtpUrl = "/api/v1/auth/resend-otp";
  static String verifyOtpUrl = "/api/v1/auth/verify-otp";
  static String logoutUrl = "/api/v1/auth/logout";
  static String baseAcadimicUrl = "https://academic.learnefy.tech";
  static String baseMessageUrl = "https://message.learnefy.tech";
  static String baseAttendanceUrl = "https://attendance.learnefy.tech";
  static String attendanceCoursesUrl = "/api/v1/attendance/courses";
  static String attendanceCourseLectures(String courseId) =>
      "/api/v1/attendance/courses/$courseId/lectures";
  static String scheduleUrl = "/api/v1/academic/schedule";
  static String midtermScheduleUrl = "/api/v1/academic/schedule/midterm";
  static String courseUrl = "/api/v1/academic/courses";
}

class ApiKey {
  static String message = "message";
}
