import 'package:go_router/go_router.dart';
import 'package:learnify_app/features/auth/presentation/view/main_login.dart';
import 'package:learnify_app/features/courses/presentation/view/course_view.dart';
import 'package:learnify_app/features/home/presentation/view/home_view.dart';
import 'package:learnify_app/features/lectures/presentation/view/lecture_view.dart';
import 'package:learnify_app/features/messages/presentation/view/chat_view.dart';
import 'package:learnify_app/features/messages/presentation/view/message_view.dart';
import 'package:learnify_app/features/notifications/presentation/view/widgets/notification_view.dart';
import 'package:learnify_app/features/profile_student/presentation/view/profile_view.dart';
import 'package:learnify_app/features/quiz/presentation/view/quiz_view.dart';
import 'package:learnify_app/features/quiz/presentation/view/result.dart';
import 'package:learnify_app/features/splash/presentation/view/splash_screen.dart';

import '../../features/assignment/presentation/view/assignment_view.dart';
import '../../features/attendance/presentation/view/attendance_view.dart';
import '../../features/attendance/presentation/view/confirmation_view.dart';
import '../../features/auth/presentation/view/forget_password.dart';
import '../../features/home/presentation/view/main_scaffold.dart';
import '../../features/home/presentation/view/parent_scaffold.dart';
import '../../features/lectures/presentation/view/lecture_details_view.dart';
import '../../features/lectures/presentation/view/lecture_pdf_views.dart';
import '../../features/parent/attentance/presentation/view/attendance_view.dart';
import '../../features/parent/auth/presentation/view/active_parent_code_view.dart';
import '../../features/parent/courses/presentation/view/courses_view.dart';
import '../../features/parent/grades/presentation/view/grade_view.dart';
// Note: parent attendance view implemented under features/parent/attentance
import '../../features/parent/presentation/view/parent_child_detail_view.dart';
import '../../features/parent/presentation/view/parent_children_view.dart';
import '../../features/profile_student/presentation/view/grades_view.dart';
import '../../features/quiz/presentation/view/review_view.dart';
import '../../features/rashed_ai/presentation/view/rashed_ai_view.dart';
import '../../features/video/presentation/view/video_view.dart';
import '../cache/cache_helper.dart';

class AppRouter {
  static String splashPath = '/';
  static String homePath = '/home';
  static String notificationPath = '/notification';
  static String loginPath = '/login';
  static String activateParentAccountPath = '/activate-parent-account';
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
  static String chatPath = '/chatPath';
  static String messageViewPath = '/message_View';
  static String videoPath = '/video/:lectureId';
  static String reviewPath = '/review';
  static String profilePath = '/profile';
  static String rashedPath = '/rashed';
  static String parentGradesPath = '/parent-grades';
  static String parentAttendancePath = '/parent-attendance';
  static String parentChildrenPath = '/parent-children';

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
        path: activateParentAccountPath,
        builder: (context, state) =>
            ActivateParentAccountView(isParentApp: true),
      ),
      GoRoute(
        path: forgotPasswordPath,
        builder: (context, state) => ForgotPasswordScreen(),
      ),

      // GoRoute(
      //   path: AppRouter.chatPath,
      //   builder: (context, state) => ChatView(),
      // ),
      GoRoute(
        path: confirmationPath,
        builder: (context, state) => ConfirmationView(),
      ),
      GoRoute(
        path: lecturePdfPath,
        builder: (context, state) =>
            LecturePdfView(lectureId: state.extra as String),
      ),
      GoRoute(
        path: resultPath,
        builder: (context, state) => const ResultView(),
      ),
      GoRoute(
        path: assignmentPath,
        builder: (context, state) {
          final lectureId = state.extra as String? ?? '';
          return AssignmentView(lectureId: lectureId);
        },
      ),
      GoRoute(
        path: reviewPath,
        builder: (context, state) => const ReviewView(),
      ),
      GoRoute(path: quizPath, builder: (context, state) => const QuizView()),
      GoRoute(
        path: videoPath,
        builder: (context, state) {
          final lectureId = state.pathParameters['lectureId']!;
          String? lectureTitle;
          if (state.extra != null && state.extra is Map<String, dynamic>) {
            final map = state.extra as Map<String, dynamic>;
            lectureTitle = map['lectureTitle'] as String?;
          }
          return VideoView(lectureId: lectureId, lectureTitle: lectureTitle);
        },
      ),
      GoRoute(
        path: profilePath,
        builder: (context, state) => const ProfileView(),
      ),

      //parent routes
      GoRoute(
        path: parentGradesPath,
        builder: (context, state) => const GradesView(),
      ),
      GoRoute(
        path: parentAttendancePath,
        builder: (context, state) => const ParentAttendanceView(),
      ),
      GoRoute(
        path: parentChildrenPath,
        builder: (context, state) => const ParentChildrenView(),
      ),

      //! #################################
      ShellRoute(
        builder: (context, state, child) {
          final role = CacheHelper.getDataString(key: 'role');
          if (role != null && role.trim().toLowerCase() == 'parent') {
            return ParentScaffold(child: child);
          }
          return MainScaffold(child: child);
        },
        routes: [
          GoRoute(path: homePath, builder: (context, state) => HomeView()),
          GoRoute(
            path: courseDetailsPath,
            builder: (context, state) => CourseView(),
          ),
          GoRoute(
            path: AppRouter.lecturePath,
            builder: (context, state) {
              final courseId = state.extra as String;
              return LectureView(courseId: courseId);
            },
          ),
          GoRoute(
            path: AppRouter.rashedPath,
            builder: (context, state) {
              return RashedAiView();
            },
          ),
          GoRoute(
            path: lectureDetailsPath,
            builder: (context, state) {
              final data = state.extra as Map<String, dynamic>;
              return LectureDetailsView(
                courseId: data["courseId"],
                lectureId: data["lectureId"],
              );
            },
          ),
          GoRoute(
            path: messageViewPath,
            builder: (context, state) => MessageView(),
          ),
          GoRoute(
            path: '/parent-children',
            builder: (context, state) => const ParentChildrenView(),
          ),
          GoRoute(
            path: '/parent-child-detail',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>? ?? {};
              return ParentChildDetailView(childData: extra);
            },
          ),
          GoRoute(
            path: attendancePath,
            builder: (context, state) =>
                AttendanceView(lectureId: state.extra as String),
          ),
          GoRoute(
            path: '/parent-attendance',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>? ?? {};
              return ParentAttendanceView(
                studentId: extra['studentId']?.toString(),
                studentName: extra['studentName']?.toString(),
              );
            },
          ),
          GoRoute(
            path: '/parent-grades',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>? ?? {};
              return ParentGradesScreen(
                studentId: extra['studentId']?.toString(),
                studentName: extra['studentName']?.toString(),
              );
            },
          ),
          GoRoute(
            path: '/parent-courses',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>? ?? {};
              return ParentCoursesView(
                studentId: extra['studentId']?.toString(),
                studentName: extra['studentName']?.toString(),
              );
            },
          ),
          // في الـ router ✅
          GoRoute(
            path: AppRouter.chatPath,
            builder: (context, state) {
              final extra =
                  state.extra as Map<String, dynamic>?; // state مش context
              return ChatView(
                conversationId: extra?['conversationId'] ?? '',
                otherUserId: extra?['otherUserId'] ?? '',
              );
            },
          ),
        ],
      ),
    ],
  );
}
