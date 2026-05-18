

class LecturePdfModel {
  final String id;
  final String fileUrl;
  final String lectureId;

  LecturePdfModel({
    required this.id,
    required this.fileUrl,
    required this.lectureId,
  });

  factory LecturePdfModel.fromJson(Map<String, dynamic> json) {
    return LecturePdfModel(
      id: json['id'],
      fileUrl: json['fileUrl'],
      lectureId: json['lectureId'],
    );
  }
} 