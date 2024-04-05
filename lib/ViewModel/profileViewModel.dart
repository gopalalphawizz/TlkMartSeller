import 'dart:convert';

import 'package:alpha_work/Model/staticPageModel.dart';
import 'package:alpha_work/Model/vendorProfileModel.dart';
import 'package:alpha_work/Utils/appUrls.dart';
import 'package:alpha_work/Utils/shared_pref..dart';
import 'package:alpha_work/Utils/utils.dart';
import 'package:alpha_work/View/AUTH/LOGIN/loginpage.dart';
import 'package:alpha_work/View/Dashboard/RatingnReview/ratingNreviewModel.dart';
import 'package:alpha_work/View/Dashboard/RatingnReview/reviewDetailModel.dart';
import 'package:alpha_work/View/Profile/Advertising/model/adListModel.dart';
import 'package:alpha_work/View/Profile/Advertising/model/advertModel.dart';
import 'package:alpha_work/View/Profile/referEarn/Model/referralModel.dart';
import 'package:alpha_work/View/Profile/subscription/model/subscriptionModel.dart';
import 'package:alpha_work/View/Profile/support/model/customerSupportModel.dart';
import 'package:alpha_work/View/Profile/support/model/supportChatModel.dart';
import 'package:alpha_work/main.dart';
import 'package:alpha_work/repository/profileRepository.dart';
import 'package:flutter/material.dart';

class ProfileViewModel with ChangeNotifier {
  ProfileRepository _myRepo = ProfileRepository();
  late VendorData vendorData;
  late StaticPageData staticPageData;
  List<ReferralData> referrals = [];
  List<Monthly> yearly = [];
  List<Monthly> monthly = [];
  List<AdvertData> adverts = [];
  List<SupportData> queries = [];
  List<ChatData> supportChats = [];
  List<AdListData> adsRequests = [];
  late ReviewModel reviewData;
  late ReviewDetailModel reviewDetailData;
  bool isLoading = true;
  bool get loading => isLoading;
  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  //Function to get vendor profile data
  Future<void> getvendorProfileData() async {
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    String phone = PreferenceUtils.getString(PrefKeys.mobile);
    print(token);
    print(phone);
    isLoading = true;
    await _myRepo
        .vendorProfileGetRequest(
            api: AppUrl.vendorProfile, token: token, phone: phone)
        .then((value) {
         
      // print(value.data.first.fName);
      vendorData = value.data.first;
      PreferenceUtils.setString(
          PrefKeys.userDetails, jsonEncode(vendorData.toJson()));

      setLoading(false);
    }).onError((error, stackTrace) {
      print(stackTrace.toString());
      setLoading(false);
    });
  }

  //Function to update business Detail
  Future<Map<String, dynamic>> updateBusinessDetail({
    required String bussiness_email_id,
    required String bussiness_type,
    required String company_name,
    required String gst_in,
    required String bussiness_registeration_number,
    required String tax_identification_number,
  }) async {
    Map<String, dynamic> val = {'status': false, 'msg': 'Something went wrong'};
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    await _myRepo
        .updateBusinessDetail(
      api: AppUrl.updateBusinessDetail,
      token: token,
      bussiness_email_id: bussiness_email_id,
      bussiness_type: bussiness_type,
      company_name: company_name,
      gst_in: gst_in,
      bussiness_registeration_number: bussiness_registeration_number,
      tax_identification_number: tax_identification_number,
    )
        .then((value) {
      val['status'] = value['status'];
      val['msg'] = value['message'];
    });
    return val;
  }

