import 'package:flutter/material.dart';
import 'package:learnify_app/core/utils/assets.dart';
import 'package:learnify_app/core/utils/custom_widgets/app_bar_widget.dart';

import 'widgets/about_sec.dart';
import 'widgets/profile_info_tile.dart';
import 'widgets/social_media_bar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBarWidget(title: 'Profile'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/images/doctors.png'),
            ),
            const SizedBox(height: 30),
            const ProfileInfoTile(label: "Name", value: "Ehab gamil"),
            const ProfileInfoTile(
              label: "Courses",
              value: "information system",
            ),
            const ProfileInfoTile(label: "Phone", value: "01277545001"),
            const SizedBox(height: 10),
            const AboutSection(
              description:
                  "Dr. Ehab gamil is a faculty member in the Computer Science Department with over 10 years of academic and research experience. He specializes in Software Engineering and Data Systems, and is committed to delivering practical, student-centered learning experiences.",
            ),
            const SocialMediaBar(),
          ],
        ),
      ),
    );
  }
}
