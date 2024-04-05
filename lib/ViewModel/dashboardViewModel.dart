import 'package:alpha_work/Utils/appUrls.dart';
import 'package:alpha_work/Utils/shared_pref..dart';
import 'package:alpha_work/View/Dashboard/Dashboad.dart';
import 'package:alpha_work/View/Dashboard/TotalOrder/model/orederReportModel.dart';
import 'package:alpha_work/View/Dashboard/model/dashboardServiceModel.dart';
import 'package:alpha_work/View/Dashboard/notification/model/notificationModel.dart';
import 'package:alpha_work/repository/dashboardRepository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DashboardViewModel with ChangeNotifier {
  final _myRepo = DashboardRepository();
  bool isLoading = true;
  late DashData dashData;

  List<ChartData> chartData = [];
  List<ChartData> circleData = [];
  List<CategoryProduct> pieData = [];
  List<NotificationData> notifications = [];
  OrderReportModel? orderReport;
  bool get loading => isLoading;
  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  //Function to fetch dashboard data
  Future<void> getDashboardData(String type) async {
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    print(token);
    chartData.clear();
    circleData.clear();
    pieData.clear();
    await _myRepo
        .getDashboardDataRequest(
            api: AppUrl.dashboardData + "?type=" + type, token: token)
        .then((value) {
      print(value.data!.totalSale);
      dashData = value.data!;
      try {
        for (var i = 0;
            i < dashData.categoryProduct!.categoryLabel.length;
            i++) {
          circleData.add(ChartData(dashData.categoryProduct!.categoryLabel[i],
              double.parse(dashData.categoryProduct!.categoryProducts[i])));
        }

        print(circleData.length);
      } catch (stacktrace, error) {
        print(stacktrace.toString() + "CIRCLE ERROR");
        print(error.toString() + "CIRCLE ERROR s");
      }
      for (int i = 0; i < dashData.graphData!.sellerLabel.length; i++) {
        chartData.add(ChartData(dashData.graphData!.sellerLabel[i],
            double.parse(dashData.graphData!.sellerEarn[i])));
      }

      // print("chart Data ${chartData.toString()}");

      setLoading(false);
    }).onError((error, stackTrace) => setLoading(false));
  }

  Future<void> getNotification() async {
    isLoading = true;
    notifications.clear();
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    await _myRepo.NotificatonGetRequest(api: AppUrl.Notification, token: token)
        .then((value) {
      notifications = value.data;
      setLoading(false);
    }).onError((error, stackTrace) {
      print(stackTrace);
    });
  }

  Future<void> getOrderReport() async {
    isLoading = true;
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    await _myRepo.OrderReportGetRequest(api: AppUrl.OrderReport, token: token)
        .then((value) {
      orderReport = value;
      setLoading(false);
    }).onError((error, stackTrace) {
      print(stackTrace);
      setLoading(false);
    });
  }
}
