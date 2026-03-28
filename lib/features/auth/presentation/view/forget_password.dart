import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learnify_app/shared/widgets/custom_widgets.dart';

import '../../../../core/utils/assets.dart';
import '../../../../core/utils/color.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  // --- Step 1 Variables ---
  final TextEditingController _contactController = TextEditingController();
  String? _contactError;

  // --- Step 2 Variables ---
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _otpFocusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );

  // --- Step 3 Variables ---
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  String? _newPasswordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _pageController.dispose();
    _contactController.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _otpFocusNodes) {
      node.dispose();
    }
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitStep1() {
    setState(() {
      _contactError = null;
      if (_contactController.text.isEmpty ||
          _contactController.text.length < 8) {
        _contactError = "Please enter a valid phone or email .";
      }
    });

    if (_contactError == null) {
      _goToNextStep();
    }
  }

  void _submitStep3() {
    setState(() {
      _newPasswordError = null;
      _confirmPasswordError = null;

      if (_newPasswordController.text.length < 6 ||
          !_newPasswordController.text.contains(RegExp(r'[0-9]'))) {
        _newPasswordError =
            "sorry.. your password must be at least 6 characters in length, and contain at least 1 number.";
      }

      if (_confirmPasswordController.text != _newPasswordController.text) {
        _confirmPasswordError =
            "Confirm password does not match the password you entered .";
      }
    });

    if (_newPasswordError == null && _confirmPasswordError == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password Reset Successfully!')),
      );
      Navigator.pop(context);
    }
  }

  void _goToNextStep() {
    if (_currentStep < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentStep++;
      });
    }
  }

  void _goToPreviousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: _goToPreviousStep,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 15,
            child: Center(
              child: Image.asset(AppAssets.splashLogo, height: 70, width: 70),
            ),
          ),

          Expanded(
            flex: 85,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20.0,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFFF8F8F8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: List.generate(3, (index) {
                      return Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          height: 6,
                          decoration: BoxDecoration(
                            color: index <= _currentStep
                                ? AppColors.primaryColor
                                : AppColors.secondaryColor.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 24),

                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [_buildStep1(), _buildStep2(), _buildStep3()],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Forgot Your Password?",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "If you want to ask the user to enter their email\naddress for the code to be sent.",
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 40),

          const Text(
            "Phone / Email :",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 8),
          CustomTextField(
            controller: _contactController,
            hintText: "Enter Your Phone or Email",
            prefixIcon: Icons.phone_in_talk_outlined,
            errorText: _contactError,
          ),
          const SizedBox(height: 40),

          PrimaryButton(text: "Send Message", onPressed: _submitStep1),
        ],
      ),
    );
  }

  Widget _buildStep2() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Verification Code Entry",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Please enter the verification code sent to your email\naddress:",
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 40),

          const Center(
            child: Text(
              "Kalan Sure\n02:58",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) {
              return SizedBox(
                width: 65,
                height: 65,
                child: TextFormField(
                  controller: _otpControllers[index],
                  focusNode: _otpFocusNodes[index],
                  onChanged: (value) {
                    if (value.length == 1) {
                      if (index < 3) {
                        FocusScope.of(
                          context,
                        ).requestFocus(_otpFocusNodes[index + 1]);
                      } else {
                        FocusScope.of(context).unfocus();
                        _goToNextStep();
                      }
                    } else if (value.isEmpty && index > 0) {
                      FocusScope.of(
                        context,
                      ).requestFocus(_otpFocusNodes[index - 1]);
                    }
                  },
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: _otpControllers[index].text.isNotEmpty
                        ? const Color(0xFFFFD6D6)
                        : AppColors.secondaryColor.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: AppColors.primaryColor,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: AppColors.primaryColor,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 30),

          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "Send Again",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryColor,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep3() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Create New Password",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Please enter and confirm your new password:",
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 30),

          const Text(
            "Password :",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 8),
          CustomTextField(
            controller: _newPasswordController,
            hintText: "Enter Your Password",
            isPassword: true,
            errorText: _newPasswordError,
            obscureText: _obscureNewPassword,
            onSuffixTap: () {
              setState(() {
                _obscureNewPassword = !_obscureNewPassword;
              });
            },
          ),
          const SizedBox(height: 20),

          const Text(
            "Confirm Password :",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 8),
          // تم إصلاح الخطأ هنا باستخدام Controller الخاص بالتأكيد
          CustomTextField(
            controller: _confirmPasswordController,
            hintText: "Enter Your Password",
            isPassword: true,
            errorText: _confirmPasswordError,
            obscureText: _obscureConfirmPassword,
            onSuffixTap: () {
              setState(() {
                _obscureConfirmPassword = !_obscureConfirmPassword;
              });
            },
          ),
          const SizedBox(height: 40),

          PrimaryButton(text: "Save Password", onPressed: _submitStep3),
        ],
      ),
    );
  }
}
