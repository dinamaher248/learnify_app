import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnify_app/core/Api/dio_consumer.dart';
import 'package:learnify_app/core/Api/endpoints.dart';
import 'package:learnify_app/features/profile_student/data/repo/grades_repo.dart';
import 'package:learnify_app/features/profile_student/presentation/view_models/grades_cubit.dart';
import 'package:learnify_app/features/profile_student/presentation/view_models/grades_state.dart';

import '../../../../../core/utils/custom_widgets/app_bar_widget.dart';
import '../../../courses/presentation/view/widgets/course_list_item.dart';
import 'widgets/grade_progress_bar.dart';

class ParentGradesScreen extends StatelessWidget {
  final String? studentId;
  final String? studentName;
  const ParentGradesScreen({super.key, this.studentId, this.studentName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GradesCubit(
        GradesRepo(DioConsumer(dio: Dio(), baseUrl: Endpoints.baseAcadimicUrl)),
      )..getGrades(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBarWidget(
          title: studentName != null && studentName!.isNotEmpty
              ? '$studentName - Grades'
              : 'Grades',
        ),
        body: BlocBuilder<GradesCubit, GradesState>(
          builder: (context, state) {
            if (state is GradesLoading || state is GradesInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is GradesFailure) {
              return Center(
                child: Text('Failed to load grades: ${state.error}'),
              );
            }

            final list = (state is GradesSuccess) ? state.grades : [];
            if (list.isEmpty)
              return const Center(child: Text('No grades available'));

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: list.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final course = list[index];
                return CourseListItem(
                  title: course.title,
                  instructorName: course.instructor ?? '',
                  trailingWidget: GradeProgressBar(progress: 0.5),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
