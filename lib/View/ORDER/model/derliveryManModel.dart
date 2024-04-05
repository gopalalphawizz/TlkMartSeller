class DeliveryManModel {
  DeliveryManModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<DeliveryManData> data;

  factory DeliveryManModel.fromJson(Map<String, dynamic> json) {
    return DeliveryManModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<DeliveryManData>.from(
              json["data"]!.map((x) => DeliveryManData.fromJson(x))),
    );
  }
}

class DeliveryManData {
  DeliveryManData({
    required this.id,
    required this.sellerId,
    required this.fName,
    required this.lName,
    required this.address,
    required this.countryCode,
    required this.phone,
    required this.email,
    required this.identityNumber,
    required this.identityType,
    required this.identityImage,
    required this.image,
    required this.bankName,
    required this.branch,
    required this.accountNo,
    required this.holderName,
    required this.accountType,
    required this.micrCode,
    required this.bankAddress,
    required this.ifscCode,
    required this.isActive,
    required this.isOnline,
    required this.createdAt,
    required this.updatedAt,
    required this.fcmToken,
    required this.vehicleType,
    required this.registerationNumber,
    required this.issueDate,
    required this.expirationDate,
    required this.policyNumber,
    required this.coverageDate,
    required this.vehicleImage,
    required this.licenseNumber,
    required this.licenseDoi,
    required this.licenseExpDate,
    required this.licenseState,
    required this.licenseImage,
    required this.city,
    required this.state,
    required this.pincode,
    required this.country,
    required this.amount,
  });

  final int? id;
  final int? sellerId;
  final String? fName;
  final String? lName;
  final String? address;
  final String? countryCode;
  final String? phone;
  final String? email;
  final String? identityNumber;
  final String? identityType;
  final String? identityImage;
  final String? image;
  final String? bankName;
  final String? branch;
  final String? accountNo;
  final dynamic holderName;
  final String? accountType;
  final String? micrCode;
  final String? bankAddress;
  final String? ifscCode;
  final int? isActive;
  final int? isOnline;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? fcmToken;
  final String? vehicleType;
  final String? registerationNumber;
  final String? issueDate;
  final String? expirationDate;
  final String? policyNumber;
  final String? coverageDate;
  final String? vehicleImage;
  final String? licenseNumber;
  final String? licenseDoi;
  final String? licenseExpDate;
  final String? licenseState;
  final String? licenseImage;
  final String? city;
  final String? state;
  final String? pincode;
  final String? country;
  final String? amount;

  factory DeliveryManData.fromJson(Map<String, dynamic> json) {
    return DeliveryManData(
      id: json["id"],
      sellerId: json["seller_id"],
      fName: json["f_name"],
      lName: json["l_name"],
      address: json["address"],
      countryCode: json["country_code"],
      phone: json["phone"],
      email: json["email"],
      identityNumber: json["identity_number"],
      identityType: json["identity_type"],
      identityImage: json["identity_image"],
      image: json["image"],
      bankName: json["bank_name"],
      branch: json["branch"],
      accountNo: json["account_no"],
      holderName: json["holder_name"],
      accountType: json["account_type"],
      micrCode: json["micr_code"],
      bankAddress: json["bank_address"],
      ifscCode: json["ifsc_code"],
      isActive: json["is_active"],
      isOnline: json["is_online"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      fcmToken: json["fcm_token"],
      vehicleType: json["vehicle_type"],
      registerationNumber: json["registeration_number"],
      issueDate: json["issue_date"],
      expirationDate: json["expiration_date"],
      policyNumber: json["policy_number"],
      coverageDate: json["coverage_date"],
      vehicleImage: json["vehicle_image"],
      licenseNumber: json["license_number"],
      licenseDoi: json["license_doi"],
      licenseExpDate: json["license_exp_date"],
      licenseState: json["license_state"],
      licenseImage: json["license_image"],
      city: json["city"],
      state: json["state"],
      pincode: json["pincode"],
      country: json["country"],
      amount: json["amount"],
    );
  }
}
