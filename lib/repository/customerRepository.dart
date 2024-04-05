import 'dart:convert';

import 'package:alpha_work/View/Customer/Model/customerModel.dart';
import 'package:http/http.dart' as http;

class CustomerRepository {
  //Function to get Customer list
  Future<CustomerModel> customerListGetRequest({
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
        return CustomerModel.fromJson(ans);
      } else {
        print(res.reasonPhrase);
        return CustomerModel(status: null, message: "", data: [], errors: []);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
