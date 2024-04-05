import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/View/ORDER/model/orderModel.dart';
import 'package:alpha_work/View/ORDER/pendingOrderDetail.dart';
import 'package:alpha_work/View/Product/productDetail.dart';
import 'package:alpha_work/ViewModel/orderMgmtViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:alpha_work/Widget/Placeholders/NoOrder.dart';
import 'package:alpha_work/Widget/appLoader.dart';
import 'package:alpha_work/Widget/dateFormatter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class TotalDeliveredProductScreen extends StatefulWidget {
  const TotalDeliveredProductScreen({super.key});

  @override
  State<TotalDeliveredProductScreen> createState() =>
      _TotalDeliveredProductScreenState();
}

class _TotalDeliveredProductScreenState
    extends State<TotalDeliveredProductScreen> {
  late OrderManagementViewModel orders;
  int selectedTab = 1;
  List<OrderData> NormalOrdrs = [];
  List<OrderData> AlphaOrdrs = [];
  getData() async {
    NormalOrdrs.clear();
    AlphaOrdrs.clear();
    await orders.getOrderList(status: "");
    await orders.getOrderList(status: "delivered");

    orders.orderList.forEach((element) {
      if (element.isAlphaDelivery != true) {
        NormalOrdrs.add(element);
      } else {
        AlphaOrdrs.add(element);
      }
    });
    setState(() {});
  }

  @override
  void initState() {
    orders = Provider.of<OrderManagementViewModel>(context, listen: false);
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    orders = Provider.of<OrderManagementViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppbar(appbarTitle: "Total Delivery"),
      body: orders.isLoading
          ? appLoader()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() {
                            selectedTab = 1;
                          }),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: selectedTab == 1
                                    ? colors.buttonColor.withOpacity(0.3)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              "Normal Delivery",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: selectedTab == 1
                                        ? colors.buttonColor
                                        : colors.greyText,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      VerticalDivider(),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() {
                            selectedTab = 2;
                          }),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: selectedTab == 1
                                    ? Colors.transparent
                                    : colors.buttonColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              "Alpha Delivery",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: selectedTab == 1
                                        ? colors.greyText
                                        : colors.buttonColor,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.transparent),
                  selectedTab == 1
                      ? Expanded(
                          child: NormalOrdrs.isEmpty
                              ? Center(child: NoOrderFound(height: 100))
                              : Container(
                                  child: ListView.builder(
                                    itemCount: NormalOrdrs.length,
                                    itemBuilder: (context, index) => Container(
                                      padding: const EdgeInsets.all(8),
                                      margin: const EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightGrey,
                                      ),
                                      child: GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            PageTransition(
                                                child: PendingOrderDetail(
                                                  order: NormalOrdrs[index],
                                                  orderType: "Delivered",
                                                ),
                                                type: PageTransitionType
                                                    .rightToLeft)),
                                        child: ListTile(
                                          title: Text(
                                            NormalOrdrs[index]
                                                .detail!
                                                .name
                                                .toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                NormalOrdrs[index]
                                                    .orderId
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: colors.greyText),
                                              ),
                                              Text(
                                                CustomDateFormat.formatDateOnly(
                                                    NormalOrdrs[index]
                                                        .detail!
                                                        .updatedAt
                                                        .toString()),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: colors.greyText),
                                              ),
                                            ],
                                          ),
                                          trailing: AutoSizeText(
                                            NormalOrdrs[index]
                                                .detail!
                                                .unitPrice
                                                .toString(),
                                            maxFontSize: 18,
                                            minFontSize: 16,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                // fontSize: 18,
                                                fontFamily: 'Montreal',
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        )
                      : Expanded(
                          child: AlphaOrdrs.isEmpty
                              ? Center(child: NoOrderFound(height: 100))
                              : Container(
                                  child: ListView.builder(
                                    itemCount: AlphaOrdrs.length,
                                    itemBuilder: (context, index) => Container(
                                      padding: const EdgeInsets.all(8),
                                      margin: const EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightGrey,
                                      ),
                                      child: GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            PageTransition(
                                                child: PendingOrderDetail(
                                                  order: AlphaOrdrs[index],
                                                  orderType: "Delivered",
                                                ),
                                                type: PageTransitionType
                                                    .rightToLeft)),
                                        child: ListTile(
                                          title: Text(
                                            AlphaOrdrs[index]
                                                .detail!
                                                .name
                                                .toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                AlphaOrdrs[index]
                                                    .orderId
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: colors.greyText),
                                              ),
                                              Text(
                                                CustomDateFormat.formatDateOnly(
                                                    AlphaOrdrs[index]
                                                        .detail!
                                                        .updatedAt
                                                        .toString()),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: colors.greyText),
                                              ),
                                            ],
                                          ),
                                          trailing: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 30,
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Image.asset(
                                                  Images.alpha_icon,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              AutoSizeText(
                                                AlphaOrdrs[index]
                                                    .detail!
                                                    .unitPrice
                                                    .toString(),
                                                maxFontSize: 18,
                                                minFontSize: 16,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    // fontSize: 18,
                                                    fontFamily: 'Montreal',
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        )
                ],
              ),
            ),
    );
  }
}
