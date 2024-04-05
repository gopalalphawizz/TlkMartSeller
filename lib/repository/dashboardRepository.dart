import 'dart:convert';

import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/utils.dart';
import 'package:alpha_work/View/Dashboard/TotalOrder/model/orederReportModel.dart';
import 'package:alpha_work/View/Dashboard/model/dashboardServiceModel.dart';
import 'package:alpha_work/View/Dashboard/notification/model/notificationModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class DashboardRepository {
  Future<DashboardServiceModel> getDashboardDataRequest(
      {required String api, required String token}) async {
    try {
      final url = Uri.parse(api);
      final http.Response res = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });
      print(res.statusCode);
      print(url);
      if (res.statusCode == 200) {
        var jsonData = jsonDecode(res.body);
        print(jsonData);
        return DashboardServiceModel.fromJson(jsonData);
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: colors.buttonColor,
            textColor: Colors.white,
            fontSize: 16.0);
        return DashboardServiceModel(status: null, message: null, data: null);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<NotificationModel> NotificatonGetRequest(
      {required String api, required String token}) async {
    try {
      final url = Uri.parse(api);
      final http.Response res = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });
      print(res.statusCode);
      print(url);
      if (res.statusCode == 200) {
        var jsonData = jsonDecode(res.body);
        print(jsonData);
        return NotificationModel.fromJson(jsonData);
      } else {
        Utils.showTost(msg: "Something went wrong!");
        return NotificationModel(status: null, message: null, data: []);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

//Function to get Order Report
  Future<OrderReportModel> OrderReportGetRequest({
    required String api,
    required String token,
  }) async {
    try {
      var url = Uri.parse(api);
      http.Response res = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });
      var ans = jsonDecode(res.body);
      print(ans);
      if (res.statusCode == 200) {
        return OrderReportModel.fromJson(ans);
      } else {
        print(res.reasonPhrase);
        return OrderReportModel.fromJson(ans);
      }
    } catch (e, ST) {
      print(ST);
      throw Exception(e);
    }
  }
}
