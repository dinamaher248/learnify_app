part of 'conversations_cubit.dart';

abstract class ConversationsState {}

class ConversationsInitial extends ConversationsState {}

class ConversationsLoading extends ConversationsState {}

class ConversationsLoaded extends ConversationsState {
  final List<ConversationModel> conversations;
  ConversationsLoaded(this.conversations);
}

class ConversationsError extends ConversationsState {
  final String message;
  ConversationsError(this.message);
}
