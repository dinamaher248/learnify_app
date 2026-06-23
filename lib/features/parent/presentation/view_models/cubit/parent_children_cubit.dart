import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../data/repo/parent_repo.dart';
import 'parent_children_state.dart';

class ParentChildrenCubit extends Cubit<ParentChildrenState> {
  final ParentRepo repo;
  ParentChildrenCubit(this.repo) : super(ParentChildrenInitial());

  Future<void> loadChildren() async {
    emit(ParentChildrenLoading());
    try {
      final list = await repo.getChildren();
      emit(ParentChildrenLoaded(list));
    } on ServerException catch (e) {
      emit(ParentChildrenError(e.errorModel.errorMessage));
    } catch (e) {
      emit(ParentChildrenError(e.toString()));
    }
  }
}
