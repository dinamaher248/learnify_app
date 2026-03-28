import 'package:go_router/go_router.dart';
import 'package:learnify_app/features/home/presentation/view/home_view.dart';
import 'package:learnify_app/features/notifications/presentation/view/widgets/notification_view.dart';
import 'package:learnify_app/features/splash/presentation/view/splash_screen.dart';

import '../../features/auth/presentation/view/forget_password.dart';
import '../../features/auth/presentation/view/login.dart';

class AppRouter {
  static String splashPath = '/';
  static String homePath = '/home';
  static String notificationPath = '/notification';
  static String loginPath = '/login';
  static String forgotPasswordPath = '/forgot-password';

  static final router = GoRouter(
    initialLocation: homePath,
    routes: [
      GoRoute(
        path: splashPath,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(path: homePath, builder: (context, state) => HomeView()),
      GoRoute(
        path: notificationPath,
        builder: (context, state) => NotificationView(),
      ),
      GoRoute(
        path: loginPath,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: forgotPasswordPath,
        builder: (context, state) => ForgotPasswordScreen(),
      ),
    ],
  );
}
