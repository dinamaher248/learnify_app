import 'package:flutter/material.dart';
import 'package:learnify_app/core/routing/app_router.dart';
import 'package:sizer/sizer.dart';

import 'core/utils/color.dart';
import 'features/home/presentation/view/home_view.dart';
import 'features/splash/presentation/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
          // theme: lightTheme,
          // darkTheme: darkTheme,
          // themeMode: themeMode,
          theme: ThemeData(
            primaryColor: AppColors.primaryColor,
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryColor,
            ),
            useMaterial3: true,
          ),
        );
      },
    );
  }
}