  //Function to update Address Detail
  Future<Map<String, dynamic>> updateAddressDetail({
    required String address,
    required String country,
    required String state,
    required String city,
    required String pincode,
  }) async {
    Map<String, dynamic> val = {'status': false, 'msg': 'Something went wrong'};
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    await _myRepo
        .updateAddressDetail(
            api: AppUrl.updateAddressDetail,
            token: token,
            address: address,
            country: country,
            state: state,
            city: city,
            pincode: pincode)
        .then((value) {
      val['status'] = value['status'];
      val['msg'] = value['message'];
    });
    return val;
  }

//Function to update Bank Detail
  Future<Map<String, dynamic>> updateBankDetail({
    required String holderName,
    required String bank_name,
    required String branch_name,
    required String account_type,
    required String micr_code,
    required String bank_address,
    required String account_number,
    required String ifsc_code,
  }) async {
    Map<String, dynamic> val = {'status': false, 'msg': 'Something went wrong'};
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    await _myRepo
        .updateBankDetail(
            api: AppUrl.updateBankingDetail,
            token: token,
            holderName: holderName,
            bank_name: bank_name,
            branch_name: branch_name,
            account_type: account_type,
            micr_code: micr_code,
            bank_address: bank_address,
            account_number: account_number,
            ifsc_code: ifsc_code)
        .then((value) {
      val['status'] = value['status'];
      val['msg'] = value['message'];
    });
    return val;
  }

//Function to update Bank Detail
  Future<Map<String, dynamic>> updateProfileDetail({
    required String name,
    required String email,
    required String phone,
    required String imageUrl,
    required bool isFromFile,
  }) async {
    Map<String, dynamic> val = {'status': false, 'msg': 'Something went wrong'};
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    await _myRepo
        .updateProfileDetail(
            api: AppUrl.updateProfileDetail,
            token: token,
            name: name,
            email: email,
            image: imageUrl,
            isFromFile: isFromFile,
            phone: phone)
        .then((value) {
      val['status'] = value['status'];
      val['msg'] = value['message'];
    });
    await getvendorProfileData();
    return val;
  }

//Function to fetch static page data(faq,privacy-policy etc)
  Future<void> getStaticPageData() async {
    isLoading = true;
    await _myRepo.staticPageGetRequest(api: AppUrl.staticPage).then((value) {
      staticPageData = value.data!;
      setLoading(false);
    }).onError((error, stackTrace) => setLoading(false));
  }

//Function to change password
  Future<String> cahngePassword({
    required String old_password,
    required String newPass,
    required String confirmPass,
  }) async {
    String msg = '';
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    await _myRepo
        .updateProfilePassword(
      api: AppUrl.updatePassword,
      token: token,
      old_password: old_password,
      newPass: newPass,
      confirmPass: confirmPass,
    )
        .then((value) {
      if (value) {
        msg = "Password updated sucessfully";
      } else {
        msg = "Something went wrong!";
      }
      setLoading(false);
    });
    return msg;
  }

//Function to get subscription data
  Future<void> getSubscriptions() async {
    isLoading = true;
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    monthly.clear();
    yearly.clear();
    await _myRepo
        .subscriptionPlanGetRequest(api: AppUrl.getSubscription, token: token)
        .then((value) {
      monthly = value.data.first.monthly;
      yearly = value.data.first.yearly;
      setLoading(false);
    });
  }

//Function to update Bank Detail
  Future<Map<String, dynamic>> updateStoreDetail({
    required bool isFromFile,
    required String name,
    required String email,
    required String desc,
    required String imageUrl,
    required String type,
    required String reg,
    required String gst,
    required String tax,
    required String website,
    required String social,
  }) async {
    Map<String, dynamic> val = {'status': false, 'msg': 'Something went wrong'};
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    await _myRepo
        .updateStoreDetail(
      api: AppUrl.updateStoreDetail,
      token: token,
      isFromFile: isFromFile,
      name: name,
      email: email,
      desc: desc,
      tax: tax,
      imageUrl: imageUrl,
      type: type,
      reg: reg,
      gst: gst,
      website: website,
      social: social,
    )
        .then((value) {
      val['status'] = value['status'];
      val['msg'] = value['message'];
    });
    await getvendorProfileData();
    return val;
  }

//Function to get Advert data
  Future<void> getAdvertData() async {
    isLoading = true;
    adverts.clear();
    await _myRepo.advertListGetRequest(api: AppUrl.getAdvert).then((value) {
      adverts = value.data;
      print(adverts.length);
      setLoading(false);
    }).onError((error, stackTrace) => setLoading(false));
  }

//Function to get Support Query Data
  Future<void> getSupportQuerys() async {
    isLoading = true;
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    print(token);
    queries.clear();
    await _myRepo
        .supportQueryListGetRequest(api: AppUrl.getSupportQueries, token: token)
        .then((value) {
      queries = value.data;
      print(queries.length);
      setLoading(false);
    }).onError((error, stackTrace) => setLoading(false));
  }

//Function to get Support Query Chat Data
  Future<void> getSupportQueryChats({required String TicketId}) async {
    // isLoading = true;
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    print(token);
    print(TicketId);
    await _myRepo
        .supportChatGetRequest(
            api: "${AppUrl.supportChat}$TicketId", token: token)
        .then((value) {
      if (value.status == true) {
        supportChats = value.data;
        print(supportChats.length);
        setLoading(false);
      } else {
        Utils.showTost(msg: "Something went Wrong");
      }
    }).onError((error, stackTrace) => setLoading(false));
  }

//Function to get Support Query Chat Data
  Future<void> postSupportQueryChats({
    required String TicketId,
    required String chat,
  }) async {
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    print(token);
    print(TicketId);
    await _myRepo
        .supportChatPostRequest(
            api: "${AppUrl.supportChatReply}$TicketId",
            token: token,
            chat: chat)
        .then((value) {
      getSupportQueryChats(TicketId: TicketId);
    }).onError((error, stackTrace) => setLoading(false));
  }

//Function to get referral Data
  Future<void> getReferralData() async {
    isLoading = true;
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    print(token);
    referrals.clear();
    await _myRepo
        .referralListGetRequest(api: AppUrl.referral, token: token)
        .then((value) {
      referrals = value.data;
      print(referrals.length);
      setLoading(false);
    }).onError((error, stackTrace) => setLoading(false));
  }

//Function to get referral Data
  Future<void> ratingReviewData() async {
    isLoading = true;
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);

