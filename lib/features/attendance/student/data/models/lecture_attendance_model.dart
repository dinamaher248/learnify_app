class LectureAttendanceModel {
  final String lectureId;
  final String lectureTitle;
  final bool isAttended;
  final DateTime? registeredAt;

  LectureAttendanceModel({
    required this.lectureId,
    required this.lectureTitle,
    required this.isAttended,
    this.registeredAt,
  });

  factory LectureAttendanceModel.fromJson(Map<String, dynamic> json) {
    return LectureAttendanceModel(
      lectureId: json['lectureId'] as String? ?? '',
      lectureTitle: json['lectureTitle'] as String? ?? '',
      isAttended: (json['isAttended'] as bool?) ?? false,
      registeredAt: json['registeredAt'] != null
          ? DateTime.tryParse(json['registeredAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lectureId': lectureId,
      'lectureTitle': lectureTitle,
      'isAttended': isAttended,
      'registeredAt': registeredAt?.toIso8601String(),
    };
  }
}
