import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnify_app/features/auth/presentation/view/login.dart';

import '../../../../core/Api/dio_consumer.dart';
import '../../data/repo/auth_repo.dart';
import '../view_models/auth_cubit.dart';

class MainLogin extends StatelessWidget {
  const MainLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthRepo(api: DioConsumer(dio: Dio()))),
      child: LoginScreen(),
    );
  }
}


class MainActive extends StatelessWidget {
  const MainActive({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}