import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/dio_consumer.dart';
import './theme_cubit.dart';

List<BlocProvider> buildBlocProviders(DioConsumer dioConsumer) {
  return [
    BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),

    // BlocProvider<SigninCubit>(create: (_) => SigninCubit(dioConsumer)),

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
