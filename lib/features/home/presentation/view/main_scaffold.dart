import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learnify_app/core/routing/app_router.dart';

import '../../../../core/utils/custom_widgets/app_bar_widget.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/floating_action_button.dart';

class MainScaffold extends StatefulWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith(AppRouter.homePath)) return 0;
    if (location.startsWith('/rashed')) return 1;
    if (location.startsWith(AppRouter.courseDetailsPath) ||
        location.startsWith(AppRouter.lecturePath) ||
        location.startsWith(AppRouter.lectureDetailsPath))
      return 2;
    if (location.startsWith(AppRouter.messageViewPath)) return 3;
    if (location.startsWith('/profile')) return 4;

    return 0;
  }

  void onTap(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRouter.homePath);
        break;
      case 1:
        context.go('/rashed');
        break;
      case 2:
        context.go(AppRouter.courseDetailsPath);
        break;
      case 3:
        context.go(AppRouter.messageViewPath);
        break;
      case 4:
        context.go('/profile');
        break;
    }
  }

  String getCurrentLocation(BuildContext context) {
    return GoRouterState.of(context).uri.toString();
  }

  PreferredSizeWidget? _buildAppBar(String location) {
    if (location.startsWith(AppRouter.lectureDetailsPath)) {
      return AppBarWidget(title: "Lecture Details");
    } else if (location.startsWith(AppRouter.lecturePath)) {
      return AppBarWidget(title: "Lecture");
    } else if (location.startsWith(AppRouter.courseDetailsPath)) {
      return AppBarWidget(title: "Courses");
    }else if (location.startsWith(AppRouter.messageViewPath)) {
      return AppBarWidget(title: "Message");
    } 

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = getCurrentIndex(context);
    final location = getCurrentLocation(context);

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
