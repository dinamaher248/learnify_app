class MessageModel {
  final String id;
  final String senderId;
  final bool isMine;
  final String? content;
  final String? fileUrl;
  final String fileType;
  final bool isRead;
  final String sentAt;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.isMine,
    this.content,
    this.fileUrl,
    required this.fileType,
    required this.isRead,
    required this.sentAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      senderId: json['senderId'],
      isMine: json['isMine'] ?? false,
      content: json['content'] as String?,
      fileUrl: json['fileUrl'] as String?,
      fileType: json['fileType'] ?? 'None',
      isRead: json['isRead'] ?? false,
      sentAt: json['sentAt'],
    );
  }
}
