import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learnify_app/core/routing/app_router.dart';
import '../../data/models/lecture_model.dart';
import 'widgets/lecture_card.dart';

class LectureView extends StatelessWidget {
  LectureView({super.key});
  final List<LectureModel> lectures = [
    LectureModel(
      title: "Lecture 01:",
      subTitle: "Information System",
      image: "assets/images/lec1.png",
    ),
    LectureModel(
      title: "Lecture 02:",
      subTitle: "Information System",
      image: "assets/images/lec2.png",
    ),
    LectureModel(
      title: "Lecture 03:",
      subTitle: "Information System",
      image: "assets/images/lec3.png",
    ),
    LectureModel(
      title: "Lecture 04:",
      subTitle: "Information System",
      image: "assets/images/lec4.png",
    ),
    LectureModel(
      title: "Lecture 05:",
      subTitle: "Information System",
      image: "assets/images/lec5.png",
    ),
    LectureModel(
      title: "Lecture 06:",
      subTitle: "Information System",
      image: "assets/images/lec1.png",
    ),
  ];

  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lectures.length,
      itemBuilder: (context, index) {
        final lecture = lectures[index];
        return LectureCard(
          title: lecture.title,
          subtitle: lecture.subTitle,
          imagePath: lecture.image,
          onTap: () {
            context.push(AppRouter.lectureDetailsPath);
          },
        );
      },
    );
  }
}
