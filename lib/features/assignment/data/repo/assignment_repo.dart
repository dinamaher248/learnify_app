import 'dart:io';

import 'package:dio/dio.dart' show FormData, MultipartFile;

import '../../../../../core/Api/dio_consumer.dart';
import '../models/assignment_model.dart';

class AssignmentRepo {
  final DioConsumer dioConsumer;

  AssignmentRepo({required this.dioConsumer});

  Future<AssignmentModel> getAssignment(String lectureId) async {
    final data = await dioConsumer.get(
      '/api/v1/academic/lectures/$lectureId/assignment',
    );
    return AssignmentModel.fromJson(data as Map<String, dynamic>);
  }

  Future<Map<String, dynamic>> getAssignmentStatus(String lectureId) async {
    final data = await dioConsumer.get(
      '/api/v1/academic/lectures/$lectureId/assignment/status',
    );
    return data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> submitAssignmentFile({
    required String lectureId,
    required String filePath,
  }) async {
    final fileName = filePath.split(RegExp(r'[\\/]')).last;

    final formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(filePath, filename: fileName),
    });

    final response = await dioConsumer.post(
      '/api/v1/academic/lectures/$lectureId/assignment/submit',
      data: formData,
    );
    print("path = $filePath");

    final file = File(filePath);

    print("exists = ${await file.exists()}");
    print("length = ${await file.length()}");
    return response;
  }

  Future<Map<String, dynamic>> submitAssignmentUrl({
    required String lectureId,
    required String projectUrl,
  }) async {
    final data = await dioConsumer.post(
      '/api/v1/academic/lectures/$lectureId/assignment/submit-url',
      data: {'projectUrl': projectUrl},
    );

    return data as Map<String, dynamic>;
  }
}
