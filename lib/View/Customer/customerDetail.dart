import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/View/Customer/Model/customerModel.dart';
import 'package:alpha_work/View/Product/editProduct.dart';
import 'package:alpha_work/View/Product/productDetail.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:alpha_work/Widget/errorImage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:page_transition/page_transition.dart';

class CustomerDetailScreen extends StatelessWidget {
  const CustomerDetailScreen({super.key, required this.data});
  final CustomerData data;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppbar(appbarTitle: "Customer Details"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => showDialog(
                        context: context,
                        builder: (dctx) => Dialog(
                          backgroundColor: Colors.transparent,
                          child: CachedNetworkImage(
                            imageUrl: data.image.toString(),
                            errorWidget: (context, url, error) =>
                                ErrorImageWidget(height: 250),
                          ),
                        ),
                      ),
                      child: Container(
                          height: height * .08,
                          width: height * .08,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              data.image.toString(),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  ErrorImageWidget(height: height),
                            ),
                          )),
                    ),
                    VerticalDivider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.fName.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data.phone.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              color: colors.greyText,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    )
                  ],
                ),
                Divider(height: 5, color: Colors.transparent),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          color: colors.greyText,
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      data.email.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(color: colors.lightGrey, height: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "Product Purchased",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListView.builder(
              itemCount: data.products.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    PageTransition(
                        child: ProductDetailScreen(
                            id: data.products[index].id.toString()),
                        type: PageTransitionType.rightToLeft)),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      // image: DecorationImage(image: NetworkImage(model.images.first)),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(
                        colors: Theme.of(context).brightness == Brightness.dark
                            ? [
                                colors.boxGradient1.withOpacity(1),
                                Colors.transparent,
                              ]
                            : [
                                Colors.grey.withOpacity(0.2),
                                Colors.transparent,
                              ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      border: Border.all(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? colors.boxBorder
                              : colors.lightBorder)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: CachedNetworkImageProvider(
                                  data.products[index].thumbnail.toString()),
                              onError: (exception, stackTrace) =>
                                  ErrorImageWidget(height: height),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(
                                "${data.products[index].discount.toString()} %",
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: AutoSizeText(
                                data.products[index].name.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                maxFontSize: 14,
                                style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AutoSizeText(
                                    data.products[index].specialPrice
                                        .toString(),
                                    maxFontSize: 22,
                                    // minFontSize: 18,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: colors.buttonColor,
                                      fontFamily: 'Montreal',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: AutoSizeText(
                                      data.products[index].unitPrice.toString(),
                                      maxFontSize: 16,
                                      // minFontSize: 12,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: colors.lightTextColor,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 14,
                                          fontFamily: 'Montreal'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 5),
                                decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  "Delivered",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Divider(color: colors.lightGrey, height: 2),
        ],
      ),
    );
  }
}
