class AdvertModel {
  AdvertModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<AdvertData> data;

  factory AdvertModel.fromJson(Map<String, dynamic> json) {
    return AdvertModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<AdvertData>.from(
              json["data"]!.map((x) => AdvertData.fromJson(x))),
    );
  }
}

class AdvertData {
  AdvertData({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.image,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
    required this.amountWithCurrency,
  });

  final int? id;
  final String? title;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? image;
  final String? amount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? amountWithCurrency;

  factory AdvertData.fromJson(Map<String, dynamic> json) {
    return AdvertData(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      endDate: DateTime.tryParse(json["end_date"] ?? ""),
      image: json["image"],
      amount: json["amount"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      amountWithCurrency: json["amount_with_currency"],
    );
  }
}
