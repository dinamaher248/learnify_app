import 'package:learnify_app/features/courses/data/models/instructor_model.dart';

import '../../../../core/utils/assets.dart';

class CourseModel {
  final String id;
  final String name;
  final String? description;
  final String? coverImageUrl;
  final String doctorId;
  final int completionPercentage;
  InstructorModel? instructor;
  CourseModel({
    required this.id,
    required this.name,
    this.description,
    this.coverImageUrl,
    required this.doctorId,
    required this.completionPercentage,
    this.instructor,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      coverImageUrl: json['coverImageUrl'],
      doctorId: json['doctorId'],
      completionPercentage: json['completionPercentage'],
    );
  }

  String get instructorName {
    if (instructor?.fullName != null && instructor!.fullName!.isNotEmpty) {
      return instructor!.fullName!;
    }
    return "Dr/ Unknown";
  }

  String get instructorImage {
    if (instructor?.profileImage != null &&
        instructor!.profileImage!.isNotEmpty) {
      return instructor!.profileImage!;
    }
    return AppAssets.profile;
  }
}
