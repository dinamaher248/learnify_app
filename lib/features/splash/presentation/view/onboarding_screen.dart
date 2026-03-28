import 'package:flutter/material.dart';
import 'package:learnify_app/features/auth/presentation/view/login.dart';

import '../../../../core/utils/assets.dart';
import '../../../../core/utils/color.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String subtitle;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  // البيانات الخاصة بالشاشات الترحيبية الثلاث
  final List<OnboardingModel> _onboardingData = [
    OnboardingModel(
      image: AppAssets.onboardingImage,
      title: "Everything In One Place.",
      subtitle:
          "Manage Your University Life Clearly And Confidently All Your Essential Information, Organized And Easy To Access.",
    ),
    OnboardingModel(
      image: AppAssets.onboardingImage2,
      title: "Stay Informed. Stay In Control.",
      subtitle:
          "Track Schedules, Grades, And Important Updates In Real Time Without Confusion Or Scattered Systems.",
    ),
    OnboardingModel(
      image: AppAssets.onboardingImage3,
      title: "Step Into A Smarter University Experience",
      subtitle:
          "Stay Organized, Track Your Progress, And Access Everything You Need To Succeed — Simply And Seamlessly.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          // 1. الخلفية الأساسية (للحفاظ على شكل الحاوية البيضاء أثناء السحب)
          Column(
            children: [
              Expanded(
                flex: 55,
                child: Container(color: AppColors.primaryColor),
              ),
              Expanded(
                flex: 45,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // 2. المحتوى القابل للسحب (الصور والنصوص)
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  // قسم الصورة العلوية
                  Expanded(
                    flex: 55,
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Center(
                          child: Image.asset(
                            _onboardingData[index].image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // قسم النص السفلي
                  Expanded(
                    flex: 45,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top:
                            60.0, // مساحة علوية لتجنب تداخل النصوص مع النقاط (Dots)
                        left: 24.0,
                        right: 24.0,
                      ),
                      child: Column(
                        children: [
                          Text(
                            _onboardingData[index].title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _onboardingData[index].subtitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // 3. العناصر الثابتة (النقاط Indicator والزر الدائري)
          Column(
            children: [
              Expanded(flex: 55, child: const SizedBox()),
              Expanded(
                flex: 45,
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // مؤشر الصفحات (Dots)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _onboardingData.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 8,
                            width: _currentIndex == index ? 32 : 12,
                            decoration: BoxDecoration(
                              color: _currentIndex == index
                                  ? AppColors.primaryColor
                                  : AppColors.secondaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),

                      // زر الانتقال (Next Button)
                      GestureDetector(
                        onTap: () {
                          if (_currentIndex == _onboardingData.length - 1) {
                            // الانتقال لشاشة تسجيل الدخول واستبدال الشاشة الحالية
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: Container(
                          width: 75,
                          height: 75,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                            boxShadow: [
                              // الظل الداكن أسفل الزر لمحاكاة التصميم
                              BoxShadow(
                                color: Color(0xFF1E1A5A),
                                offset: Offset(2, 4),
                                blurRadius: 0,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
