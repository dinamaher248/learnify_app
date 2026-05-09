class StudentProfileModel {
  final String id;
  final String fullName;
  final String email;
  final String universityId;
  final String departmentId;
  final String role;
  final String? phoneNumber;
  final String? profileImageUrl;

  StudentProfileModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.universityId,
    required this.departmentId,
    required this.role,
    this.phoneNumber,
    this.profileImageUrl,
  });

  factory StudentProfileModel.fromJson(Map<String, dynamic> json) {
    return StudentProfileModel(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      universityId: json['universityId'],
      departmentId: json['departmentId'],
      role: json['role'],
      phoneNumber: json['phoneNumber'],
      profileImageUrl: json['profileImageUrl'],
    );
  }

  String get displayImage =>
      (profileImageUrl != null && profileImageUrl!.isNotEmpty)
          ? profileImageUrl!
          : "assets/images/profile.png";
}