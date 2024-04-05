class DashboardServiceModel {
  DashboardServiceModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final DashData? data;

  factory DashboardServiceModel.fromJson(Map<String, dynamic> json) {
    return DashboardServiceModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : DashData.fromJson(json["data"]),
    );
  }
}

class DashData {
  DashData({
    required this.totalSale,
    required this.soldOut,
    required this.totalProduct,
    required this.totalOrders,
    required this.totalCustomers,
    required this.stockManagement,
    required this.totalDelivery,
    required this.ratingsNdReviews,
    required this.graphData,
    required this.categoryProduct,
    required this.today,
    required this.week,
    required this.month,
    required this.notification,
  });

  final String? totalSale;
  final String? soldOut;
  final String? totalProduct;
  final String? totalOrders;
  final String? totalCustomers;
  final String? stockManagement;
  final String? totalDelivery;
  final String? ratingsNdReviews;
  final GraphData? graphData;
  final CategoryProduct? categoryProduct;
  final String? today;
  final String? week;
  final String? month;
  final String? notification;

  factory DashData.fromJson(Map<String, dynamic> json) {
    return DashData(
      totalSale: json["total_sale"],
      soldOut: json["sold_out"],
      totalProduct: json["total_product"],
      totalOrders: json["total_orders"],
      totalCustomers: json["total_customers"],
      stockManagement: json["stock_management"],
      totalDelivery: json["total_delivery"],
      ratingsNdReviews: json["ratings_nd_reviews"],
      graphData: json["graph_data"] == null
          ? null
          : GraphData.fromJson(json["graph_data"]),
      categoryProduct: json["category_product"] == null
          ? null
          : CategoryProduct.fromJson(json["category_product"]),
      today: json["today"],
      week: json["week"],
      month: json["month"],
      notification: json["notification"],
    );
  }
}

class CategoryProduct {
  CategoryProduct({
    required this.categoryLabel,
    required this.categoryProducts,
  });

  final List<String> categoryLabel;
  final List<String> categoryProducts;

  factory CategoryProduct.fromJson(Map<String, dynamic> json) {
    return CategoryProduct(
      categoryLabel: json["category_label"] == null
          ? []
          : List<String>.from(json["category_label"]!.map((x) => x)),
      categoryProducts: json["category_products"] == null
          ? []
          : List<String>.from(json["category_products"]!.map((x) => x)),
    );
  }
}

class GraphData {
  GraphData({
    required this.sellerLabel,
    required this.sellerEarn,
  });

  final List<String> sellerLabel;
  final List<dynamic> sellerEarn;

  factory GraphData.fromJson(Map<String, dynamic> json) {
    return GraphData(
      sellerLabel: json["seller_label"] == null
          ? []
          : List<String>.from(json["seller_label"]!.map((x) => x)),
      sellerEarn: json["seller_earn"] == null
          ? []
          : List<dynamic>.from(json["seller_earn"]!.map((x) => x)),
    );
  }
}
