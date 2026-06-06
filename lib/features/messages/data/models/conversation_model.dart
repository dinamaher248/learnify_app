class ConversationModel {
  final String conversationId;
  final String otherUserId;
  final String? otherUserName;
  final String lastMessageAt;

  ConversationModel({
    required this.conversationId,
    required this.otherUserId,
    this.otherUserName,
    required this.lastMessageAt,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      conversationId: json['conversationId'],
      otherUserId: json['otherUserId'],
      otherUserName: json['otherUserName'],
      lastMessageAt: json['lastMessageAt'],
    );
  }
}
