import 'dart:convert';
import 'dart:ffi';

import 'package:alpha_work/Model/staticPageModel.dart';
import 'package:alpha_work/Model/vendorProfileModel.dart';
import 'package:alpha_work/View/Dashboard/RatingnReview/ratingNreviewModel.dart';
import 'package:alpha_work/View/Dashboard/RatingnReview/reviewDetailModel.dart';
import 'package:alpha_work/View/Profile/Advertising/model/adListModel.dart';
import 'package:alpha_work/View/Profile/Advertising/model/advertModel.dart';
import 'package:alpha_work/View/Profile/referEarn/Model/referralModel.dart';
import 'package:alpha_work/View/Profile/subscription/model/subscriptionModel.dart';
import 'package:alpha_work/View/Profile/support/model/customerSupportModel.dart';
import 'package:alpha_work/View/Profile/support/model/supportChatModel.dart';
import 'package:http/http.dart' as http;

class ProfileRepository {
//Function to fetch vendor profile data
  Future<VendorProfileModel> vendorProfileGetRequest({
    required String api,
    required String token,
    required String phone,
  }) async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      var request = http.MultipartRequest('GET', Uri.parse(api));
      request.fields.addAll({'phone': phone});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var res = await jsonDecode(await response.stream.bytesToString());
      print(res);
      if (response.statusCode == 200) {
        return VendorProfileModel.fromJson(res);
      } else {
        print(response.reasonPhrase);
        return VendorProfileModel.fromJson(res);
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

//Function to update business details
  Future<dynamic> updateBusinessDetail({
    required String api,
    required String token,
    required String bussiness_email_id,
    required String bussiness_type,
    required String company_name,
    required String gst_in,
    required String bussiness_registeration_number,
    required String tax_identification_number,
  }) async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      var request = http.MultipartRequest('POST', Uri.parse(api));
      request.fields.addAll({
        'bussiness_email_id': bussiness_email_id,
        'bussiness_type': bussiness_type,
        'company_name': company_name,
        'gst_in': gst_in,
        'bussiness_registeration_number': bussiness_registeration_number,
        'tax_identification_number': tax_identification_number,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var res = await jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
        return res;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

//Function to update business details
  Future<dynamic> updateAddressDetail({
    required String api,
    required String token,
    required String address,
    required String country,
    required String state,
    required String city,
    required String pincode,
  }) async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      var request = http.MultipartRequest('POST', Uri.parse(api));
      request.fields.addAll({
        'address': address,
        'country': country,
        'state': state,
        'city': city,
        'pincode': pincode,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var res = await jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
        return res;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

//Function to update business details
  Future<dynamic> updateBankDetail({
    required String api,
    required String token,
    required String holderName,
    required String bank_name,
    required String branch_name,
    required String account_type,
    required String micr_code,
    required String bank_address,
    required String account_number,
    required String ifsc_code,
  }) async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      var request = http.MultipartRequest('POST', Uri.parse(api));
      request.fields.addAll({
        'bank_name': bank_name,
        'branch_name': branch_name,
        'account_type': account_type,
        'micr_code': micr_code,
        'bank_address': bank_address,
        'account_number': account_number,
        'ifsc_code': ifsc_code,
        'holder_name': holderName,
      });

      request.headers.addAll(headers);
      print(request.fields);
      http.StreamedResponse response = await request.send();
      var res = await jsonDecode(await response.stream.bytesToString());

      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
        return res;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

//Function to update user profile details
  Future<dynamic> updateProfileDetail({
    required String api,
    required String token,
    required String name,
    required String email,
    required String phone,
    required String image,
    required bool isFromFile,
  }) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest('POST', Uri.parse(api));
    request.fields.addAll({
      'name': name.toString(),
      'email': email.toString(),
      'phone': phone.toString()
    });
    if (image.isNotEmpty && isFromFile) {
      request.files.add(
          await http.MultipartFile.fromPath('image', '${image.toString()}'));
    } else {
      request.fields.addAll({'image': image.toString()});
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    var ans = jsonDecode(result);
    if (response.statusCode == 200) {
      print(ans);
      return ans;
    } else {
      print(response.statusCode);
      return ans;
    }
  }

//Function to get static pages
  Future<StaticPageModel> staticPageGetRequest({
    required String api,
  }) async {
    try {
      var url = Uri.parse(api);
      http.Response res = await http.get(url);
      var ans = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return StaticPageModel.fromJson(ans);
      } else {
        print(res.reasonPhrase);
        return StaticPageModel.fromJson(ans);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

//Function to update password
  Future<bool> updateProfilePassword({
    required String api,
    required String token,
    required String old_password,
    required String newPass,
    required String confirmPass,
  }) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest('POST', Uri.parse(api));
    request.fields.addAll({
      'old_password': old_password,
      'password': newPass,
      'password_confirmation': confirmPass
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var json = jsonDecode(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      print(json);
      return json['status'];
    } else {
      print(response.reasonPhrase);
      return json['status'];
    }
  }

//Function to get Subscription Plans
  Future<SubscriptionModel> subscriptionPlanGetRequest({
    required String api,
    required String token,
  }) async {
    try {
      var url = Uri.parse(api);
      var response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      var ans = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(ans);
        return SubscriptionModel.fromJson(ans);
      } else {
        print(response.reasonPhrase);
        return SubscriptionModel(status: false, message: '', data: []);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

//Function to update user profile details
  Future<dynamic> updateStoreDetail({
    required String api,
    required String token,
    required bool isFromFile,
    required String name,
    required String email,
    required String desc,
    required String imageUrl,
    required String type,
    required String reg,
    required String tax,
    required String gst,
    required String website,
    required String social,
  }) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest('POST', Uri.parse(api));
    request.fields.addAll({
      'bussiness_email_id': email,
      'bussiness_type': type,
      'company_name': name,
      'gst_in': gst,
      'bussiness_registeration_number': reg,
      'tax_identification_number': tax,
      'website_link': website,
      'social_link': social,
      'details': desc,
    });
    if (imageUrl.isNotEmpty && isFromFile) {
      request.files.add(
          await http.MultipartFile.fromPath('image', '${imageUrl.toString()}'));
    } else {
      request.fields.addAll({'image': imageUrl.toString()});
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    var ans = jsonDecode(result);
    if (response.statusCode == 200) {
      print(ans);
      return ans;
    } else {
      print(response.statusCode);
      return ans;
    }
  }

//Function to get Advert Data
  Future<AdvertModel> advertListGetRequest({required api}) async {
    try {
      var url = Uri.parse(api);
      var res = await http.get(url);
      var ans = jsonDecode(res.body);
      if (res.statusCode == 200) {
        print(res);
        return AdvertModel.fromJson(ans);
      } else {
        print(res.reasonPhrase);
        return AdvertModel(status: null, message: null, data: []);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

//Function to get support query Data
  Future<CustomerSupportModel> supportQueryListGetRequest(
      {required api, required String token}) async {
    try {
      var url = Uri.parse(api);
      var res =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      var ans = jsonDecode(res.body);
      print(ans);
      if (res.statusCode == 200) {
        print(res);
        return CustomerSupportModel.fromJson(ans);
      } else {
        print(res.reasonPhrase);
        return CustomerSupportModel(status: null, message: null, data: []);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

//Function to get Customer Support Chat
  Future<SupportChatModel> supportChatGetRequest({
    required String api,
    required String token,
  }) async {
    try {
      var url = Uri.parse(api);
      http.Response response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      var ans = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(ans);
        return SupportChatModel.fromJson(ans);
      } else {
        print(response.reasonPhrase);
        return SupportChatModel.fromJson(ans);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

//Function to send chat
  Future<void> supportChatPostRequest({
    required String api,
    required String token,
    required String chat,
  }) async {
    try {
      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $token'
      };
      var request = http.Request('POST', Uri.parse(api));
      request.bodyFields = {'message': chat};
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

//Function to get referral list
  Future<ReferralModel> referralListGetRequest(
      {required api, required String token}) async {
    try {
      var url = Uri.parse(api);
      var res =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      var ans = jsonDecode(res.body);
      print(ans);
      if (res.statusCode == 200) {
        print(res);
        return ReferralModel.fromJson(ans);
      } else {
        print(res.reasonPhrase);
        return ReferralModel(status: null, message: null, data: [], wallet: "");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

//Function to get rewiews
  Future<ReviewModel> ratingReviewGetRequest({
    required String token,
    required String api,
  }) async {
    try {
      var url = Uri.parse(api);

      var res =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      var ans = jsonDecode(res.body);
      if (res.statusCode == 200) {
        print(ans);
        return ReviewModel.fromJson(ans);
      } else {
        print(res.reasonPhrase);
        return ReviewModel(
            status: null,
            message: "",
            avgRating: null,
            ratingCount: null,
            products: []);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

//Function to get rewiews details
  Future<ReviewDetailModel> ReviewDetailGetRequest({
    required String token,
    required String api,
    required String id,
  }) async {
    try {
      var url = Uri.parse(api).replace(queryParameters: {'product_id': id});
      var res =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      var ans = jsonDecode(res.body);
      if (res.statusCode == 200) {
        print(ans);
        return ReviewDetailModel.fromJson(ans);
      } else {
        print(res.reasonPhrase);
        return ReviewDetailModel(
          status: null,
          message: "",
          averageRating: "",
          rating: [],
          reviews: [],
          totalReviews: 0,
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> subscribeAlpha({
    required String api,
    required String token,
    required String transaction_id,
    required String plan_id,
  }) async {
    try {
      var url = Uri.parse(api).replace(queryParameters: {
        'transaction_id': transaction_id,
        'plan_id': plan_id
      });
      var res = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      var ans = jsonDecode(res.body);
      if (res.statusCode == 200) {
        print(ans);
        return ans['message'];
      } else {
        print(res.reasonPhrase);
        return ans['message'];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

//Function to buy Advert
  Future<Map<String, String>> buyAdvertPostRequest({
    required String api,
    required String token,
    required String adId,
    required String paymentId,
  }) async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      var request = http.MultipartRequest('POST', Uri.parse(api));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var ans = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        print(ans);
        return ans;
      } else {
        print(response.reasonPhrase);
        return ans;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

//Function To delete account
  Future<Map<String, dynamic>> deleteAccGetRequest({
    required String api,
    required String token,
  }) async {
    try {
      var url = Uri.parse(api);
      http.Response res =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      var ans = jsonDecode(res.body);
      print(ans);
      if (res.statusCode == 200) {
        return ans;
      } else {
        print(res.reasonPhrase);
        return ans;
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

//Function to upload banner and payment
  Future<Map<String, dynamic>> BannerUploadPostRequest({
    required String api,
    required String token,
    required String adId,
    required String startDate,
    required List<String> productIds,
    required String transaction_id,
    required String amount,
    required String path,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(api));
      var headers = {'Authorization': 'Bearer $token'};
      request.fields.addAll({
        'ad_id': adId,
        'start_date': startDate,
        'product_ids[]': productIds.toString(),
        'transaction_id': transaction_id,
        'amount': amount,
      });
      request.files
          .add(await http.MultipartFile.fromPath('image', path.toString()));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var ans = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        print(ans);
        return ans;
      } else {
        print(ans);
        print(response.reasonPhrase);
        return ans;
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

  //Function to upload banner and payment
  Future<AdListModel> AdvertSatusGetRequest({
    required String api,
    required String token,
  }) async {
    try {
      var url = Uri.parse(api);
      http.Response response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      var ans = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(ans);
        return AdListModel.fromJson(ans);
      } else {
        print(ans);
        print(response.reasonPhrase);
        return AdListModel.fromJson(ans);
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }
}
