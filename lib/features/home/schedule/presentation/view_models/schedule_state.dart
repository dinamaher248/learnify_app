import '../../data/models/schedule_model.dart';

abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final List<ScheduleModel> schedules;
  final List<ScheduleModel> midterms;

  ScheduleLoaded({
    required this.schedules,
    required this.midterms,
  });
}

class ScheduleFailure extends ScheduleState {
  final String message;

  ScheduleFailure(this.message);
}


