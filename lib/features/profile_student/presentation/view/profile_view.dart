import 'package:flutter/material.dart';
import 'package:learnify_app/core/utils/color.dart';
import 'package:learnify_app/features/profile_student/presentation/view/about_learnify_view.dart';
import 'package:learnify_app/features/profile_student/presentation/view/activate_parent_view.dart';
import 'package:learnify_app/features/profile_student/presentation/view/details_student_view.dart';
import 'package:learnify_app/features/profile_student/presentation/view/grades_view.dart';
import 'package:learnify_app/features/profile_student/presentation/view/support_view.dart';

import 'privacy_policy_view.dart';
import 'study_schedule_view.dart';
import 'widgets/logout_dialog.dart';
import 'widgets/profile_menu_item.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // القسم العلوي
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Details Student
                  ProfileMenuItem(
                    icon: Icons.person_outline,
                    title: 'Details Student',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DetailsStudentView(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  
                  // Study schedule
                  ProfileMenuItem(
                    icon: Icons.calendar_today_outlined,
                    title: 'Study schedule',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StudyScheduleView(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  
                  // Grades
                  ProfileMenuItem(
                    icon: Icons.assessment_outlined,
                    title: 'Grades',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GradesView(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // القسم الأوسط
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Activate code to parent
                  ProfileMenuItem(
                    icon: Icons.qr_code,
                    title: 'Activate code to parent',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ActivateParentView(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  
                  // About us
                  ProfileMenuItem(
                    icon: Icons.info_outline,
                    title: 'About us',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutLearnifyView(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  
                  // Privacy Policy
                  ProfileMenuItem(
                    icon: Icons.lock_outline,
                    title: 'Privacy Policy',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyView(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  
                  // Support
                  ProfileMenuItem(
                    icon: Icons.headset_mic_outlined,
                    title: 'Support',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SupportView(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  
                  // Logout
                  ProfileMenuItem(
                    icon: Icons.logout,
                    title: 'Logout',
                    titleColor: Colors.red,
                    iconColor: Colors.red,
                    onTap: () {
                      showLogoutDialog(context);
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Links Section
            const Text(
              'Links',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Social Media Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Instagram
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFF58529),
                        Color(0xFFDD2A7B),
                        Color(0xFF8134AF),
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                
                const SizedBox(width: 24),
                
                // Facebook
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF1877F2),
                  ),
                  child: const Center(
                    child: Text(
                      'f',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'serif',
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(width: 24),
                
                // Custom Icon (Star)
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor,
                  ),
                  child: const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
