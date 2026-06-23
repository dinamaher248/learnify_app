import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnify_app/core/utils/app_styles.dart';
import 'package:learnify_app/features/assignment/presentation/view/widgets/or_divider.dart';

import '../../../../../core/Api/dio_consumer.dart';
import '../../../../../core/Api/endpoints.dart';
import '../../../../core/utils/custom_widgets/app_bar_widget.dart';
import '../../data/remote/attendance_remote_data_source.dart';
import '../../data/repo/attendance_repo.dart';
import '../view_models/attendance_cubit.dart';
import '../view_models/attendance_state.dart';
import 'widgets/qr_scanner_view.dart' as learnify_qr;

class AttendanceView extends StatefulWidget {
  final String lectureId;
  const AttendanceView({super.key, required this.lectureId});

  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
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
      child: BlocConsumer<AttendanceCubit, AttendanceState>(
        listener: (context, state) {
          if (state is AttendanceRegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Attendance registered successfully!'),
              ),
            );
          } else if (state is AttendanceRegisterFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (!_isInitialized) {
            _isInitialized = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<AttendanceCubit>().fetchCoursesAttendance();
            });
          }

          return Scaffold(
            appBar: AppBarWidget(title: "Attendance"),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final scannedCode = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const learnify_qr.QRScannerView(),
                        ),
                      );
                      if (scannedCode != null && context.mounted) {
                        context.read<AttendanceCubit>().registerAttendance(
                          widget.lectureId,
                          scannedCode.toString(),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 20.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          // color: Color.fromARGB(255, 180, 198, 221),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 20.0,
                        ),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "QR code Capture",
                              style: AppStyles.style20SemiBold.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            Spacer(),

                            const Icon(
                              Icons.camera_alt,
                              size: 30,
                              color: Color(0xff6B6868),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (state is AttendanceRegisterSuccess) ...[
                    const Text("Attendance registered successfully!"),
                  ] else if (state is AttendanceRegisterFailure) ...[
                    Text(state.message),
                  ] else if (state is AttendanceRegisterLoading) ...[
                    const CircularProgressIndicator(),
                  ],

                  // const SizedBox(height: 24),

                  // OrDivider(),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          context.read<AttendanceCubit>().registerAttendance(
                            widget.lectureId,
                            value,
                          );
                        }
                      },
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
                  ),
                  // if (state is AttendanceRegisterLoading)
                  //   const Padding(
                  //     padding: EdgeInsets.only(top: 16.0),
                  //     child: Center(child: CircularProgressIndicator()),
                  //   ),
                  // const SizedBox(height: 24),
                  // _buildAttendanceSection(state),
                ],
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
                          style: AppStyles.style16Medium.copyWith(
                            color: Colors.black,
                          ),
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
