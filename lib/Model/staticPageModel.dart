class StaticPageModel {
  StaticPageModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final StaticPageData? data;

  factory StaticPageModel.fromJson(Map<String, dynamic> json) {
    return StaticPageModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : StaticPageData.fromJson(json["data"]),
    );
  }
}

class StaticPageData {
  StaticPageData({
    required this.aboutUs,
    required this.privacyPolicy,
    required this.faq,
    required this.termsNConditions,
    required this.refundPolicy,
    required this.returnPolicy,
    required this.cancellationPolicy,
    required this.shippingDeliveryPolicy,
    required this.securityPolicyPolicy,
    required this.paymentPolicy,
    required this.contactUs,
  });

  final String? aboutUs;
  final CancellationPolicy? privacyPolicy;
  final List<Faq> faq;
  final CancellationPolicy? termsNConditions;
  final CancellationPolicy? refundPolicy;
  final CancellationPolicy? returnPolicy;
  final CancellationPolicy? cancellationPolicy;
  final CancellationPolicy? shippingDeliveryPolicy;
  final CancellationPolicy? securityPolicyPolicy;
  final CancellationPolicy? paymentPolicy;
  final CancellationPolicy? contactUs;

  factory StaticPageData.fromJson(Map<String, dynamic> json) {
    return StaticPageData(
      aboutUs: json["about_us"],
      privacyPolicy: json["privacy_policy"] == null
          ? null
          : CancellationPolicy.fromJson(json["privacy_policy"]),
      faq: json["faq"] == null
          ? []
          : List<Faq>.from(json["faq"]!.map((x) => Faq.fromJson(x))),
      termsNConditions: json["terms_n_conditions"] == null
          ? null
          : CancellationPolicy.fromJson(json["terms_n_conditions"]),
      refundPolicy: json["refund_policy"] == null
          ? null
          : CancellationPolicy.fromJson(json["refund_policy"]),
      returnPolicy: json["return_policy"] == null
          ? null
          : CancellationPolicy.fromJson(json["return_policy"]),
      cancellationPolicy: json["cancellation_policy"] == null
          ? null
          : CancellationPolicy.fromJson(json["cancellation_policy"]),
      shippingDeliveryPolicy: json["shipping_delivery_policy"] == null
          ? null
          : CancellationPolicy.fromJson(json["shipping_delivery_policy"]),
      securityPolicyPolicy: json["security_policy_policy"] == null
          ? null
          : CancellationPolicy.fromJson(json["security_policy_policy"]),
      paymentPolicy: json["payment_policy"] == null
          ? null
          : CancellationPolicy.fromJson(json["payment_policy"]),
      contactUs: json["contact_us"] == null
          ? null
          : CancellationPolicy.fromJson(json["contact_us"]),
    );
  }
}

class CancellationPolicy {
  CancellationPolicy({
    required this.status,
    required this.content,
  });

  final int? status;
  final String? content;

  factory CancellationPolicy.fromJson(Map<String, dynamic> json) {
    return CancellationPolicy(
      status: json["status"],
      content: json["content"],
    );
  }
}

class Faq {
  Faq({
    required this.id,
    required this.question,
    required this.answer,
    required this.ranking,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? question;
  final String? answer;
  final int? ranking;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Faq.fromJson(Map<String, dynamic> json) {
    return Faq(
      id: json["id"],
      question: json["question"],
      answer: json["answer"],
      ranking: json["ranking"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
