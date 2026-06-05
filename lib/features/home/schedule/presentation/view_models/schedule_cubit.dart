import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnify_app/features/home/schedule/presentation/view_models/schedule_state.dart';

import '../../data/repo/schedule_repo.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  final ScheduleRepo repo;

  ScheduleCubit(this.repo) : super(ScheduleInitial());


Future<void> loadAllSchedules() async {
  emit(ScheduleLoading());

  try {
    final schedules = await repo.getSchedule();
    final midterms = await repo.getMidterm();

    emit(
      ScheduleLoaded(
        schedules: schedules,
        midterms: midterms,
      ),
    );
  } catch (e) {
    emit(ScheduleFailure(e.toString()));
  }
}
  // Future<void> getSchedule() async {
  //   if (!isClosed) emit(ScheduleLoading());

  //   try {
  //     final data = await repo.getSchedule();
  //     if (!isClosed) emit(ScheduleSuccess(data));
  //   } catch (e) {
  //     if (!isClosed) emit(ScheduleFailure(e.toString()));
  //   }
  // }

  // Future<void> getMidterm() async {
  //   if (!isClosed) emit(ScheduleLoading());

  //   try {
  //     final data = await repo.getMidterm();
  //     if (!isClosed) emit(ScheduleMidtermSuccess(data));
  //   } catch (e) {
  //     if (!isClosed) emit(ScheduleFailure(e.toString()));
  //   }
  // }
}
