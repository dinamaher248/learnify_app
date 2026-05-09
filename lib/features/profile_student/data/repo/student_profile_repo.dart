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
}