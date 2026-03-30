import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learnify_app/core/utils/assets.dart';
import 'package:learnify_app/features/home/presentation/view/widgets/search_bar_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/routing/app_router.dart';
import '../../../../../core/utils/app_styles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 30.h,
      color: Color(0xff5047E4),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Row(
            children: [
              SizedBox(width: 16),
              Container(
                width: 11.w,
                height: 6.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Image.asset(AppAssets.profile, fit: BoxFit.cover),
              ),

              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome 👋", style: AppStyles.style16Medium.copyWith(color: Colors.white)),
                  Text(
                    "Saeed Mohammed",
                    style: AppStyles.style20SemiBold.copyWith(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(width: 25.w),
              IconButton(
                icon: Icon(Icons.notifications_outlined, color: Colors.white),
                onPressed: () {
                  context.go(AppRouter.notificationPath);
                },
              ),
            ],
          ),
          SearchBarWidget(),
        ],
      ),
    );
  }
}
