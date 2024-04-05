class AdListModel {
  AdListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<AdListData> data;

  factory AdListModel.fromJson(Map<String, dynamic> json) {
    return AdListModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<AdListData>.from(
              json["data"]!.map((x) => AdListData.fromJson(x))),
    );
  }
}

class AdListData {
  AdListData({
    required this.id,
    required this.adId,
    required this.startDate,
    required this.productIds,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
    required this.transactionId,
    required this.amount,
    required this.sellerId,
    required this.advertisement,
  });

  final int? id;
  final int? adId;
  final DateTime? startDate;
  final String? productIds;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? image;
  final String? transactionId;
  final String? amount;
  final int? sellerId;
  final Advertisement? advertisement;

  factory AdListData.fromJson(Map<String, dynamic> json) {
    return AdListData(
      id: json["id"],
      adId: json["ad_id"],
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      productIds: json["product_ids"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      image: json["image"],
      transactionId: json["transaction_id"],
      amount: json["amount"],
      sellerId: json["seller_id"],
      advertisement: json["advertisement"] == null
          ? null
          : Advertisement.fromJson(json["advertisement"]),
    );
  }
}

class Advertisement {
  Advertisement({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.image,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
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

  factory Advertisement.fromJson(Map<String, dynamic> json) {
    return Advertisement(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      endDate: DateTime.tryParse(json["end_date"] ?? ""),
      image: json["image"],
      amount: json["amount"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
