import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../data/repo/assignment_repo.dart';
import 'assignment_state.dart';

class AssignmentCubit extends Cubit<AssignmentState> {
  final AssignmentRepo repo;

  AssignmentCubit(this.repo) : super(AssignmentInitial());

  Future<void> loadAssignment(String lectureId) async {
    if (!isClosed) emit(AssignmentLoading());
    try {
      final model = await repo.getAssignment(lectureId);
      if (!isClosed) emit(AssignmentLoaded(model));
    } on ServerException catch (e) {
      if (!isClosed) emit(AssignmentFailure(e.errorModel.errorMessage));
    } catch (e) {
      if (!isClosed) emit(AssignmentFailure(e.toString()));
    }
  }

  Future<void> loadStatus(String lectureId) async {
    try {
      final map = await repo.getAssignmentStatus(lectureId);
      final isSubmitted = map['isSubmitted'] as bool? ?? false;
      final submittedAt = map['submittedAt'] != null
          ? DateTime.parse(map['submittedAt'] as String)
          : null;
      if (!isClosed)
        emit(
          AssignmentStatusLoaded(
            isSubmitted: isSubmitted,
            submittedAt: submittedAt,
          ),
        );
    } on ServerException catch (e) {
      if (!isClosed) emit(AssignmentFailure(e.errorModel.errorMessage));
    } catch (e) {
      if (!isClosed) emit(AssignmentFailure(e.toString()));
    }
  }

  Future<void> submitFile(String lectureId, String filePath) async {
    if (!isClosed) emit(AssignmentLoading());
    try {
      final res = await repo.submitAssignmentFile(
        lectureId: lectureId,
        filePath: filePath,
      );
      if (!isClosed)
        emit(AssignmentSuccess(res['message']?.toString() ?? 'Submitted'));
    } on ServerException catch (e) {
      if (!isClosed) emit(AssignmentFailure(e.errorModel.errorMessage));
    } catch (e) {
      if (!isClosed) emit(AssignmentFailure(e.toString()));
    }
  }

  Future<void> submitUrl(String lectureId, String projectUrl) async {
    if (!isClosed) emit(AssignmentLoading());
    try {
      final res = await repo.submitAssignmentUrl(
        lectureId: lectureId,
        projectUrl: projectUrl,
      );
      final msg = res['message']?.toString() ?? 'Submitted';
      if (!isClosed) emit(AssignmentSuccess(msg));
    } on ServerException catch (e) {
      if (!isClosed) emit(AssignmentFailure(e.errorModel.errorMessage));
    } catch (e) {
      if (!isClosed) emit(AssignmentFailure(e.toString()));
    }
  }
}
