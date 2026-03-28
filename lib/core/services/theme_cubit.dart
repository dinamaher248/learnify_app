import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static const String prefKey = 'isDarkMode';
  ThemeCubit() : super(ThemeMode.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool isDark = prefs.getBool(prefKey) ?? false;
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool isDark = state == ThemeMode.dark;
    await prefs.setBool(prefKey, !isDark);
    emit(!isDark ? ThemeMode.dark : ThemeMode.light);
  }
}
