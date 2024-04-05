class CountryModel {
  CountryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<CountyData> data;

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<CountyData>.from(
              json["data"]!.map((x) => CountyData.fromJson(x))),
    );
  }
}

class CountyData {
  CountyData({
    required this.id,
    required this.name,
  });

  final int? id;
  final String? name;

  factory CountyData.fromJson(Map<String, dynamic> json) {
    return CountyData(
      id: json["id"],
      name: json["name"],
    );
  }
}
