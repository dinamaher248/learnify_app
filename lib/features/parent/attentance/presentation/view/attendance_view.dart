import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnify_app/core/Api/dio_consumer.dart';
import 'package:learnify_app/core/Api/endpoints.dart';
import 'package:learnify_app/features/parent/attentance/data/repo/parent_attendance_repo.dart';
import 'package:learnify_app/features/parent/attentance/presentation/view_models/parent_attendance_cubit.dart';

import '../../../../../core/utils/custom_widgets/app_bar_widget.dart';
import '../../../courses/presentation/view/widgets/course_list_item.dart';
import '../../../courses/presentation/view/widgets/primary_action_button.dart';

class ParentAttendanceView extends StatelessWidget {
  final String? studentId;
  final String? studentName;
  const ParentAttendanceView({super.key, this.studentId, this.studentName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ParentAttendanceCubit(
        ParentAttendanceRepo(
          api: DioConsumer(dio: Dio(), baseUrl: Endpoints.baseAttendanceUrl),
        ),
      )..loadForChild(studentId ?? ''),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBarWidget(
          title: studentName != null && studentName!.isNotEmpty
              ? '$studentName - Attendance'
              : 'Attendance',
        ),
        body: BlocBuilder<ParentAttendanceCubit, ParentAttendanceState>(
          builder: (context, state) {
            if (state is ParentAttendanceLoading)
              return const Center(child: CircularProgressIndicator());
            if (state is ParentAttendanceError)
              return Center(child: Text('Error: ${state.message}'));
            if (state is ParentAttendanceLoaded) {
              final items = state.items;
              if (items.isEmpty)
                return const Center(child: Text('No attendance data'));
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return CourseListItem(
                    title: item.courseId,
                    instructorName:
                        'Attended ${item.attendedCount}/${item.totalLectures}',
                    trailingWidget: PrimaryActionButton(
                      label: '${(item.percentage * 100).toStringAsFixed(0)}%',
                      onPressed: () {},
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
