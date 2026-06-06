import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/conversation_model.dart';
import '../../data/repo/messages_repo.dart';

part 'conversations_state.dart';

class ConversationsCubit extends Cubit<ConversationsState> {
  final MessagesRepo repo;
  ConversationsCubit(this.repo) : super(ConversationsInitial());

  Future<void> loadConversations() async {
    try {
      emit(ConversationsLoading());
      final list = await repo.getConversations();
      emit(ConversationsLoaded(list));
    } catch (e) {
      emit(ConversationsError(e.toString()));
    }
  }
}
