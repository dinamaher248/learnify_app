import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnify_app/core/utils/app_styles.dart';

import '../../../../core/Api/dio_consumer.dart';
import '../../../../core/Api/endpoints.dart';
import '../../data/remote/attendance_remote_data_source.dart';
import '../../data/repo/attendance_repo.dart';
import '../view_models/attendance_cubit.dart';
import '../view_models/attendance_state.dart';

class AttendanceDialog extends StatefulWidget {
  const AttendanceDialog({super.key});

  @override
  State<AttendanceDialog> createState() => _AttendanceDialogState();
}

class _AttendanceDialogState extends State<AttendanceDialog> {
  late final AttendanceCubit _attendanceCubit;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _attendanceCubit = AttendanceCubit(
      AttendanceRepo(
        remoteDataSource: AttendanceRemoteDataSource(
          api: DioConsumer(dio: Dio(), baseUrl: Endpoints.baseAttendanceUrl),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _attendanceCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _attendanceCubit,
      child: BlocBuilder<AttendanceCubit, AttendanceState>(
        builder: (context, state) {
          if (!_isInitialized) {
            _isInitialized = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<AttendanceCubit>().fetchCoursesAttendance();
            });
          }

          return Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Image.network(
                        'https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=Example',
                        height: 150,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Code: ",
                            style: AppStyles.style24SemiBold.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: "19700",
                            style: AppStyles.style24SemiBold.copyWith(
                              color: const Color(0xFF5047E4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Enter Your Code",
                        hintStyle: AppStyles.style16Medium.copyWith(
                          color: const Color(0xff6B6868),
                        ),
                        prefixIcon: const Icon(
                          Icons.code,
                          color: Color(0xff6B6868),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFC6D1FB),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildAttendanceSection(state),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAttendanceSection(AttendanceState state) {
    if (state is AttendanceLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state is AttendanceFailure) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Text(
          state.message,
          textAlign: TextAlign.center,
          style: AppStyles.style16Medium.copyWith(color: Colors.red),
        ),
      );
    }

    if (state is AttendanceSuccess) {
      if (state.attendanceCourses.isEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Text(
            'No attendance records found.',
            style: AppStyles.style16Medium.copyWith(color: Colors.black54),
          ),
        );
      }

      return SizedBox(
        height: 200,
        child: ListView.separated(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          itemCount: state.attendanceCourses.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final item = state.attendanceCourses[index];
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Course: ${item.courseId}',
                          style: AppStyles.style16Medium.copyWith(color: Colors.black),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Attended ${item.attendedCount}/${item.totalLectures}',
                          style: AppStyles.style14Regular.copyWith(
                            color: const Color(0xFF6B6868),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${item.percentage.toStringAsFixed(1)}%',
                    style: AppStyles.style16Medium.copyWith(
                      color: const Color(0xFF5047E4),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
