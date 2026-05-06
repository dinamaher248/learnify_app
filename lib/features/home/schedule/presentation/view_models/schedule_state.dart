import '../../data/models/schedule_model.dart';

abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleSuccess extends ScheduleState {
  final List<ScheduleModel> schedules;

  ScheduleSuccess(this.schedules);
}

class ScheduleFailure extends ScheduleState {
  final String message;

  ScheduleFailure(this.message);
}