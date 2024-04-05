import 'package:alpha_work/View/Dashboard/RatingnReview/ratingNreviewModel.dart';

class ReviewDetailModel {
  ReviewDetailModel({
    required this.status,
    required this.message,
    required this.averageRating,
    required this.totalReviews,
    required this.rating,
    required this.reviews,
  });

  final bool? status;
  final String? message;
  final String? averageRating;
  final int? totalReviews;
  final List<int> rating;
  final List<Review> reviews;

  factory ReviewDetailModel.fromJson(Map<String, dynamic> json) {
    return ReviewDetailModel(
      status: json["status"],
      message: json["message"],
      averageRating: json["average_rating"],
      totalReviews: json["total_reviews"],
      rating: json["rating"] == null
          ? []
          : List<int>.from(json["rating"]!.map((x) => x)),
      reviews: json["reviews"] == null
          ? []
          : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
    );
  }
}

class Review {
  Review({
    required this.id,
    required this.productId,
    required this.customerId,
    required this.deliveryManId,
    required this.orderId,
    required this.comment,
    required this.attachment,
    required this.rating,
    required this.status,
    required this.isSaved,
    required this.createdAt,
    required this.updatedAt,
    required this.customer,
  });

  final int? id;
  final int? productId;
  final int? customerId;
  final String? deliveryManId;
  final String? orderId;
  final String? comment;
  final List<dynamic> attachment;
  final int? rating;
  final int? status;
  final int? isSaved;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Customer? customer;

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json["id"],
      productId: json["product_id"],
      customerId: json["customer_id"],
      deliveryManId: json["delivery_man_id"],
      orderId: json["order_id"],
      comment: json["comment"],
      attachment: json["attachment"] == null
          ? []
          : List<dynamic>.from(json["attachment"]!.map((x) => x)),
      rating: json["rating"],
      status: json["status"],
      isSaved: json["is_saved"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      customer:
          json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    );
  }
}
