class ScheduleModel {
  final String id;
  final String imageUrl;
  final String type;
  final String academicYear;

  ScheduleModel({
    required this.id,
    required this.imageUrl,
    required this.type,
    required this.academicYear,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['id'],
      imageUrl: json['imageUrl'],
      type: json['type'],
      academicYear: json['academicYear'],
    );
  }
}