// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:math';

import 'package:alpha_work/Utils/appUrls.dart';
import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/shared_pref..dart';
import 'package:alpha_work/Utils/utils.dart';
import 'package:alpha_work/View/AUTH/LOGIN/model/OtpModel.dart';
import 'package:alpha_work/View/AUTH/LOGIN/otpfind.dart';

import 'package:alpha_work/View/Dashboard/Dashboad.dart';
import 'package:alpha_work/repository/authRepository.dart';
import 'package:crypto/crypto.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  String? mobileNumber, password;
  String? name, countryCode, signUpPassword, signUpEmail;
  String? newPassword;

  bool? error;
  String errorMessage = '';

  bool isLoading = false;

  bool get loading => isLoading;

  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  bool isLoggingViaPhone = true;

  bool get loggingViaPhone => isLoggingViaPhone;

  setLoggingViaPhone(bool value) {
    isLoggingViaPhone = value;
    notifyListeners();
  }

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  final Random _rnd = Random();
  int count = 1;
  get mobileNumberValue => mobileNumber;

  setMobileNumber(String? value) {
    mobileNumber = value;
    notifyListeners();
  }

  setNewPassword(String? value) {
    newPassword = value;
    notifyListeners();
  }

  setSignUp(String? value) {
    signUpEmail = value;
    notifyListeners();
  }

  setSignUpPassword(String? value) {
    signUpPassword = value;
    notifyListeners();
  }

  setCountryCode(String? value) {
    countryCode = value;
    notifyListeners();
  }

  setUserName(String? value) {
    name = value;
    notifyListeners();
  }

  setPassword(String? value) {
    password = value;
    notifyListeners();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  String getRandomString(int length) => String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => _chars.codeUnitAt(
            _rnd.nextInt(
              _chars.length,
            ),
          ),
        ),
      );

//Function to login with phone
  Future<bool> loginwithPhone({
    required String phone,
    required BuildContext context,
    required bool isPass,
    required bool resend,
  }) async {
    bool val = false;
    String FcmToken = PreferenceUtils.getString("FCMTOKEN");
    await _myRepo
        .loginOtpPostRequest(
            api: AppUrl.loginOtp, phone: phone, FCMToken: FcmToken)
        .then((value) async {
      setLoading(false);
      print(value.token);
      print(value.otp);
      if (value.status!) {
        Utils.showTost(msg: value.message.toString());
        val = true;
        PreferenceUtils.setString(PrefKeys.otp, value.otp.toString());
        PreferenceUtils.setString(PrefKeys.jwtToken, value.token.toString());
        PreferenceUtils.setString(PrefKeys.mobile, phone.toString());
        if (resend) {
          Navigator.push(
              context,
              PageTransition(
                child: OtpCheckPage(isPass: isPass),
                type: PageTransitionType.rightToLeft,
              ));
        }
      } else {
        Utils.showTost(msg: value.message.toString());
      }
    });
    return val;
  }

//Function to login with phone
  Future<bool> getRegistrarionOtp({
    required String phone,
  }) async {
    bool val = false;
    await _myRepo
        .registerOtpPostRequest(api: AppUrl.registerOtp, phone: phone)
        .then((value) async {
      setLoading(false);
      print(value.token);
      print(value.otp);
      if (value.status!) {
        Utils.showTost(msg: value.message.toString());
        val = true;
        PreferenceUtils.setString(PrefKeys.otp, value.otp.toString());
        PreferenceUtils.setString(PrefKeys.jwtToken, value.token.toString());
        PreferenceUtils.setString(PrefKeys.mobile, phone.toString());
      } else {
        Utils.showTost(msg: value.errors[0]['message'].toString());
      }
    });
    return val;
  }

//Function to register vendor
  Future<LoginOtpModel> registerUser({
    required String phone,
    required String otp,
    required String name,
    required String email,
    required String referalcode,
    required String businessemail,
    required String businessphoneNo,
    required String businessname,
    required String businessType,
    required String registrationNo,
    required String gstin,
    required String tin,
    required String website,
    required String password,
    required String confirmPass,
    required String addr,
    required String city,
    required String state,
    required String zip,
    required String country,
    required String bankName,
    required String branch,
    required String accType,
    required String micr,
    required String bankAddr,
    required String accNo,
    required String ifsc,
    required String AccHolderName,
  }) async {
    LoginOtpModel val = LoginOtpModel(
        status: false,
        message: "Something Went wrong! Please try again",
        token: null,
        errors: [],
        data: [],
        otp: otp);
    await _myRepo
        .registerVendorPostRequest(
      api: AppUrl.register,
      phone: phone,
      otp: otp,
      name: name,
      email: email,
      referalcode: referalcode,
      businessemail: businessemail,
      businessphoneNo: businessphoneNo,
      businessname: businessname,
      businessType: businessType,
      registrationNo: registrationNo,
      gstin: gstin,
      tin: tin,
      website: website,
      password: password,
      confirmPass: confirmPass,
      addr: addr,
      city: city,
      state: state,
      zip: zip,
      country: country,
      AccHolderName: AccHolderName,
      bankName: bankName,
      branch: branch,
      accType: accType,
      micr: micr,
      bankAddr: bankAddr,
      accNo: accNo,
      ifsc: ifsc,
    )
        .then((value) {
      val = value;
      setLoading(false);
    }).onError((error, stackTrace) => setLoading(false));
    return val;
  }

//Function to login with email
  Future<void> loginwithEmail({
    required String email,
    required BuildContext context,
    required String pass,
  }) async {
    String FcmToken = PreferenceUtils.getString("FCMTOKEN");
    await _myRepo
        .loginEmailPostRequest(
            api: AppUrl.loginWithEmailPassword,
            email: email,
            pass: pass,
            FCMToken: FcmToken)
        .then((value) {
      if (value.errors.isNotEmpty) {
        Utils.showTost(msg: value.errors[0]["message"]);
      }
      if (value.status == true) {
        PreferenceUtils.setString(PrefKeys.jwtToken, value.token.toString());
        PreferenceUtils.setString(PrefKeys.isLoggedIn, "true");
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DashboardScreen1(),
        ));
      }
    });
  }

//Function to get forgot pass otp
  Future<bool> forgetPassOtp({
    required String phone,
    required BuildContext context,
    required bool isPass,
    required bool resend,
  }) async {
    bool val = false;
    await _myRepo
        .forgotPassOtpPostRequest(api: AppUrl.forgetPassOtp, phone: phone)
        .then((value) async {
      setLoading(false);
      print(value.token);
      print(value.otp);
      if (value.status!) {
        Utils.showTost(msg: value.message.toString());
        val = true;
        PreferenceUtils.setString(PrefKeys.otp, value.otp.toString());
        PreferenceUtils.setString(PrefKeys.mobile, phone.toString());
        if (resend) {
          Navigator.push(
              context,
              PageTransition(
                child: OtpCheckPage(isPass: isPass),
                type: PageTransitionType.rightToLeft,
              ));
        }
      } else {
        Utils.showTost(msg: value.message.toString());
      }
    });
    return val;
  }

//Function to Reset Password
  Future<bool> ResetPassword({
    required String phone,
    required String otp,
    required String password,
    required String confirm_password,
  }) async {
    bool val = false;
    await _myRepo.ResetPasswordPutRequest(
            api: AppUrl.ResetPassword,
            identity: phone,
            otp: otp,
            password: password,
            confirm_password: confirm_password)
        .then((value) async {
      await Utils.showTost(msg: value['message'].toString());
      val = value['status'] == true ? true : false;
    }).onError((error, stackTrace) {
      print(stackTrace);
    });
    return val;
  }
}
