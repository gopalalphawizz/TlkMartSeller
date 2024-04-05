import 'package:alpha_work/Utils/appUrls.dart';
import 'package:alpha_work/Utils/shared_pref..dart';
import 'package:alpha_work/View/Customer/Model/customerModel.dart';
import 'package:alpha_work/repository/customerRepository.dart';
import 'package:flutter/material.dart';

class CustomerViewModel with ChangeNotifier {
  CustomerRepository _myRepo = CustomerRepository();
  List<CustomerData> customers = [];
  bool isLoading = true;
  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  //Function to get Customer list
  Future<void> getCustomerList() async {
    isLoading = true;
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    await _myRepo
        .customerListGetRequest(api: AppUrl.Customers, token: token)
        .then((value) {
      customers.clear();
      customers = value.data;
      print(customers.length);
      setLoading(false);
    }).onError((error, stackTrace) => setLoading(false));
  }
}
