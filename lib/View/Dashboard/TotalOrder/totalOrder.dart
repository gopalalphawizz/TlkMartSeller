import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/View/Dashboard/model/dashboardServiceModel.dart';
import 'package:alpha_work/View/ORDER/ordermanagement.dart';
import 'package:alpha_work/ViewModel/dashboardViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:alpha_work/Widget/appLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class TotalOrderScreen extends StatefulWidget {
  const TotalOrderScreen({Key? key, required this.total}) : super(key: key);
  final String total;
  @override
  _TotalOrderScreenState createState() => _TotalOrderScreenState();
}

class _TotalOrderScreenState extends State<TotalOrderScreen> {
  late DashboardViewModel dashProvider;
  getImage(String status) {
    switch (status) {
      case "pending":
        return "assets/svg/new.svg";
      case "confirmed":
        return "assets/svg/confirmed.svg";
      case "processing":
        return "assets/svg/pack.svg";
      case "shipped":
        return "assets/svg/ship.svg";
      case "out_for_delivery":
        return "assets/svg/out.svg";
      case "delivered":
        return "assets/svg/delivered.svg";
      case "returned":
        return "assets/svg/return.svg";
      case "failed":
        return "assets/svg/failed.svg";
      case "canceled":
        return "assets/svg/cancelled.svg";
      default:
        "";
    }
  }

  @override
  void initState() {
    dashProvider = Provider.of(context, listen: false);
    dashProvider.getOrderReport();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    dashProvider = Provider.of(context);
    return Scaffold(
      backgroundColor: colors.lightGrey,
      appBar: CommanAppbar(appbarTitle: "Total Orders"),
      body: dashProvider.isLoading
          ? appLoader()
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage(Images.bfGrids), fit: BoxFit.fill),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Orders',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF767680),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        Row(
                          children: [
                            Text(
                              widget.total,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            // VerticalDivider(),
                            // Container(
                            //   padding: const EdgeInsets.symmetric(horizontal: 8),
                            //   decoration: BoxDecoration(
                            //     color: colors.buttonColor,
                            //     borderRadius: BorderRadius.circular(10),
                            //   ),
                            //   child: Row(
                            //     children: [
                            //       Icon(
                            //         Icons.arrow_drop_up_outlined,
                            //         size: 30,
                            //         color: Colors.white,
                            //       ),
                            //       Text(
                            //         "15%",
                            //         style: Theme.of(context)
                            //             .textTheme
                            //             .bodyLarge!
                            //             .copyWith(
                            //               color: Colors.white,
                            //             ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Today",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: colors.greyText),
                            ),
                            Text(
                              dashProvider.orderReport!.data!.today.toString(),
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * .04,
                          child: VerticalDivider(
                            color: colors.lightTextColor,
                            thickness: 1,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "This Week",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: colors.greyText),
                            ),
                            Text(
                              dashProvider.orderReport!.data!.week.toString(),
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * .04,
                          child: VerticalDivider(
                            color: colors.lightTextColor,
                            thickness: 1,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "This Month",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: colors.greyText),
                            ),
                            Text(
                              dashProvider.orderReport!.data!.month.toString(),
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2 / 2.2,
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount: dashProvider.orderReport!.allStatus.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => Navigator.push(
                                context,
                                PageTransition(
                                    child: OrderManagement(index: index),
                                    type: PageTransitionType.rightToLeft))
                            .then((value) => dashProvider.getOrderReport()),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SvgPicture.asset(getImage(dashProvider
                                    .orderReport!.allStatus[index].value
                                    .toString())),
                              ),
                              Spacer(),
                              Text(
                                dashProvider.orderReport!.allStatus[index].count
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                              ),
                              Spacer(),
                              Text(
                                dashProvider.orderReport!.allStatus[index].title
                                    .toString(),
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 12,
                                    ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
