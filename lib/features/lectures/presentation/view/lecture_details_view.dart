import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/Api/dio_consumer.dart';
import '../../../../../core/Api/endpoints.dart';
import '../../../../../core/routing/app_router.dart';
import '../../../attendance/presentation/view/attendance_view.dart';
import '../../data/repo/lecture_details_repo.dart';
import 'widgets/detail_item.dart';
import 'widgets/lecture_details_shimmer.dart';

class LectureDetailsView extends StatelessWidget {
  final String courseId;
  final String lectureId;

  const LectureDetailsView({
    super.key,
    required this.courseId,
    required this.lectureId,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LectureDetailsRepo(
        DioConsumer(dio: Dio(), baseUrl: Endpoints.baseAcadimicUrl),
      ).getLectureCheckerDetails(courseId, lectureId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LectureDetailsShimmer();
        }

        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        final lecture = snapshot.data!;

        return ListView(
          children: [
            DetailItem(
              icon: Icons.done_all,
              label: "Attendance",
              isChecked: true,
              onChanged: (val) {},
              onTap: () {
                context.push(AppRouter.attendancePath, extra: lecture.id);
              },
            ),

            DetailItem(
              icon: Icons.picture_as_pdf_outlined,
              label: "Lecture Pdf",
              isChecked: lecture.hasPdf,
              onChanged: (val) {},
              onTap: lecture.hasPdf
                  ? () {
                      context.push(AppRouter.lecturePdfPath, extra: lecture.id);
                    }
                  : null,
            ),

            DetailItem(
              icon: Icons.ondemand_video,
              label: "Video",
              isChecked: lecture.hasVideo,
              onChanged: (val) {},
              onTap: lecture.hasVideo
                  ? () {
                      // navigate and pass both id and title as extra
                      context.push(
                        AppRouter.videoPath.replaceFirst(
                          ':lectureId',
                          lecture.id,
                        ),
                        extra: {
                          'lectureId': lecture.id,
                          'lectureTitle': lecture.title,
                        },
                      );
                    }
                  : null,
            ),

            DetailItem(
              icon: Icons.edit,
              label: "Assignment",
              isChecked: lecture.hasAssignment,
              onChanged: (val) {},
              onTap: lecture.hasAssignment
                  ? () {
                      context.push(AppRouter.assignmentPath, extra: lecture.id);
                    }
                  : null,
            ),
          ],
        );
      },
    );
  }
}
