import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/View/ORDER/model/orderModel.dart';
import 'package:alpha_work/View/ORDER/pickupSlot.dart';
import 'package:alpha_work/ViewModel/productMgmtViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:alpha_work/Widget/appLoader.dart';
import 'package:alpha_work/Widget/dateFormatter.dart';
import 'package:alpha_work/Widget/errorImage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PendingOrderDetail extends StatefulWidget {
  const PendingOrderDetail(
      {super.key, required this.order, required this.orderType});
  final OrderData order;
  final String orderType;
  @override
  State<PendingOrderDetail> createState() => _PendingOrderDetailState();
}

class _PendingOrderDetailState extends State<PendingOrderDetail> {
  late ProductManagementViewModel productPro;
  String address = '';
  @override
  void initState() {
    print(widget.order.detail!.id.toString());
    productPro =
        Provider.of<ProductManagementViewModel>(context, listen: false);
    productPro.getProductDetail(id: widget.order.detail!.id.toString());
    address =
        "${widget.order.shippingAddressData!.address}, ${widget.order.shippingAddressData!.address1}, ${widget.order.shippingAddressData!.city}, ${widget.order.shippingAddressData!.state}, ${widget.order.shippingAddressData!.country}-${widget.order.shippingAddressData!.zip}";
    super.initState();
  }

