import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:learnify_app/core/routing/app_router.dart';
import 'package:learnify_app/core/utils/app_styles.dart';
import 'package:learnify_app/features/auth/presentation/view/main_login.dart';
import 'package:learnify_app/shared/widgets/custom_widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/Api/dio_consumer.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/color.dart';
import '../../data/repo/auth_repo.dart';
import '../view_models/auth_cubit.dart';
import '../view_models/auth_state.dart';

class ActivateAccountView extends StatelessWidget {
  const ActivateAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(AuthRepo(api: DioConsumer(dio: Dio()))),
      child: const _ActivateAccountBody(),
    );
  }
}

class _ActivateAccountBody extends StatefulWidget {
  const _ActivateAccountBody({super.key});

  @override
  State<_ActivateAccountBody> createState() => _ActivateAccountBodyState();
}

class _ActivateAccountBodyState extends State<_ActivateAccountBody> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = false;

  String? _codeError;
  String? _passwordError;

  void _validateAndSubmit() {
    setState(() {
      _codeError = null;
      _passwordError = null;

      if (_codeController.text.isEmpty) {
        _codeError = "Please enter a valid code.";
      }

      if (_passwordController.text.length < 6 ||
          !_passwordController.text.contains(RegExp(r'[0-9]'))) {
        _passwordError =
            "sorry.. your password must be at least 6 characters in length, and contain at least 1 number.";
      }
    });

    if (_codeError == null && _passwordError == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(' Successful!')));
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthCubit>().createStudent();
    });

    if (mounted) {
      context.read<AuthCubit>().createStudent();
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ActivateAccountSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text("Account Activated"),
            ),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => MainLogin()),
          );
        }

        if (state is ActivateAccountFailure) {
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
                          Text(
                            "Activate account",
                            style: AppStyles.style24SemiBold.copyWith(
                              color: Color(0xff24234D),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Activate your account to securely access your academic updates.",
                            style: AppStyles.style16Medium.copyWith(
                              color: Color(0xff6B6868),
                            ),
                          ),
                          SizedBox(height: 15.h),

                          Text("Code :", style: AppStyles.style16Medium),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _codeController,
                            prefixIcon: Icons.code,
                            hintText: "Enter your code",
                            errorText: _codeError,
                            obscureText: false,
                          ),

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

                          const SizedBox(height: 30),
                          const SizedBox(height: 20),

                          const SizedBox(height: 20),
                          PrimaryButton(
                            text: state is ActivateAccountLoading
                                ? "Loading..."
                                : "Activate Account",
                            onPressed: state is ActivateAccountLoading
                                ? null
                                : () {
                                    // 1. Trigger Form Validation (ensure your CustomTextField has a 'validator' property)
                                    if (_formKey.currentState!.validate()) {
                                      // 2. Call the Cubit with trimmed values
                                      context.read<AuthCubit>().activateAccount(
                                        _codeController.text.trim(),
                                        _passwordController.text.trim(),
                                      );
                                    }
                                  },
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: " already have an account? ",
                                    style: AppStyles.style14MediumInter
                                        .copyWith(color: Colors.black),
                                  ),
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MainLogin(),
                                          ),
                                        );
                                      },
                                    text: "Login",
                                    style: AppStyles.style14MediumInter
                                        .copyWith(color: Color(0xFF5047E4)),
                                  ),
                                ],
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
  }
}
