class ReferralModel {
  ReferralModel({
    required this.status,
    required this.message,
    required this.data,
    required this.wallet,
  });

  final bool? status;
  final String? message;
  final List<ReferralData> data;
  final String? wallet;

  factory ReferralModel.fromJson(Map<String, dynamic> json) {
    return ReferralModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<ReferralData>.from(
              json["data"]!.map((x) => ReferralData.fromJson(x))),
      wallet: json["wallet"],
    );
  }
}

class ReferralData {
  ReferralData({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  final int? id;
  final String? name;
  final DateTime? createdAt;

  factory ReferralData.fromJson(Map<String, dynamic> json) {
    return ReferralData(
      id: json["id"],
      name: json["name"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }
}
