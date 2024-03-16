class NotificationsModels {
  String date;
  String title;
  String message;
  String notificationType;
  String? photo;
  bool isNew;
  NotificationsModels({
    required this.date,
    this.photo,
    required this.message,
    required this.notificationType,
    required this.title,
    required this.isNew,
  });
}
