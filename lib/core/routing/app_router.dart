import 'package:go_router/go_router.dart';
import 'package:learnify_app/features/auth/presentation/view/main_login.dart';
import 'package:learnify_app/features/courses/presentation/view/course_view.dart';
import 'package:learnify_app/features/home/presentation/view/home_view.dart';
import 'package:learnify_app/features/lectures/presentation/view/lecture_view.dart';
import 'package:learnify_app/features/notifications/presentation/view/widgets/notification_view.dart';
import 'package:learnify_app/features/splash/presentation/view/splash_screen.dart';

import '../../features/auth/presentation/view/forget_password.dart';
import '../../features/auth/presentation/view/login.dart';
import '../../features/home/presentation/view/main_scaffold.dart';
import '../../features/lectures/presentation/view/lecture_details_view.dart';

class AppRouter {
  static String splashPath = '/';
  static String homePath = '/home';
  static String notificationPath = '/notification';
  static String loginPath = '/login';
  static String forgotPasswordPath = '/forgot-password';
  static String courseDetailsPath = '/course-details';
  static String lecturePath = '/lecture';
  static String lectureDetailsPath = '/lecture-details';
  static final GoRouter router = GoRouter(
    initialLocation: loginPath,
    routes: [
      GoRoute(
        path: splashPath,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: notificationPath,
        builder: (context, state) => NotificationView(),
      ),
      GoRoute(path: loginPath, builder: (context, state) => MainLogin()),
      GoRoute(
        path: forgotPasswordPath,
        builder: (context, state) => ForgotPasswordScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return MainScaffold(child: child);
        },
        routes: [
          GoRoute(path: homePath, builder: (context, state) => HomeView()),
          GoRoute(
            path: courseDetailsPath,
            builder: (context, state) => CourseView(),
          ),
          GoRoute(
            path: lecturePath,
            builder: (context, state) => LectureView(),
          ),
          GoRoute(
            path: lectureDetailsPath,
            builder: (context, state) => LectureDetailsView(),
          ),
        ],
      ),
    ],
  );
  
}
