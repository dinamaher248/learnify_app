import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnify_app/core/utils/assets.dart';
import 'package:learnify_app/features/home/presentation/view/widgets/row_show.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/Api/dio_consumer.dart';
import '../../../../../core/Api/endpoints.dart';
import '../../data/repo/schedule_repo.dart';
import '../view_models/schedule_cubit.dart';
import '../view_models/schedule_state.dart';

class ScheduleSection extends StatelessWidget {
  const ScheduleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleCubit(
        ScheduleRepo(
          DioConsumer(dio: Dio(), baseUrl: Endpoints.baseAcadimicUrl),
        ),
      )..getSchedule(),
      child: ScheduleWidget(),
    );
  }
}

class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleCubit, ScheduleState>(
      builder: (context, state) {
        String imageUrl = AppAssets.schedule_image;

        if (state is ScheduleSuccess && state.schedules.isNotEmpty) {
          imageUrl = state.schedules.first.imageUrl;
        }
        if (state is ScheduleLoading) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        Row(
          children: [
            RowShow(title: "Schedule :", subTitle: "Show All"),
          ],
        ),
        const SizedBox(height: 10),

        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 200,
              width: double.infinity,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
        if (state is ScheduleFailure) {
          return Text(state.message);
        }
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [RowShow(title: "Schedule :", subTitle: "Show All")],
              ),
              const SizedBox(height: 10),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) {
                        return Scaffold(
                          backgroundColor: Colors.black,
                          appBar: AppBar(
                            backgroundColor: Colors.black,
                            iconTheme: const IconThemeData(color: Colors.white),
                            elevation: 0,
                          ),
                          body: Center(
                            child: InteractiveViewer(
                              panEnabled: true,
                              minScale: 0.5,
                              maxScale: 4.0,
                              child: Hero(
                                tag: 'schedule_img',
                                child: buildImage(imageUrl),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                child: Hero(
                  tag: 'schedule_img',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: buildImage(imageUrl),
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

Widget buildImage(String url) {
  if (url.isEmpty) {
    return Image.asset(AppAssets.schedule_image);
  }

  if (url.startsWith('http')) {
    return Image.network(
      url,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(AppAssets.schedule_image);
      },
    );
  } else {
    return Image.asset(url);
  }
}
