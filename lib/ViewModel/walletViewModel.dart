import 'package:alpha_work/Utils/appUrls.dart';
import 'package:alpha_work/Utils/shared_pref..dart';
import 'package:alpha_work/View/Payment/model/orderTransactions.dart';
import 'package:alpha_work/View/Wallet/model/transactionModel.dart';
import 'package:alpha_work/repository/walletRepository.dart';
import 'package:flutter/material.dart';

class WalletViewMaodel with ChangeNotifier {
  WalletRepository _myRepo = WalletRepository();
  TransactionModel? transaction;
  OrderTransactionModel? orderTransactions;
  bool isLoading = true;
  bool get loading => isLoading;
  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

//Function to post withdraw request
  Future<String> withdrawMoney({required String amount}) async {
    isLoading = true;
    String msg = '';
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    await _myRepo
        .withdrawMoneyPostRequest(
      api: AppUrl.withdrawRequest,
      token: token,
      amount: amount,
    )
        .then((value) {
      msg = value;
      setLoading(false);
      return msg;
    });
    return msg;
  }

//Function to get transaction history
  Future<void> transactionList() async {
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    isLoading = true;
    await _myRepo
        .transactionGetRequest(api: AppUrl.transactions, token: token)
        .then((value) {
      transaction = value;
      // print(transaction!.withdrawalAmount.toString());
      setLoading(false);
    }).onError((error, stackTrace) => setLoading(false));
  }

//Function to get transaction history
  Future<void> orderTransactionList() async {
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    isLoading = true;

    await _myRepo
        .orderTransactionGetRequest(api: AppUrl.Ordertransactions, token: token)
        .then((value) {
      orderTransactions = value;
      print(orderTransactions!.data.length);
      setLoading(false);
    }).onError((error, stackTrace) => setLoading(false));
  }
}
