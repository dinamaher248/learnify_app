 class LectureDetailsModel {
  final String id;
  final String title;
  final String thumbnailUrl;
  final bool hasPdf;
  final bool hasVideo;
  final bool hasAssignment;

  LectureDetailsModel({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.hasPdf,
    required this.hasVideo,
    required this.hasAssignment,
  });

  factory LectureDetailsModel.fromJson(Map<String, dynamic> json) {
    return LectureDetailsModel(
      id: json['id'],
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'],
      hasPdf: json['hasPdf'],
      hasVideo: json['hasVideo'],
      hasAssignment: json['hasAssignment'],
    );
  }
}