import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:learnify_app/core/utils/app_styles.dart';
import 'package:learnify_app/features/auth/presentation/view/activate_account_view.dart';
import 'package:learnify_app/features/home/presentation/view/main_scaffold.dart';
import 'package:learnify_app/shared/widgets/custom_widgets.dart';
import 'package:learnify_app/features/auth/presentation/view/forget_password.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/Api/dio_consumer.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/color.dart';
import '../../../home/presentation/view/home_view.dart';
import '../../data/repo/auth_repo.dart';
import '../view_models/auth_cubit.dart';
import '../view_models/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = false;

  String? _emailError;
  String? _passwordError;

  void _validateAndSubmit() {
    setState(() {
      _emailError = null;
      _passwordError = null;

      if (_emailController.text.isEmpty ||
          !_emailController.text.contains('@')) {
        _emailError = "Please enter a valid email.";
      }

      if (_passwordController.text.length < 6 ||
          !_passwordController.text.contains(RegExp(r'[0-9]'))) {
        _passwordError =
            "sorry.. your password must be at least 6 characters in length, and contain at least 1 number.";
      }
    });

    if (_emailError == null && _passwordError == null) {}
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Login Success")));
        }

        if (state is LoginFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }

        if (state is ActivateAccountSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Activated")));
        }

        if (state is ActivateAccountFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("Login Success"),
                ),
              );

              //! navigation
              // Navigator.pushReplacement(...);
            }

            if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    state.message,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: AppColors.primaryColor,
              body: Column(
                children: [
                  Expanded(
                    flex: 25,
                    child: SafeArea(
                      bottom: false,
                      child: Center(
                        child: Image.asset(
                          AppAssets.splashLogo,
                          height: 80,
                          width: 80,
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 75,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8F8F8),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30),
                              const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Log In To Clearly Follow Your Lectures And\nGrades.",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 30),

                              Text(
                                _emailError != null
                                    ? "Student ID :"
                                    : "Email ID :",
                                style: AppStyles.style16Medium,
                              ),
                              const SizedBox(height: 8),
                              CustomTextField(
                                controller: _emailController,
                                hintText: "Enter Your Email Id",
                                prefixIcon: Icons.school_outlined,
                                errorText: _emailError,
                              ),
                              const SizedBox(height: 20),

                              const Text(
                                "Password :",
                                style: AppStyles.style16Medium,
                              ),
                              const SizedBox(height: 8),
                              CustomTextField(
                                controller: _passwordController,
                                hintText: "Enter Your Password",
                                isPassword: true,
                                errorText: _passwordError,
                                obscureText: _obscurePassword,
                                onSuffixTap: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              const SizedBox(height: 10),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Checkbox(
                                          value: _rememberMe,
                                          onChanged: (value) {
                                            setState(() {
                                              _rememberMe = value ?? false;
                                            });
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                          side: const BorderSide(
                                            color: AppColors.primaryColor,
                                          ),
                                          activeColor: AppColors.primaryColor,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        "Remember me",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.textColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => BlocProvider(
                                            create: (_) => AuthCubit(
                                              AuthRepo(
                                                api: DioConsumer(dio: Dio()),
                                              ),
                                            ),
                                            child: ForgotPasswordScreen(),
                                          ),
                                        ),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: const Text(
                                      "Forget Password?",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.textColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              PrimaryButton(
                                text: state is LoginLoading
                                    ? "Loading..."
                                    : "Login",
                                onPressed: state is LoginLoading
                                    ? null
                                    : () {
                                        _validateAndSubmit();

                                        if (_emailError == null &&
                                            _passwordError == null) {
                                          context.read<AuthCubit>().login(
                                            _emailController.text,
                                            _passwordController.text,
                                            _rememberMe,
                                          );
                                         // context.go(AppRouter.homePath);
                                        }
                                      },
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: Color(0xff6B6868),
                                      thickness: 1,
                                      indent: 2.w,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    child: Text(
                                      "or",
                                      style: AppStyles.style20SemiBold.copyWith(
                                        color: Color(0xff6B6868),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: Color(0xff6B6868),
                                      thickness: 1,
                                      endIndent: 2.w,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              SizedBox(
                                width: double.infinity,
                                height: 55,
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ActivateAccountView(),
                                      ),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: AppColors.primaryColor,
                                      width: 1.5,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: const Text(
                                    "Activate account",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
