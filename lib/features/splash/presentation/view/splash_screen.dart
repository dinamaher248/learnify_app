import 'package:flutter/material.dart';
import 'package:learnify_app/features/splash/presentation/view/onboarding_screen.dart';

import '../../../../core/utils/assets.dart';
import '../../../../core/utils/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // متغيرات للتحكم في حالة الأنيميشن
  bool _showIcon = false;
  bool _showText = false;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() async {
    // 1. الانتظار قليلاً (يظهر الظل الداكن أولاً) ثم إظهار الأيقونة
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() {
        _showIcon = true;
      });
    }

    // 2. الانتظار قبل تحريك الأيقونة لليسار وإظهار النصوص
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) {
      setState(() {
        _showText = true;
      });
    }

    // 3. الانتظار لعرض الشكل النهائي ثم الانتقال لشاشة Onboarding
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // الظل البيضاوي الموضح في الصورة الأولى (يختفي عندما يظهر اللوجو)
          AnimatedOpacity(
            opacity: _showIcon ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 400),
            child: Container(
              width: 250,
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xFF25234D).withOpacity(0.8),
                borderRadius: const BorderRadius.all(
                  Radius.elliptical(250, 70),
                ),
              ),
            ),
          ),

          // المحتوى الرئيسي (الشعار + النصوص)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // الأيقونة (الشعار)
                  AnimatedOpacity(
                    opacity: _showIcon ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 600),
                    child: const Image(
                      image: AssetImage(AppAssets.splashLogo),
                      height: 75,
                      width: 75,
                    ),
                  ),

                  // كلمة Learnify (تتمدد مما يدفع اللوجو لليسار تلقائياً)
                  AnimatedSize(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.fastOutSlowIn,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_showText) ...[
                          const SizedBox(width: 15),
                          const Text(
                            "Learnify",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // النص الفرعي (يظهر مع بهتان Fade-in)
              AnimatedOpacity(
                opacity: _showText ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 800),
                child: const Text(
                  "Your Unified University Experience",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
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