  Color getTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.blue;
      case 'processing':
        return colors.deliveredLight;
      case 'cancelled':
        return Colors.red;
      case 'delivered':
        return Colors.green;
      case 'pending':
        return Colors.orange;

      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    productPro = Provider.of<ProductManagementViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppbar(appbarTitle: "Order Detail"),
      body: SizedBox(
        height: height,
        width: width,
        child: productPro.isLoading
            ? appLoader()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Row(
                      children: [
                        SizedBox.square(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: colors.lightGrey,
                            ),
                            child: Image.network(
                              productPro.productDetail.first.thumbnail
                                  .toString(),
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  ErrorImageWidget(height: height),
                            ),
                          ),
                          dimension: height * .11,
                        ),
                        VerticalDivider(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: width * .65,
                              child: Text(
                                productPro.productDetail.first.name.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * .65,
                              child: Row(
                                children: [
                                  Text(
                                    productPro.productDetail.first.specialPrice
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: colors.buttonColor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montreal'),
                                  ),
                                  VerticalDivider(width: 3),
                                  Text(
                                    productPro.productDetail.first.unitPrice
                                        .toString(),
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 14,
                                        color: colors.greyText,
                                        fontFamily: 'Montreal'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width * .68,
                              child: RichText(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: productPro
                                          .productDetail.first.weight
                                          .toString(),
                                      style: TextStyle(
                                          color: colors.greyText, fontSize: 16),
                                    ),
                                    TextSpan(
                                      text: " | ",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: 'Qty -',
                                      style: TextStyle(
                                          color: colors.greyText, fontSize: 16),
                                    ),
                                    TextSpan(
                                      text: widget.order.detail!.quantity
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: " | ",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: 'Variant - ',
                                      style: TextStyle(
                                          color: colors.greyText, fontSize: 16),
                                    ),
                                    TextSpan(
                                      text: widget.order.variant.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width,
                    color: colors.lightGrey,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order ID",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: colors.greyText,
                                  ),
                                ),
                                Text(
                                  widget.order.orderId.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Order Date",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: colors.greyText,
                                  ),
                                ),
                                Text(
                                  widget.order.orderDate
                                      .toString()
                                      .replaceAll("-", " "),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Payment Method ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: colors.greyText,
                                  ),
                                ),
                                Text(
                                  widget.order.payment_method.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Shipment Date",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: colors.greyText,
                                  ),
                                ),
                                Text(
                                  widget.order.expected_delivery_date.isEmpty
                                      ? ""
                                      : DateFormat('dd MMMM yyyy').format(
                                          DateTime.parse(widget
                                              .order.expected_delivery_date)),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Shipment Detail",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: getTextColor(widget.orderType)
                                  .withOpacity(0.2),
                              border: Border.all(
                                color: getTextColor(widget.orderType),
                                width: 1,
                              )),
                          child: Text(
                            widget.orderType,
                            style: TextStyle(
                              color: getTextColor(widget.orderType),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Buyer name",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: colors.greyText,
                                    ),
                                  ),
                                  Text(
                                    widget.order.customer.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              VerticalDivider(
                                width: width * .3,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Delivery Type",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: colors.greyText,
                                    ),
                                  ),
                                  Text(
                                    widget.order.isAlphaDelivery.toString() ==
                                            'true'
                                        ? "Alpha Delivery"
                                        : 'Normal Delivery',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Text(
                          //       "Pickup Address",
                          //       style: TextStyle(
                          //         fontSize: 14,
                          //         color: colors.greyText,
                          //       ),
                          //     ),
                          //     Text(
                          //       widget.order.billingAddressData!.address
                          //           .toString(),
                          //       style: TextStyle(
                          //         fontSize: 14,
                          //         color: Colors.black,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // const SizedBox(height: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Delivery Address",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: colors.greyText,
                                ),
                              ),
                              Container(
                                width: width * .9,
                                child: Text(
                                  address,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(color: colors.lightBorder),
                          Text(
                            "Price Detail",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "MRP (1 item)",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? colors.textColor
                                                    : Colors.black,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        widget.order.priceDetail!.mrp
                                            .toString(),
                                        style: TextStyle(
                                            fontFamily: 'Montreal',
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? colors.textColor
                                                    : Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Product Discount",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? colors.greyText
                                                    : Colors.black54,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        widget.order.priceDetail!.discount
                                            .toString(),
                                        style: TextStyle(
                                            fontFamily: 'Montreal',
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? colors.textColor
                                                    : Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Delivery Fee",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? colors.greyText
                                                    : Colors.black54,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        widget.order.priceDetail!.deliveryFee
                                            .toString(),
                                        style: TextStyle(
                                            fontFamily: 'Montreal',
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? colors.textColor
                                                    : Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Tax fee",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? colors.greyText
                                                    : Colors.black54,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        widget.order.priceDetail!.tax
                                            .toString(),
                                        style: TextStyle(
                                            fontFamily: 'Montreal',
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? colors.textColor
                                                    : Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Subtotal",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? colors.greyText
                                                    : Colors.black54,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        widget.order.priceDetail!.subtotal
                                            .toString(),
                                        style: TextStyle(
                                            fontFamily: 'Montreal',
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? colors.textColor
                                                    : Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Coupon Discount",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? colors.greyText
                                                    : Colors.black54,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        widget.order.priceDetail!.couponDiscount
                                            .toString(),
                                        style: TextStyle(
                                            fontFamily: 'Montreal',
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? colors.textColor
                                                    : Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 5,
                                  color: colors.greyText,
                                  thickness: 1,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total Amount",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? colors.textColor
                                                    : Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.order.priceDetail!.total
                                            .toString(),
                                        style: TextStyle(
                                            fontFamily: 'Montreal',
                                            color: colors.buttonColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 5,
                                  color: colors.greyText,
                                  thickness: 1,
                                ),
                                Divider(
                                  color: Colors.transparent,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
                ],
              ),
      ),
      bottomNavigationBar: widget.orderType == "Packaging"
          ? SizedBox(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: width * .43,
                        height: 50,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: colors.lightBorder,
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "CANCEL",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    VerticalDivider(color: Colors.transparent),
                    GestureDetector(
                      onTap: () => Navigator.of(context)
                          .push(MaterialPageRoute(
                            builder: (context) => PickupSlotScreen(
                                orderID: widget.order.orderId.toString()),
                          ))
                          .then((value) => Navigator.pop(context)),
                      child: Container(
                        width: width * .43,
                        height: 50,
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: colors.buttonColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "SHIP NOW",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}






//           Spacer(),

        