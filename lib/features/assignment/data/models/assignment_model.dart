class AssignmentModel {
  final String id;
  final String title;
  final String instructions;
  final String fileUrl;
  final String lectureId;
  final String courseId;
  final DateTime? deadline;
  final bool isOpen;

  AssignmentModel({
    required this.id,
    required this.title,
    required this.instructions,
    required this.fileUrl,
    required this.lectureId,
    required this.courseId,
    required this.deadline,
    required this.isOpen,
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      instructions: json['instructions'] as String? ?? '',
      fileUrl: json['fileUrl'] as String? ?? '',
      lectureId: json['lectureId'] as String? ?? '',
      courseId: json['courseId'] as String? ?? '',
      deadline: json['deadline'] != null
          ? DateTime.parse(json['deadline'] as String)
          : null,
      isOpen: json['isOpen'] as bool? ?? false,
    );
  }
}
