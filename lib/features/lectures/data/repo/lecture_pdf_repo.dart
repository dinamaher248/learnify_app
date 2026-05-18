// Academic – Lecture Materials

// GET
// /api/v1/academic/lectures/{lectureId}/pdf
// Get lecture PDF (Student)

// Parameters
// Cancel
// Name	Description
// lectureId *
// string($uuid)
// (path)
// 1aca7d6f-b28d-4206-8f33-2fb64d17492c
// Execute
// Clear
// Responses
// Curl

// curl -X 'GET' \
//   'https://academic.learnefy.tech/api/v1/academic/lectures/1aca7d6f-b28d-4206-8f33-2fb64d17492c/pdf' \
//   -H 'accept: */*' \
//   -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjkzZWNmNzgyLTUzZTYtNGU2ZC1iNGNkLTMwNzhiZmExY2JhZCIsImlkIjoiOTNlY2Y3ODItNTNlNi00ZTZkLWI0Y2QtMzA3OGJmYTFjYmFkIiwiZW1haWwiOiJzdHVkZW50QGdtYWlsLmNvbSIsImp0aSI6ImNlNjkxN2U4LWY2MjktNGJjNy05OTRkLTRhY2MwYWZiYzNjNCIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlN0dWRlbnQiLCJkZXBhcnRtZW50SWQiOiJiZGEwZjU3Yy1iYzBkLTQxYmQtODcwYi01YTRmNWYwMTkxYjEiLCJleHAiOjE3NzgzMzczNDIsImlzcyI6IkxlYXJuaWZ5U3lzdGVtIiwiYXVkIjoiTGVhcm5pZnlDbGllbnRzIn0.cYF1967sLrW_nDSXMqsV2g9rzAoOc9wu7ZkFz8I8NdY'
// Request URL
// https://academic.learnefy.tech/api/v1/academic/lectures/1aca7d6f-b28d-4206-8f33-2fb64d17492c/pdf
// Server response
// Code	Details
// 200
// Response body
// Download
// {
//   "id": "86d11ac1-70ac-42cb-a11d-f106a011660f",
//   "fileUrl": "http://academic.learnefy.tech/Uploads/Files/Lectures/caee31fb-9a9b-45c2-a92b-e3946b59bc38.pdf",
//   "lectureId": "1aca7d6f-b28d-4206-8f33-2fb64d17492c"
// }

import '../../../../core/Api/dio_consumer.dart';
import '../models/lecture_pdf_model.dart';

class LecturePdfRepo {
  final DioConsumer dioConsumer;

  LecturePdfRepo({required this.dioConsumer});

  Future<LecturePdfModel> getLecturePdf(String lectureId) async {
    final response = await dioConsumer.get(
      '/api/v1/academic/lectures/$lectureId/pdf',
    );

    return LecturePdfModel.fromJson(response);
  }
}
