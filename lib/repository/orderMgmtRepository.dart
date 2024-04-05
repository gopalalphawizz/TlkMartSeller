import 'dart:convert';

import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/View/ORDER/model/derliveryManModel.dart';
import 'package:alpha_work/View/ORDER/model/orderModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class OrderManagementRepository {
  Future<OrderModel> orderListGetRequest(
      {required String api,
      required String token,
      required String status}) async {
    try {
      final url = Uri.parse(api).replace(queryParameters: {'status': status});
      print(status);
      print(url);
      final http.Response res = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });
      print(res.statusCode);
      print(url);
      var jsonData = jsonDecode(res.body);
      print(jsonData);
      if (res.statusCode == 200) {
        print(res.body);

        return OrderModel.fromJson(jsonData);
      } else {
        print(res.body);
        return OrderModel.fromJson(jsonData);
      }
    } catch (e, stackTrace) {
      print(stackTrace.toString());
      throw Exception(e);
    }
  }

//Function to get DeliveryMan List
  Future<DeliveryManModel> DeliveryManListGetRequest({
    required String api,
    required String token,
  }) async {
    try {
      var url = Uri.parse(api);
      final http.Response res = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });
      var ans = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return DeliveryManModel.fromJson(ans);
      } else {
        print(res.reasonPhrase);
        return DeliveryManModel(status: null, message: "", data: []);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

//Function to assign driver
  Future<Map<String, dynamic>> assignDeliveryManPostRequest({
    required String token,
    required String api,
    required String delivery_man_id,
    required String order_id,
    required String expected_delivery_date,
  }) async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      var url = Uri.parse(api);
      print(api);
      print(token);
      var body = {
        'delivery_man_id': delivery_man_id,
        'order_id': order_id,
        'expected_delivery_date': expected_delivery_date,
      };
      final http.Response response;
      response = await http.put(url, headers: headers, body: body);
      var ans = jsonDecode(response.body);
      print(ans);
      print(response.statusCode);
      if (response.statusCode == 200 && ans['status'] == true) {
        return ans;
      } else {
        return ans;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

//Function to update order status
  Future<Map<String, dynamic>> orderStatusUpatePutRequest({
    required String api,
    required String token,
    required String status,
  }) async {
    try {
      print(token);
      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $token'
      };
      var request = http.Request('PUT', Uri.parse(api));
      request.bodyFields = {'order_status': status};
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var ans = jsonDecode(await response.stream.bytesToString());
      print(ans);
      if (response.statusCode == 200) {
        return ans;
      } else {
        print(response.reasonPhrase);
        return ans;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
