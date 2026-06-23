import 'package:dio/dio.dart';
import '../../../../core/Api/api_consumer.dart';
import '../models/student_profile_model.dart';

class StudentProfileRepo {
  final ApiConsumer api;

  StudentProfileRepo(this.api);

  Future<StudentProfileModel> getStudentProfile() async {
    final response = await api.get(
      "/api/v1/auth/student/profile",
    );

    return StudentProfileModel.fromJson(response);
  }

  Future<void> updateStudentProfile({
    String? fullName,
    String? phoneNumber,
    String? imagePath,
  }) async {
    final Map<String, dynamic> data = {};
    if (fullName != null && fullName.isNotEmpty) {
      data['fullName'] = fullName;
    }
    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      data['phoneNumber'] = phoneNumber;
    }
    if (imagePath != null && imagePath.isNotEmpty) {
      data['profileImage'] = await MultipartFile.fromFile(imagePath);
    }

    final formData = FormData.fromMap(data);

    await api.put(
      "/api/v1/auth/student/profile",
      data: formData,
    );
  }
}