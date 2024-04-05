import 'dart:io';

import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/utils.dart';
import 'package:alpha_work/View/Customer/Model/customerModel.dart';
import 'package:alpha_work/View/Product/model/productListModel.dart';
import 'package:alpha_work/View/Profile/Advertising/selectpayment.dart';
import 'package:alpha_work/ViewModel/productMgmtViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class UploadBannerScreen extends StatefulWidget {
  final String amount;
  final String adId;
  final String heading;

  const UploadBannerScreen(
      {super.key,
      required this.amount,
      required this.adId,
      required this.heading});
  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  late ProductManagementViewModel product;
  @override
  void initState() {
    product = Provider.of<ProductManagementViewModel>(context, listen: false);
    product.getProductsListWithStatus(Type: '1', stockType: null);
    product.selectedAdProducts.clear();
    print(product.productList.length);
    super.initState();
  }

  String path = '';
  File? _image;
  final picker = ImagePicker();
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    print(pickedFile!.path.toString());
    path = pickedFile.path.toString();
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  final TextEditingController FromCtrl = TextEditingController();
  final TextEditingController ToCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppbar(appbarTitle: "Advertising"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Banner and upload promotional",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 24,
                    ),
              ),
              const Divider(color: Colors.transparent),
              GestureDetector(
                onTap: () => getImageFromGallery(),
                child: Container(
                  width: double.infinity,
                  height: height * .2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: colors.lightGrey)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: path.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_outlined,
                                color: Colors.black,
                              ),
                              Text("1024x786",
                                  style: Theme.of(context).textTheme.bodyLarge),
                              Text("Banner Size",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: colors.greyText,
                                      )),
                            ],
                          )
                        : Image.file(_image!, fit: BoxFit.contain),
                  ),
                ),
              ),
              const Divider(color: Colors.transparent),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (Dctx) => SelectProductDialog(),
                  ).then((value) => setState(() {}));
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(double.maxFinite, 45),
                ),
                child: Text(
                  "Select Products",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white),
                ),
              ),
              const Divider(color: Colors.transparent),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: colors.lightGrey,
                    )),
                child: product.selectedAdProducts.isEmpty
                    ? Text(
                        "No Product Selected",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: colors.greyText),
                      )
                    : Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        spacing: 10,
                        children: product.selectedAdProducts
                            .map((e) => Chip(label: Text(e.name.toString())))
                            .toList(),
                      ),
              ),
              const Divider(color: Colors.transparent),
              Text(
                "Select Advertising Date ",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Divider(color: Colors.transparent),
              GestureDetector(
                onTap: () async {
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
                      FromCtrl.text =
                          formattedDate; //set output date to TextField value.
                    });
                  }
                },
                child: Container(
                  width: double.maxFinite,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: colors.lightGrey),
                  ),
                  child: Text(
                    FromCtrl.text.isEmpty ? "Starting Date" : FromCtrl.text,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: colors.greyText),
                  ),
                ),
              ),
              const Divider(color: Colors.transparent),
              ElevatedButton(
                  onPressed: () {
                    if (path.isEmpty) {
                      Utils.showTost(msg: "Please select banner image");
                    } else if (product.selectedAdProducts.isEmpty) {
                      Utils.showTost(msg: "Please select products");
                    } else if (FromCtrl.text.isEmpty) {
                      Utils.showTost(msg: "Please select starting date");
                    } else {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: SelectPaymentScreen(
                                  StartingDate: FromCtrl.text.toString(),
                                  image: _image!,
                                  productIds: product.selectedAdProducts
                                      .map((e) => e.id.toString())
                                      .toList(),
                                  amount: widget.amount,
                                  heading: widget.heading,
                                  adId: widget.adId),
                              type: PageTransitionType.rightToLeft));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(double.maxFinite, 45),
                  ),
                  child: Text(
                    "Upload Banner",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectProductDialog extends StatefulWidget {
  const SelectProductDialog({super.key});
  @override
  State<SelectProductDialog> createState() => _SelectProductDialogState();
}

class _SelectProductDialogState extends State<SelectProductDialog> {
  late ProductManagementViewModel product;
  @override
  void initState() {
    product = Provider.of<ProductManagementViewModel>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: product.productList.length < 6
            ? product.productList.length * 160
            : MediaQuery.of(context).size.height * .5,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Products",
                style: Theme.of(context).textTheme.bodyMedium),
            Expanded(
              flex: 1,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: product.productList.length,
                itemBuilder: (context, index) => CheckboxListTile(
                  value: product.selectedAdProducts
                      .contains(product.productList[index]),
                  onChanged: (value) {
                    setState(() {
                      value!
                          ? product.selectedAdProducts
                              .add(product.productList[index])
                          : product.selectedAdProducts
                              .remove(product.productList[index]);
                    });
                  },
                  title: Text(
                    product.productList[index].name.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ),
            const Divider(color: Colors.transparent),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(double.maxFinite, 45),
              ),
              child: Text(
                "Done",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
