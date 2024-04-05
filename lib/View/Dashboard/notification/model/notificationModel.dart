class NotificationModel {
  NotificationModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<NotificationData> data;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<NotificationData>.from(
              json["data"]!.map((x) => NotificationData.fromJson(x))),
    );
  }
}

class NotificationData {
  NotificationData({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.typeId,
    required this.image,
    required this.isRead,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? title;
  final String? description;
  final String? type;
  final String? typeId;
  final String? image;
  final int? isRead;
  final int? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      type: json["type"],
      typeId: json["type_id"],
      image: json["image"],
      isRead: json["is_read"],
      userId: json["user_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
