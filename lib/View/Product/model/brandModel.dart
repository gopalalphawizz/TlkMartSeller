class BrandModel {
  BrandModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<BrandData> data;

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<BrandData>.from(
              json["data"]!.map((x) => BrandData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class BrandData {
  BrandData({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.translations,
  });

  final int? id;
  final String? name;
  final String? image;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<dynamic> translations;

  factory BrandData.fromJson(Map<String, dynamic> json) {
    return BrandData(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      translations: json["translations"] == null
          ? []
          : List<dynamic>.from(json["translations"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "translations": translations.map((x) => x).toList(),
      };
}
