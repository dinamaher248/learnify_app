import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnify_app/core/Api/endpoints.dart';
import 'package:learnify_app/core/utils/app_styles.dart';
import 'package:learnify_app/features/auth/presentation/view/main_login.dart';
import 'package:learnify_app/shared/widgets/custom_widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/Api/dio_consumer.dart';
import '../../../../../../core/utils/assets.dart';
import '../../../../../../core/utils/color.dart';
import '../../../../auth/data/repo/auth_repo.dart';
import '../../../../auth/presentation/view_models/auth_cubit.dart';
import '../../../../auth/presentation/view_models/auth_state.dart';

class ActivateParentAccountView extends StatelessWidget {
  ActivateParentAccountView({super.key, required this.isParentApp});
  bool isParentApp;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(
        AuthRepo(
          api: DioConsumer(dio: Dio(), baseUrl: Endpoints.baseAuthUrl),
        ),
      ),
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final bool _obscurePassword = true;

  String? _codeError;
  String? _passwordError;
  String? _emailError;
  String? _firstNameError;
  String? _lastNameError;

  void _validateAndSubmit() {
    setState(() {
      _codeError = null;
      _passwordError = null;

      if (_codeController.text.isEmpty) {
        _codeError = "Please enter a valid code.";
      }

      if (_emailController.text.isEmpty) {
        _emailError = "Please enter a valid email.";
      }

      if (_firstNameController.text.isEmpty) {
        _firstNameError = "Please enter a valid first name.";
      }

      if (_lastNameController.text.isEmpty) {
        _lastNameError = "Please enter a valid last name.";
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
                          SizedBox(height: 4.h),

                          Text("Code :", style: AppStyles.style16Medium),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _codeController,
                            prefixIcon: Icons.code,
                            hintText: "Enter your code",
                            errorText: _codeError,
                            obscureText: false,
                          ),
                          const SizedBox(height: 8),
                          Text("Email :", style: AppStyles.style16Medium),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _emailController,
                            prefixIcon: Icons.email,
                            hintText: "Enter your email",
                            errorText: _emailError,
                            obscureText: false,
                          ),
                          const SizedBox(height: 8),
                          Text("Password :", style: AppStyles.style16Medium),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _passwordController,
                            prefixIcon: Icons.lock,
                            isPassword: true,

                            hintText: "Enter your password",
                            errorText: _passwordError,
                            obscureText: true,
                          ),
                          const SizedBox(height: 8),
                          Text("First Name :", style: AppStyles.style16Medium),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _firstNameController,
                            prefixIcon: Icons.person,
                            hintText: "Enter your first name",
                            errorText: _firstNameError,
                            obscureText: false,
                          ),
                          const SizedBox(height: 8),
                          Text("Last Name :", style: AppStyles.style16Medium),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _lastNameController,
                            prefixIcon: Icons.person,
                            hintText: "Enter your last name",
                            errorText: _lastNameError,
                            obscureText: false,
                          ),

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
                                      context.read<AuthCubit>().activateParent(
                                        code: _codeController.text.trim(),
                                        email: _emailController.text.trim(),
                                        password: _passwordController.text
                                            .trim(),
                                        firstName: _firstNameController.text
                                            .trim(),
                                        lastName: _lastNameController.text
                                            .trim(),
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

                          // const SizedBox(height: 30),
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
