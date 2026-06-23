import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learnify_app/core/routing/app_router.dart';

import '../../../../core/utils/custom_widgets/app_bar_widget.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/floating_action_button.dart';

class ParentScaffold extends StatefulWidget {
  final Widget child;

  const ParentScaffold({super.key, required this.child});

  @override
  State<ParentScaffold> createState() => _ParentScaffoldState();
}

class _ParentScaffoldState extends State<ParentScaffold> {
  int getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith(AppRouter.homePath)) return 0;
    if (location.startsWith(AppRouter.parentGradesPath)) return 1;
    if (location.startsWith(AppRouter.parentAttendancePath)) return 2;
    if (location.startsWith(AppRouter.courseDetailsPath)) return 3;
    if (location.startsWith(AppRouter.profilePath)) return 4;

    return 0;
  }

  void onTap(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRouter.homePath);
        break;
      case 1:
        context.go(AppRouter.parentGradesPath);
        break;
      case 2:
        context.go(AppRouter.parentAttendancePath);
        break;
      case 3:
        context.go(AppRouter.courseDetailsPath);
        break;
      case 4:
        context.go(AppRouter.profilePath);
        break;
    }
  }

  String getCurrentLocation(BuildContext context) {
    return GoRouterState.of(context).uri.toString();
  }

  // bool _isChatScreen(String location) {
  //   return location.startsWith(AppRouter.chatPath);
  // }

  PreferredSizeWidget? _buildAppBar(String location) {
    // if (_isChatScreen(location)) return null;

    if (location.startsWith(AppRouter.parentChildrenPath)) {
      return AppBarWidget(title: "My Child");
    } else if (location.startsWith(AppRouter.parentGradesPath)) {
      return AppBarWidget(title: "Grades");
    } else if (location.startsWith(AppRouter.parentAttendancePath)) {
      return AppBarWidget(title: "Attendance");
    } else if (location.startsWith(AppRouter.courseDetailsPath)) {
      return AppBarWidget(title: "Courses");
    } else if (location.startsWith(AppRouter.profilePath)) {
      return AppBarWidget(title: "Profile");
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = getCurrentIndex(context);
    final location = getCurrentLocation(context);
    // final isChat = _isChatScreen(location);
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: _buildAppBar(location),
      body: widget.child,
      floatingActionButton: CustomFAB(
        currentIndex: currentIndex,
        onTap: (index) => onTap(index, context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) => onTap(index, context),
      ),
    );
  }
}
