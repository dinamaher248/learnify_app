import 'package:dio/dio.dart';
import 'package:learnify_app/core/Api/endpoints.dart';

import '../../../../../core/Api/api_consumer.dart';
import '../models/schedule_model.dart';

class ScheduleRepo {
  final ApiConsumer api;

  ScheduleRepo(this.api);

  Future<List<ScheduleModel>> getSchedule() async {
    final response = await api.get(Endpoints.scheduleUrl);

    return (response as List).map((e) => ScheduleModel.fromJson(e)).toList();
  }
}
