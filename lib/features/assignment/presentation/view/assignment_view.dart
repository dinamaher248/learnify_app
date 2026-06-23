import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnify_app/core/utils/app_styles.dart';
import 'package:learnify_app/core/utils/custom_widgets/app_bar_widget.dart';
import 'package:learnify_app/features/assignment/presentation/view/widgets/or_divider.dart';
import 'package:learnify_app/features/assignment/presentation/view/widgets/upload_area.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/Api/dio_consumer.dart';
import '../../../../core/Api/endpoints.dart';
import '../../data/repo/assignment_repo.dart';
import '../view_models/assignment_cubit.dart';
import '../view_models/assignment_state.dart';
import 'widgets/assignment_info_card.dart';
import 'widgets/assignment_url_Field.dart';

class AssignmentView extends StatefulWidget {
  final String lectureId;

  const AssignmentView({super.key, required this.lectureId});

  @override
  State<AssignmentView> createState() => _AssignmentViewState();
}

class _AssignmentViewState extends State<AssignmentView> {
  late final TextEditingController _urlController;

  @override
  void initState() {
    super.initState();
    _urlController = TextEditingController();
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          AssignmentCubit(
              AssignmentRepo(
                dioConsumer: DioConsumer(
                  dio: Dio(),
                  baseUrl: Endpoints.baseAcadimicUrl,
                ),
              ),
            )
            ..loadAssignment(widget.lectureId)
            ..loadStatus(widget.lectureId),
      child: Builder(
        builder: (context) {
          final assignmentCubit = context.read<AssignmentCubit>();
          return Scaffold(
            backgroundColor: Color(0xffF2F2F2),
            appBar: AppBarWidget(title: "Assignment"),
            body: BlocListener<AssignmentCubit, AssignmentState>(
              listener: (context, state) {
                if (state is AssignmentSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.green,
                    ),
                  );
                }

                if (state is AssignmentFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<AssignmentCubit, AssignmentState>(
                      builder: (context, state) {
                        if (state is AssignmentLoaded) {
                          final a = state.assignment;
                          return AssignmentInfoCard(
                            title: a.title,
                            fileUrl: a.fileUrl,
                            onDownload: () {},
                          );
                        }

                        // placeholder while loading or no assignment
                        return const AssignmentInfoCard(title: 'Assignment');
                      },
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<AssignmentCubit, AssignmentState>(
                      builder: (context, state) {
                        if (state is AssignmentLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is AssignmentLoaded) {
                          final a = state.assignment;
                          return Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(a.title, style: AppStyles.style20SemiBold),
                                const SizedBox(height: 8),
                                Text(
                                  a.instructions,
                                  style: AppStyles.style14Regular,
                                ),
                                const SizedBox(height: 8),
                                if (a.fileUrl.isNotEmpty)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.download_outlined),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: 30),
                    
                    UploadArea(
                      onUploadPressed: () async {
                        // use file_picker to select file and submit
                        final result = await FilePicker.platform.pickFiles(
                          allowMultiple: false,
                        );
                        if (result != null &&
                            result.files.single.path != null) {
                          final path = result.files.single.path!;
                          // ensure widget still mounted before using cubit
                          if (!mounted) return;
                          // call cubit submitFile
                          assignmentCubit.submitFile(widget.lectureId, path);
                        }
                      },
                    ),

                    SizedBox(height: 5.h),
                    OrDivider(),
                    SizedBox(height: 7.h),
                    Text(
                      "Share Project URL :",
                      style: AppStyles.style16Medium.copyWith(
                        color: Color(0xff6B6868),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AssignmentUrlField(
                      controller: _urlController,
                      onSubmit: () {
                        final url = _urlController.text.trim();
                        if (url.isNotEmpty) {
                          assignmentCubit.submitUrl(widget.lectureId, url);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