    await _myRepo
        .ratingReviewGetRequest(api: AppUrl.ratingReview, token: token)
        .then((value) {
      reviewData = value;
      setLoading(false);
    }).onError((error, stackTrace) => setLoading(false));
  }

//Function to get review Detail Data
  Future<void> ReviewDetailData({required String product_id}) async {
    isLoading = true;
    print(product_id);
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    await _myRepo.ReviewDetailGetRequest(
            api: AppUrl.ReviewDetail, token: token, id: product_id)
        .then((value) {
      reviewDetailData = value;
      setLoading(false);
    }).onError((error, stackTrace) => setLoading(false));
  }

  Future<String> alphaSubscription(
      {required String transaction_id, required String planId}) async {
    isLoading = true;
    String msg = '';
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    await _myRepo
        .subscribeAlpha(
      api: AppUrl.purchasePlan,
      token: token,
      transaction_id: transaction_id,
      plan_id: planId,
    )
        .then((value) {
      msg = value;
      print(value.toString());
      setLoading(false);
      return msg;
    });
    return msg;
  }

//Function to buy Advert
  Future<bool> buyAdvert({
    required String adId,
    required String paymentId,
  }) async {
    isLoading = true;
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    print("Im Herekkkkkkkk");
    await _myRepo
        .buyAdvertPostRequest(
            api: AppUrl.buyAdvert,
            token: token,
            adId: adId,
            paymentId: paymentId)
        .then((value) {
      if (value['message'] == "Advertisement Purchased Success") {}
    }).onError((error, stackTrace) => setLoading(false));
    return true;
  }

  //Function to delete Vendor account
  Future<bool> deleteAccount() async {
    bool val = false;
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    await _myRepo
        .deleteAccGetRequest(api: AppUrl.DeactivateAcc, token: token)
        .then((value) {
      val = value['status'];
      Utils.showTost(msg: value['message'].toString());
    }).onError((error, stackTrace) {
      print(stackTrace);
      setLoading(false);
    });
    return val;
  }

  //Function for advertisement Confirmation
  Future<bool> UploadBanner({
    required String adId,
    required String startDate,
    required List<String> productIds,
    required String transaction_id,
    required String amount,
    required String path,
  }) async {
    bool val = false;
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    await _myRepo.BannerUploadPostRequest(
            api: AppUrl.uploadBanner,
            token: token,
            adId: adId,
            startDate: startDate,
            productIds: productIds,
            transaction_id: transaction_id,
            amount: amount,
            path: path)
        .then((value) {
      val = value['status'];
      Utils.showTost(msg: value['message'].toString());
    }).onError((error, stackTrace) {
      print(stackTrace);
      setLoading(false);
    });
    return val;
  }

//Function to get AdList Status
//Function to delete Vendor account
  Future<void> getAdsStatus() async {
    adsRequests.clear();
    isLoading = true;
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    await _myRepo.AdvertSatusGetRequest(api: AppUrl.adgetRequest, token: token)
        .then((value) {
      adsRequests = value.data;
      setLoading(false);
    }).onError((error, stackTrace) {
      print(stackTrace);
      setLoading(false);
    });
  }
}
