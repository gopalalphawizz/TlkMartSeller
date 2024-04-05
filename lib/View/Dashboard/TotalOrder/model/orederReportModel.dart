class OrderReportModel {
  OrderReportModel({
    required this.status,
    required this.message,
    required this.allStatus,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<AllStatus> allStatus;
  final Data? data;

  factory OrderReportModel.fromJson(Map<String, dynamic> json) {
    return OrderReportModel(
      status: json["status"],
      message: json["message"],
      allStatus: json["all_status"] == null
          ? []
          : List<AllStatus>.from(
              json["all_status"]!.map((x) => AllStatus.fromJson(x))),
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class AllStatus {
  AllStatus({
    required this.value,
    required this.title,
    required this.count,
  });

  final String? value;
  final String? title;
  final String? count;

  factory AllStatus.fromJson(Map<String, dynamic> json) {
    return AllStatus(
      value: json["value"],
      title: json["title"],
      count: json["count"],
    );
  }
}

class Data {
  Data({
    required this.today,
    required this.week,
    required this.month,
  });

  final String? today;
  final String? week;
  final String? month;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      today: json["today"],
      week: json["week"],
      month: json["month"],
    );
  }
}
