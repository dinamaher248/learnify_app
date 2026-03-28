import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
  //     brightness: Brightness.light,
  //     textTheme: const TextTheme(
  //       bodyLarge: TextStyle(color: AppColors.primaryText),
  //       bodyMedium: TextStyle(color: AppColors.primaryText),
  //       bodySmall: TextStyle(color: AppColors.primaryText),
  //       titleLarge: TextStyle(color: AppColors.primaryText),
  //       titleMedium: TextStyle(color: AppColors.primaryText),
  //       titleSmall: TextStyle(color: AppColors.primaryText),
  //     ),
  //     scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
  //     appBarTheme: AppBarTheme(
  //       backgroundColor: AppColors.scaffoldBackgroundColor,
  //       elevation: 0,
  //       iconTheme: IconThemeData(color: AppColors.primaryText),
  //       titleTextStyle: AppStyles.style14MediumInter.copyWith(
  //         color: AppColors.primaryText,
  //       ),
  //     ),

  //     bottomAppBarTheme: BottomAppBarThemeData(
  //       color: AppColors.whiteColor,
  //     ),

  //     iconTheme: const IconThemeData(color: AppColors.lightBottomIcon),
  //   );
  // }

  // static ThemeData get darkTheme {
  //   return ThemeData(
  //     brightness: Brightness.dark,
  //     textTheme: const TextTheme(
  //       bodyLarge: TextStyle(color: Colors.white),
  //       bodyMedium: TextStyle(color: Colors.white),
  //       bodySmall: TextStyle(color: Colors.white),

  //       titleLarge: TextStyle(color: Colors.white),
  //       titleMedium: TextStyle(color: Colors.white),
  //       titleSmall: TextStyle(color: Colors.white),
  //     ),
  //     // scaffoldBackgroundColor: AppColors.darkModeBackground,
  //     appBarTheme: AppBarTheme(
  //       backgroundColor: Colors.black,
  //       elevation: 0,
  //       iconTheme: IconThemeData(color: Colors.white),
  //       titleTextStyle: AppStyles.style14MediumInter.copyWith(
  //         color: AppColors.whiteColor,
  //       ),
  //     ),
  //      bottomAppBarTheme: BottomAppBarThemeData(
  //       color: AppColors.darkBg,
  //     ),

  //     iconTheme: const IconThemeData(color: AppColors.whiteColor),
    
    );
  }
}
