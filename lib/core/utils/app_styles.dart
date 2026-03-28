import 'package:flutter/widgets.dart';

abstract class AppStyles {
  static const TextStyle style24SemiBold = TextStyle(
    fontFamily: 'Inter',
    fontSize: 24,
    fontWeight: FontWeight.w600, 
    height: 1.0,              
    letterSpacing: 0,          
  );
  static const TextStyle style20SemiBold = TextStyle(
    fontFamily: 'Inter',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.0,           // Line height 100%
    letterSpacing: 0,      // Letter spacing 0%
  );
static const TextStyle style16Medium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w500, // Medium
    height: 1.0,                // Line height 100%
    letterSpacing: 0,           // Letter spacing 0%
  );
  static const TextStyle style14Regular = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w400, // Regular
    height: 1.0,                // Line height 100%
    letterSpacing: 0,           // Letter spacing 0%
  );

  // static const TextStyle style20SemiBold = TextStyle(
  //   fontSize: 20,
  //   fontWeight: FontWeight.w600,
  //   fontFamily: 'Inter',
  // );

  static const TextStyle style14MediumInter = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: 'Inter',
  );
static const TextStyle style16MediumUppercase = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w400, // Medium
    height: 1.0,                // Line height 100%
    letterSpacing: 0,           // Letter spacing 0%
  );

  
  
}
