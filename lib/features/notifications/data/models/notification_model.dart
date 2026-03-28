class NotificationModel {
  final String doctorName;
  final String subject;
  final String time;
  final String? imageUrl;

  NotificationModel({
    required this.doctorName,
    required this.subject,
    required this.time,
    this.imageUrl,
  });
}