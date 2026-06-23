import '../../../data/models/parent_child_model.dart';

abstract class ParentChildrenState {}

class ParentChildrenInitial extends ParentChildrenState {}

class ParentChildrenLoading extends ParentChildrenState {}

class ParentChildrenLoaded extends ParentChildrenState {
  final List<ParentChildModel> children;
  ParentChildrenLoaded(this.children);
}

class ParentChildrenError extends ParentChildrenState {
  final String message;
  ParentChildrenError(this.message);
}
