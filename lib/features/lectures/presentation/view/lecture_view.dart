import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:learnify_app/core/routing/app_router.dart';
import '../../../../core/Api/dio_consumer.dart';
import '../../../../core/Api/endpoints.dart';
import '../../data/repo/lecture_repo.dart';
import '../view_models/lecture_cubit.dart';
import '../view_models/lecture_state.dart';
import 'widgets/lecture_card.dart';
import 'widgets/lecture_shimmer.dart';

class LectureView extends StatelessWidget {
  final String courseId;

  const LectureView({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LectureCubit(
        LectureRepo(
          DioConsumer(dio: Dio(), baseUrl: Endpoints.baseAcadimicUrl),
        ),
      )..getLectures(courseId),
      child: const LectureViewBody(),
    );
  }
}

class LectureViewBody extends StatelessWidget {
  const LectureViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LectureCubit, LectureState>(
      builder: (context, state) {
        if (state is LectureLoading) {
          return const LectureShimmer();
        }

        if (state is LectureFailure) {
          return Center(child: Text(state.message));
        }

        if (state is LectureSuccess) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.lectures.length,
            itemBuilder: (context, index) {
              final lecture = state.lectures[index];

              return LectureCard(
                title: lecture.title,
                subtitle: "Lecture ${lecture.orderIndex}",
                imagePath: lecture.thumbnailUrl ?? "",
                onTap: () {
                  context.push(
                    AppRouter.lectureDetailsPath,
                    extra: {
                      "courseId": lecture.courseId,
                      "lectureId": lecture.id,
                    },
                  );
                },
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
