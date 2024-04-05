import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/View/ORDER/ordermanagement.dart';
import 'package:alpha_work/View/ORDER/pickupBottamsheet.dart';
import 'package:alpha_work/View/ORDER/pickupDetail.dart';
import 'package:alpha_work/ViewModel/orderMgmtViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commanBackground.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/comman_header.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:alpha_work/Widget/Placeholders/NoSearch.dart';
import 'package:alpha_work/Widget/appLoader.dart';
import 'package:alpha_work/Widget/errorImage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchable_listview/searchable_listview.dart';

class PickupSlotScreen extends StatefulWidget {
  const PickupSlotScreen({super.key, required this.orderID});
  final String orderID;
  @override
  State<PickupSlotScreen> createState() => _PickupSlotScreenState();
}

class _PickupSlotScreenState extends State<PickupSlotScreen> {
  late OrderManagementViewModel provider;
  @override
  void initState() {
    print(widget.orderID);
    provider = Provider.of<OrderManagementViewModel>(context, listen: false);
    provider.getDeliveryManList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<OrderManagementViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppbar(appbarTitle: "Pickup Slot"),
      body: provider.isLoading
          ? appLoader()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SearchableList(
                  autoFocusOnSearch: false,
                  initialList: provider.deliveryMans,
                  inputDecoration: (const InputDecoration())
                      .applyDefaults(Theme.of(context).inputDecorationTheme)
                      .copyWith(
                        hintText: "Search by Driver Name",
                        hintStyle: TextStyle(
                            color: colors.greyText,
                            fontWeight: FontWeight.normal),
                      ),
                  filter: (query) => provider.deliveryMans
                      .where((element) => element.fName!
                          .toLowerCase()
                          .toString()
                          .contains(query))
                      .toList(),
                  emptyWidget: NoSearch(),
                  builder: (displayedList, index, item) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFE9E9E9)),
                      // height: MediaQuery.of(context).size.height * .17,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height * .1,
                                width: MediaQuery.of(context).size.height * .1,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    item.image.toString(),
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            ErrorImageWidget(height: null),
                                  ),
                                ),
                              ),
                              VerticalDivider(
                                color: Colors.transparent,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.fName.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Vehicle Type - ${item.vehicleType.toString()}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: colors.greyText,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .55,
                                    child: Text(
                                      "License No - ${item.licenseNumber.toString()}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: colors.greyText,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Text(
                              //   item.amount.toString(),
                              //   style: TextStyle(
                              //     fontSize: 24,
                              //     color: Colors.black,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                              GestureDetector(
                                onTap: () => showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                  ),
                                  context: context,
                                  builder: (ctx) => PickupBottomSheet(
                                      deliveryManId: item.id.toString(),
                                      orderId: widget.orderID),
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * .3,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: colors.buttonColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    "SHIP NOW",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
    );
  }
}
