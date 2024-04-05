class OrderTransactionModel {
  OrderTransactionModel({
    required this.status,
    required this.message,
    required this.data,
    required this.totalOrderTransaction,
  });

  final bool? status;
  final String? message;
  final String? totalOrderTransaction;
  final List<OrderTransaction> data;

  factory OrderTransactionModel.fromJson(Map<String, dynamic> json) {
    return OrderTransactionModel(
      status: json["status"],
      message: json["message"],
      totalOrderTransaction: json['total_order_amount'],
      data: json["data"] == null
          ? []
          : List<OrderTransaction>.from(
              json["data"]!.map((x) => OrderTransaction.fromJson(x))),
    );
  }
}

class OrderTransaction {
  OrderTransaction({
    required this.orderId,
    required this.amount,
    required this.createdAt,
    required this.paymentMethod,
  });

  final int? orderId;
  final String? amount;
  final String? createdAt;
  final String? paymentMethod;

  factory OrderTransaction.fromJson(Map<String, dynamic> json) {
    return OrderTransaction(
      orderId: json["order_id"],
      amount: json["amount"],
      createdAt: json["created_at"],
      paymentMethod: json["payment_method"],
    );
  }
}
