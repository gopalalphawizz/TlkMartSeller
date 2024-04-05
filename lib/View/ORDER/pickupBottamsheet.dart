import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/utils.dart';
import 'package:alpha_work/View/ORDER/ordermanagement.dart';
import 'package:alpha_work/ViewModel/orderMgmtViewModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PickupBottomSheet extends StatefulWidget {
  final String orderId;
  final String deliveryManId;

  const PickupBottomSheet(
      {super.key, required this.orderId, required this.deliveryManId});
  @override
  State<PickupBottomSheet> createState() => _PickupBottomSheetState();
}

class _PickupBottomSheetState extends State<PickupBottomSheet> {
  final TextEditingController dateCtrl = TextEditingController();
  late OrderManagementViewModel ordelPro;
  @override
  void initState() {
    print(widget.orderId);
    ordelPro = Provider.of<OrderManagementViewModel>(context, listen: false);
    dateCtrl.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .25,
      width: double.maxFinite,
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Text(
              "Pickup Slot",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Divider(color: Colors.transparent),
          TextField(
            readOnly: true,
            controller: dateCtrl,
            decoration: InputDecoration()
                .applyDefaults(Theme.of(context).inputDecorationTheme)
                .copyWith(
                  suffixIcon: IconButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime
                                .now(), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101));
                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement

                          setState(() {
                            dateCtrl.text =
                                formattedDate; //set output date to TextField value.
                          });
                        }
                      },
                      icon: Icon(
                        Icons.date_range_rounded,
                        color: Colors.black,
                      )),
                ),
          ),
          Divider(color: Colors.transparent),
          ElevatedButton(
              onPressed: () {
                ordelPro
                    .assignDeliveryMan(
                  delivery_man_id: widget.deliveryManId,
                  order_id: widget.orderId,
                  expected_delivery_date: dateCtrl.text.toString(),
                )
                    .then((value) async {
                  Utils.showTost(msg: value['message'].toString());
                  if (value['status'] == true) {
                    await ordelPro.getOrderList(status: "processing");
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: colors.buttonColor,
                  padding: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              child: Text(
                "SCHEDULE PICKUP",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
