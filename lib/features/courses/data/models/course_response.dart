import 'package:learnify_app/features/courses/data/models/course_models.dart';

class CourseResponse {
  final List<CourseModel> data;
  final int pageNumber;
  final int pageSize;
  final int totalCount;
  final int totalPages;

  CourseResponse({
    required this.data,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
  });

  factory CourseResponse.fromJson(Map<String, dynamic> json) {
    return CourseResponse(
      data: List<CourseModel>.from(
        json['data'].map((e) => CourseModel.fromJson(e)),
      ),
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
      totalCount: json['totalCount'],
      totalPages: json['totalPages'],
    );
  }
}