class InstructorModel {
  final String doctorId;
  final String courseId;
  final String? fullName;
  final String? profileImage;

  InstructorModel({
    required this.doctorId,
    required this.courseId,
    this.fullName,
    this.profileImage,
  });

  factory InstructorModel.fromJson(Map<String, dynamic> json) {
    return InstructorModel(
      doctorId: json['doctorId'],
      courseId: json['courseId'],
      fullName: json['fullName'],
      profileImage: json['profileImage'],
    );
  }
}