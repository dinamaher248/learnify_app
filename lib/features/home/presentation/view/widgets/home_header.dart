import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:learnify_app/core/utils/assets.dart';
import 'package:learnify_app/features/home/presentation/view/widgets/search_bar_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/routing/app_router.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../profile_student/presentation/view_models/profile_student_cubit.dart';
import '../../../../profile_student/presentation/view_models/profile_student_state.dart';


class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        String name = "Loading...";
        String? image;

        if (state is ProfileSuccess) {
          name = state.profile.fullName;
          image = state.profile.profileImageUrl;
        }

        return Container(
          width: double.infinity,
          height: 30.h,
          color: const Color(0xff5047E4),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Row(
                children: [
                  const SizedBox(width: 16),

                  Container(
                    width: 11.w,
                    height: 6.h,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: image != null
                          ? Image.network(image, fit: BoxFit.cover)
                          : Image.asset(AppAssets.profile, fit: BoxFit.cover),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome 👋",
                        style: AppStyles.style16Medium.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        name,
                        style: AppStyles.style20SemiBold.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  IconButton(
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      context.push(AppRouter.notificationPath);
                    },
                  ),
                ],
              ),

               SearchBarWidget(),
            ],
          ),
        );
      },
    );
  }
}