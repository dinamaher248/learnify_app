import '../../data/models/assignment_model.dart';

abstract class AssignmentState {}

class AssignmentInitial extends AssignmentState {}

class AssignmentLoading extends AssignmentState {}

class AssignmentLoaded extends AssignmentState {
  final AssignmentModel assignment;
  AssignmentLoaded(this.assignment);
}

class AssignmentStatusLoaded extends AssignmentState {
  final bool isSubmitted;
  final DateTime? submittedAt;
  AssignmentStatusLoaded({required this.isSubmitted, this.submittedAt});
}

class AssignmentSuccess extends AssignmentState {
  final String message;
  AssignmentSuccess(this.message);
}

class AssignmentFailure extends AssignmentState {
  final String message;
  AssignmentFailure(this.message);
}
