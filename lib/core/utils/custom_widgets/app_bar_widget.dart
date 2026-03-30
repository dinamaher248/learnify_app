
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routing/app_router.dart';
import '../app_styles.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget { // 1. أضف implements هنا
  const AppBarWidget({super.key,required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppStyles.style24SemiBold.copyWith(color: const Color(0xFF24234D)),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF24234D)),
        onPressed: () => context.go(AppRouter.homePath),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); 
}