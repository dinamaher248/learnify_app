import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool obscurePassword = true;
  bool rememberMe = false;

  String? emailError;
  String? passwordError;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void toggleRememberMe(bool? value) {
    rememberMe = value ?? false;
    notifyListeners();
  }

  void validateAndSubmit() {
    emailError = null;
    passwordError = null;

    if (emailController.text.isEmpty || !emailController.text.contains('@')) {
      emailError = "Please enter a valid email.";
    }

    if (passwordController.text.length < 6 ||
        !passwordController.text.contains(RegExp(r'[0-9]'))) {
      passwordError =
          "sorry.. your password must be at least 6 characters in length, and contain at least 1 number.";
    }

    notifyListeners();
  }

  bool get isValid => emailError == null && passwordError == null;

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}