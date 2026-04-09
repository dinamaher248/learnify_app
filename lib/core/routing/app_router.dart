import 'package:go_router/go_router.dart';
import 'package:learnify_app/features/auth/presentation/view/main_login.dart';
import 'package:learnify_app/features/courses/presentation/view/course_view.dart';
import 'package:learnify_app/features/home/presentation/view/home_view.dart';
import 'package:learnify_app/features/lectures/presentation/view/lecture_view.dart';
import 'package:learnify_app/features/notifications/presentation/view/widgets/notification_view.dart';
import 'package:learnify_app/features/splash/presentation/view/splash_screen.dart';

import '../../features/assignment/presentation/view/assignment_view.dart';
import '../../features/attendance/presentation/view/attendance_view.dart';
import '../../features/attendance/presentation/view/confirmation_view.dart';
import '../../features/auth/presentation/view/forget_password.dart';
import '../../features/home/presentation/view/main_scaffold.dart';
import '../../features/lectures/presentation/view/lecture_details_view.dart';
import '../../features/lectures/presentation/view/lecture_pdf_views.dart';
import '../../features/quiz/presentation/view/review_view.dart';
import '../../features/quiz/presentation/view/widgets/essay_quiz_view.dart';
import '../../features/quiz/presentation/view/quiz_view.dart';
import '../../features/quiz/presentation/view/result.dart';
import '../../features/video/presentation/view/video_view.dart';

class AppRouter {
  static String splashPath = '/';
  static String homePath = '/home';
  static String notificationPath = '/notification';
  static String loginPath = '/login';
  static String forgotPasswordPath = '/forgot-password';
  static String courseDetailsPath = '/course-details';
  static String lecturePath = '/lecture';
  static String lectureDetailsPath = '/lecture-details';
  static String attendancePath = '/attendance';
  static String confirmationPath = '/confirmation';
  static String lecturePdfPath = '/lecture-pdf';
  static String essayQuizPath = '/essay-quiz';
  static String resultPath = '/result';
  static String assignmentPath = '/assignment';
  static String quizPath = '/quiz';
  static String assignmentDetailsPath = '/assignment-details';
  static String quizDetailsPath = '/quiz-details';
  static String videoPath = '/video';
  static String reviewPath = '/review';

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
      GoRoute(
        path: attendancePath,
        builder: (context, state) => AttendanceDialog(),
      ),
      GoRoute(
        path: confirmationPath,
        builder: (context, state) => ConfirmationView(),
      ),
      GoRoute(
        path: lecturePdfPath,
        builder: (context, state) => LecturePdfView(),
      ),
      GoRoute(
        path: resultPath,
        builder: (context, state) => const ResultView(),
      ),
      GoRoute(
        path: assignmentPath,
        builder: (context, state) => const AssignmentView(),
      ),
      GoRoute(path: reviewPath, builder: (context, state) => const ReviewView()),
      GoRoute(path: quizPath, builder: (context, state) => const QuizView()),
      GoRoute(path: videoPath, builder: (context, state) => const VideoView()),
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
