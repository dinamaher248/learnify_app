class LectureVideoModel {
  final String id;
  final String videoUrl;
  final int durationInMinutes;
  final String lectureId;

  LectureVideoModel({
    required this.id,
    required this.videoUrl,
    required this.durationInMinutes,
    required this.lectureId,
  });

  factory LectureVideoModel.fromJson(Map<String, dynamic> json) {
    return LectureVideoModel(
      id: json['id'],
      videoUrl: json['videoUrl'],
      durationInMinutes: json['durationInMinutes'] ?? 0,
      lectureId: json['lectureId'],
    );
  }
}
