import 'package:flutter/material.dart';
import 'package:learnify_app/core/utils/color.dart';

class AboutLearnifyView extends StatelessWidget {
  const AboutLearnifyView({super.key});

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
          'About Learnify',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 32),
            
            // App Logo/Icon
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.school,
                size: 80,
                color: AppColors.primaryColor,
              ),
            ),
            
            const SizedBox(height: 32),
            
            // About Content Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Learnify Is An Integrated University Platform Designed To Simplify The Academic Experience For Students, Parents, Faculty Members, And University Administration.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.8,
                      color: Colors.grey[800],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  Text(
                    'Our Goal Is To Bring Schedules, Grades, Communication, And Academic Updates Into One Clear And Trusted Place — Helping Students Stay Organized, Informed, And Confident Throughout Their University Journey.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.8,
                      color: Colors.grey[800],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  Text(
                    'Learnify Focuses On Clarity, Simplicity, And Secure Access To Academic Information.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.8,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Version Info
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 20,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Copyright
            Text(
              '© 2025 Learnify. All rights reserved.',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[500],
              ),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
