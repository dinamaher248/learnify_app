import 'package:flutter/material.dart';
import 'package:learnify_app/core/utils/color.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

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
          'Privacy Policy',
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
            
            // Privacy Icon
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.privacy_tip,
                size: 80,
                color: AppColors.primaryColor,
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Privacy Policy Content Card
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
                    'Your Privacy Is Important To Us.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                      height: 1.8,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Text(
                    'Learnify Collects And Stores Only The Necessary Academic Information Required To Provide Educational Services. All Personal And Academic Data Is Securely Protected And Used Solely For University-Related Purposes.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.8,
                      color: Colors.grey[800],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  Text(
                    'We Do Not Share Your Information With Third Parties Without Authorization. All Data Is Handled In Accordance With University Policies And Security Standards.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.8,
                      color: Colors.grey[800],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  Text(
                    'For Any Privacy Concerns, Please Contact The University Administration.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.8,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Important Notice
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.orange[200]!,
                  width: 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange[700],
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'By using Learnify, you agree to our privacy policy and terms of service.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.orange[900],
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
