class CategoryModel {
  CategoryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<CategoryData> data;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<CategoryData>.from(
              json["data"]!.map((x) => CategoryData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class CategoryData {
  CategoryData({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.parentId,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
    required this.homeStatus,
    required this.priority,
    required this.translations,
  });

  final int? id;
  final String? name;
  final String? slug;
  final String? icon;
  final int? parentId;
  final int? position;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? homeStatus;
  final int? priority;
  final List<dynamic> translations;

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
      icon: json["icon"],
      parentId: json["parent_id"],
      position: json["position"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      homeStatus: json["home_status"],
      priority: json["priority"],
      translations: json["translations"] == null
          ? []
          : List<dynamic>.from(json["translations"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "icon": icon,
        "parent_id": parentId,
        "position": position,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "home_status": homeStatus,
        "priority": priority,
        "translations": translations.map((x) => x).toList(),
      };
}
