class CourseAttendanceModel {
  final String courseId;
  final int totalLectures;
  final int attendedCount;
  final double percentage;

  CourseAttendanceModel({
    required this.courseId,
    required this.totalLectures,
    required this.attendedCount,
    required this.percentage,
  });

  factory CourseAttendanceModel.fromJson(Map<String, dynamic> json) {
    return CourseAttendanceModel(
      courseId: json['courseId'] as String? ?? '',
      totalLectures: (json['totalLectures'] as num?)?.toInt() ?? 0,
      attendedCount: (json['attendedCount'] as num?)?.toInt() ?? 0,
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courseId': courseId,
      'totalLectures': totalLectures,
      'attendedCount': attendedCount,
      'percentage': percentage,
    };
  }
}
