import 'dart:convert';
import 'dart:developer';

import 'package:alpha_work/View/Payment/model/orderTransactions.dart';
import 'package:alpha_work/View/Wallet/model/transactionModel.dart';
import 'package:http/http.dart' as http;

class WalletRepository {
  //Future void Withdraw Request
  Future<String> withdrawMoneyPostRequest({
    required String api,
    required String token,
    required String amount,
  }) async {
    try {
      var url = Uri.parse(api).replace(queryParameters: {'amount': amount});
      print("${api}  $amount");
      var res = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      var ans = jsonDecode(res.body);
      print(ans);
      if (res.statusCode == 200) {
        print(ans);
        return ans['message'];
      } else {
        print(res.reasonPhrase);
        return ans['message'];
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

  //Function to get transaction history
  Future<TransactionModel> transactionGetRequest({
    required String api,
    required String token,
  }) async {
    try {
      var url = Uri.parse(api);
      final http.Response res = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });
      var ans = jsonDecode(res.body);
      log(ans.toString());
      if (res.statusCode == 200) {
        return TransactionModel.fromJson(ans);
      } else {
        print(res.reasonPhrase);
        return TransactionModel(
            status: null, message: null, withdrawalAmount: "", data: []);
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

  //Function to get transaction history
  Future<OrderTransactionModel> orderTransactionGetRequest({
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
        return OrderTransactionModel.fromJson(ans);
      } else {
        print(res.reasonPhrase);
        return OrderTransactionModel(
            status: null, message: null, data: [], totalOrderTransaction: null);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
