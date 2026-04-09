import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnify_app/features/auth/presentation/view_models/auth_cubit.dart';

import '../../features/auth/data/repo/auth_repo.dart';
import '../Api/dio_consumer.dart';
import './theme_cubit.dart';

List<BlocProvider> buildBlocProviders(DioConsumer dioConsumer) {
  return [
    BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),

    BlocProvider<AuthCubit>(
      create: (_) => AuthCubit(AuthRepo(api: dioConsumer)),
    ),
    // BlocProvider<HomeCubit>(
    //   create: (_) => HomeCubit(
    //     bannersCubit: BannersCubit(dioConsumer),
    //     productsCubit: ProductCubit(dioConsumer),
    //     brandCubit: BrandCubit(dioConsumer),
    //     categoryCubit: CategoryCubit(dioConsumer),
    //   ),
    // ),
  ];
}
