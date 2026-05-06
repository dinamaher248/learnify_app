import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnify_app/features/home/schedule/presentation/view_models/schedule_state.dart';

import '../../data/repo/schedule_repo.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  final ScheduleRepo repo;

  ScheduleCubit(this.repo) : super(ScheduleInitial());

 Future<void> getSchedule() async {
  emit(ScheduleLoading());

  try {
    final data = await repo.getSchedule(); 
    emit(ScheduleSuccess(data));
  } catch (e) {
    emit(ScheduleFailure(e.toString()));
  }
}
}