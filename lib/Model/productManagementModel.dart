class ProductManagementModel {
  ProductManagementModel({
    required this.status,
    required this.message,
    required this.data,
    required this.sellerId,
  });

  final bool? status;
  final String? message;
  final ManagementData? data;
  final int? sellerId;

  factory ProductManagementModel.fromJson(Map<String, dynamic> json) {
    return ProductManagementModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : ManagementData.fromJson(json["data"]),
      sellerId: json["seller_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
        "seller_id": sellerId,
      };
}

class ManagementData {
  ManagementData({
    required this.totalProduct,
    required this.activeProduct,
    required this.inactiveProduct,
    required this.categories,
  });

  final int? totalProduct;
  final int? activeProduct;
  final int? inactiveProduct;
  final List<Category> categories;

  factory ManagementData.fromJson(Map<String, dynamic> json) {
    return ManagementData(
      totalProduct: json["total_product"],
      activeProduct: json["active_product"],
      inactiveProduct: json["inactive_product"],
      categories: json["categories"] == null
          ? []
          : List<Category>.from(
              json["categories"]!.map((x) => Category.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "total_product": totalProduct,
        "active_product": activeProduct,
        "inactive_product": inactiveProduct,
        "categories": categories.map((x) => x?.toJson()).toList(),
      };
}

class Category {
  Category({
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
    required this.childes,
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
  final List<Category> childes;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
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
      childes: json["childes"] == null
          ? []
          : List<Category>.from(
              json["childes"]!.map((x) => Category.fromJson(x))),
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
        "childes": childes.map((x) => x?.toJson()).toList(),
      };
}
