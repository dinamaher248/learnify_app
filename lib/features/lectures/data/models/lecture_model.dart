class LectureModel {
  final String id;
  final String title;
  final int orderIndex;
  final String? thumbnailUrl;
  final String courseId;

  LectureModel({
    required this.id,
    required this.title,
    required this.orderIndex,
    this.thumbnailUrl,
    required this.courseId,
  });

  factory LectureModel.fromJson(Map<String, dynamic> json) {
    return LectureModel(
      id: json['id'],
      title: json['title'],
      orderIndex: json['orderIndex'],
      thumbnailUrl: json['thumbnailUrl'],
      courseId: json['courseId'],
    );
  }
}