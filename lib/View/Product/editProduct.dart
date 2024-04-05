import 'dart:io';
import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/Utils/utils.dart';
import 'package:alpha_work/View/Product/model/categoryModel.dart';
import 'package:alpha_work/View/Product/model/productDetailModel.dart';
import 'package:alpha_work/ViewModel/productMgmtViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:alpha_work/Widget/DropdownDeco.dart';
import 'package:alpha_work/Widget/appLoader.dart';
import 'package:alpha_work/Widget/errorImage.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditProdutScreen extends StatefulWidget {
  final Product productDetail;

  const EditProdutScreen({super.key, required this.productDetail});

  @override
  State<EditProdutScreen> createState() => _EditProdutScreenState();
}

class _EditProdutScreenState extends State<EditProdutScreen> {
  late ProductManagementViewModel productProvider;
  var _formKey = GlobalKey<FormState>();
  bool freeDelivery = false;
  bool cancellable = false;
  final List<DropdownMenuItem> Taxitems = [
    DropdownMenuItem(
        child: Text(
          "Include",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        ),
        value: "include"),
    DropdownMenuItem(
        child: Text(
          "Exclude",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        ),
        value: "exclude"),
  ];
  final List<DropdownMenuItem> indicatoritems = [
    DropdownMenuItem(
        child: Text(
          "Veg",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        ),
        value: "Veg"),
    DropdownMenuItem(
        child: Text(
          "Non-veg",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        ),
        value: "Non-veg"),
  ];
  final List<DropdownMenuItem> discountItems = [
    DropdownMenuItem(
        child: Text(
          "Flat",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        ),
        value: "flat"),
    DropdownMenuItem(
        child: Text(
          "Percent",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        ),
        value: "percent"),
  ];
  final List<DropdownMenuItem> productType = [
    DropdownMenuItem(
        child: Text(
          "Physical",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        ),
        value: "physical"),
    DropdownMenuItem(
        child: Text(
          "Digital",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        ),
        value: "Digital"),
  ];
  final List<DropdownMenuItem> unitType = [
    DropdownMenuItem(
        child: Text(
          "KG",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        ),
        value: "kg"),
    DropdownMenuItem(
        child: Text(
          "PC",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        ),
        value: "pc"),
    DropdownMenuItem(
        child: Text(
          "GMS",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        ),
        value: "gms"),
  ];
  late String? image;
  final nameCtrl = TextEditingController();
  final qtyInStockCtrl = TextEditingController();
  final skuIdCtrl = TextEditingController();
  final TagsCtrl = TextEditingController();
  final TaxCtrl = TextEditingController();
  final shippingCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final PurchaceCtrl = TextEditingController();
  final minQtyCtrl = TextEditingController();
  final warrantyCtrl = TextEditingController();
  final guaranteeCtrl = TextEditingController();
  final brandNameCtrl = TextEditingController();
  final warranty = TextEditingController();
  final manufacturing = TextEditingController();
  final priceCtrl = TextEditingController();
  final discountPriceCtrl = TextEditingController();

  String? selectedPtype;
  String? selectedTax;
  String? selectedIndicator;
  String? selectedDiscount;
  String? selectedUnit;
  String? selectedValue;
  bool isFromFile = false;
  bool containsHtml(String input) {
    RegExp htmlTags = RegExp(r'<[^>]*>');

    return htmlTags.hasMatch(input);
  }

  void disposeMethod() {
    productProvider.setBrand(null);
    productProvider.setCategory(null);
    productProvider.setSubCategory(null);
    nameCtrl.clear;
    qtyInStockCtrl.clear;
    skuIdCtrl.clear;
    TagsCtrl.clear;
    TaxCtrl.clear;
    shippingCtrl.clear;
    descCtrl.clear;
    PurchaceCtrl.clear;
    minQtyCtrl.clear;
    warrantyCtrl.clear;
    guaranteeCtrl.clear;
    brandNameCtrl.clear;
    priceCtrl.clear;
    discountPriceCtrl.clear;
  }

  getData() async {
    await productProvider.getCategory(id: '0');
    await productProvider.getBrandList();
    await productProvider.setCategory(productProvider.categories.firstWhere(
        (e) => e.id.toString() == widget.productDetail.categoryId.toString()));
    print(productProvider.selectedCat!.name.toString());
    await productProvider.getsubCategory(
        id: widget.productDetail.categoryId.toString());
    print("widget id : ${widget.productDetail.subCategoryId}");

    await productProvider.setSubCategory(productProvider.subcategories
        .firstWhere((e) =>
            e.id.toString() == widget.productDetail.subCategoryId.toString()));
    await productProvider.getsubsubCategory(
        id: widget.productDetail.subCategoryId.toString());
    await productProvider.setSubSubCategory(productProvider.subsubcategories
        .firstWhere((e) =>
            e.id.toString() ==
            widget.productDetail.subSubCategoryId.toString()));
    await productProvider.setBrand(productProvider.brandList.firstWhere(
        (e) => e.id.toString() == widget.productDetail.brandId.toString()));
  }

  bool enabled = true;
  late final Future myFuture;
  @override
  void dispose() {
    productProvider.setBrand(null);
    productProvider.setCategory(null);
    productProvider.setSubCategory(null);
    nameCtrl.dispose();
    qtyInStockCtrl.dispose();
    skuIdCtrl.dispose();
    TagsCtrl.dispose();
    TaxCtrl.dispose();
    shippingCtrl.dispose();
    descCtrl.dispose();
    PurchaceCtrl.dispose();
    minQtyCtrl.dispose();
    warrantyCtrl.dispose();
    guaranteeCtrl.dispose();
    brandNameCtrl.dispose();
    priceCtrl.dispose();
    discountPriceCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    image = widget.productDetail.thumbnail;
    nameCtrl.text = widget.productDetail.name.toString();
    qtyInStockCtrl.text = widget.productDetail.currentStock.toString();
    skuIdCtrl.text = widget.productDetail.code.toString();
    TaxCtrl.text = widget.productDetail.tax.toString();
    shippingCtrl.text = widget.productDetail.shippingCost.toString();
    descCtrl.text = widget.productDetail.details.toString();
    enabled = containsHtml(widget.productDetail.details.toString());
    PurchaceCtrl.text =
        widget.productDetail.purchasePrice!.substring(1).toString();
    minQtyCtrl.text = widget.productDetail.minimumOrderQty.toString();
    warrantyCtrl.text = widget.productDetail.warranty.toString();
    priceCtrl.text = widget.productDetail.unitPrice!.substring(1).toString();
    discountPriceCtrl.text = widget.productDetail.discount.toString();
    // selectedPtype=widget.productDetail.
    selectedTax = widget.productDetail.taxModel.toString();
    selectedDiscount = widget.productDetail.discountType.toString();
    selectedUnit = widget.productDetail.unit.toString();
    selectedPtype = widget.productDetail.productType.toString();
    warranty.text = widget.productDetail.warranty.toString();
    manufacturing.text = widget.productDetail.manufacturingDate.toString();
    freeDelivery = widget.productDetail.freeDelivery == 1 ? true : false;
    cancellable = widget.productDetail.returnable == 1 ? true : false;
    print("namamjdhf${priceCtrl.text}");
    productProvider =
        Provider.of<ProductManagementViewModel>(context, listen: false);
    myFuture = getData();

    super.initState();
  }

  File? _image;
  final picker = ImagePicker();
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    print(pickedFile!.path.toString());
    image = pickedFile.path.toString();
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      await productProvider.getImageUrl(path: image.toString());
      image = productProvider.thumbnail.toString();
    }
    setState(() {
      isFromFile = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppbar(appbarTitle: "Edit Product"),
      body: FutureBuilder(
        future: myFuture,
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? appLoader()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: (const InputDecoration())
                                      .applyDefaults(Theme.of(context)
                                          .inputDecorationTheme)
                                      .copyWith(labelText: "Product Name"),
                                  controller: nameCtrl,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter product name";
                                    }
                                    return null;
                                  },
                                ),
                                const Divider(color: Colors.transparent),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: DropDownDeco(ctx: context),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, right: 12),
                                    child: Consumer<ProductManagementViewModel>(
                                        builder: (context, val, _) {
                                      if (productProvider.categories.length ==
                                          0) {
                                        productProvider.getCategory(id: '0');
                                      }
                                      return DropdownButton<CategoryData>(
                                        underline: Container(),
                                        isExpanded: true,
                                        dropdownColor:
                                            Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? colors.darkBG
                                                : Colors.white,
                                        value: val.selectedCat,
                                        onChanged: (value) {
                                          setState(() {
                                            val.setCategory(value!);

                                            val.getsubCategory(
                                                id: value.id.toString());
                                          });
                                        },
                                        items: productProvider.categories
                                            .map((e) => DropdownMenuItem(
                                                  child: Text(
                                                    e.name.toString(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  value: e,
                                                ))
                                            .toList(),
                                        hint: Text('Select Category',
                                            style: TextStyle(
                                                color: colors.greyText,
                                                fontWeight: FontWeight.normal)),
                                      );
                                    }),
                                  ),
                                ),
                                const Divider(color: Colors.transparent),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: DropDownDeco(ctx: context),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, right: 12),
                                    child: Consumer<ProductManagementViewModel>(
                                        builder: (context, val, _) {
                                      return DropdownButton<CategoryData>(
                                        underline: Container(),
                                        isExpanded: true,
                                        dropdownColor:
                                            Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? colors.darkBG
                                                : Colors.white,
                                        value: val.selectedSubCat,
                                        onChanged: (value) {
                                          setState(() {
                                            val.setSubCategory(value);

                                            val.getsubsubCategory(
                                                id: value!.id.toString());
                                          });
                                        },
                                        items: val.subcategories
                                            .map((e) => DropdownMenuItem(
                                                  child: Text(
                                                    e.name.toString(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  value: e,
                                                ))
                                            .toList(),
                                        hint: Text('Select Sub Category',
                                            style: TextStyle(
                                                color: colors.greyText,
                                                fontWeight: FontWeight.normal)),
                                      );
                                    }),
                                  ),
                                ),
                                const Divider(color: Colors.transparent),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: DropDownDeco(ctx: context),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, right: 12),
                                    child: Consumer<ProductManagementViewModel>(
                                        builder: (context, val, _) {
                                      return DropdownButton<CategoryData>(
                                        underline: Container(),
                                        isExpanded: true,
                                        dropdownColor:
                                            Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? colors.darkBG
                                                : Colors.white,
                                        value: val.selectedSubSubCat,
                                        onChanged: (value) {
                                          setState(() {
                                            val.setSubSubCategory(value);
                                          });
                                        },
                                        items: val.subsubcategories
                                            .map((e) => DropdownMenuItem(
                                                  child: Text(
                                                    e.name.toString(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  value: e,
                                                ))
                                            .toList(),
                                        hint: Text('Select Sub Sub Category',
                                            style: TextStyle(
                                                color: colors.greyText,
                                                fontWeight: FontWeight.normal)),
                                      );
                                    }),
                                  ),
                                ),
                                const Divider(color: Colors.transparent),
                                DropdownButtonFormField2(
                                  decoration: const InputDecoration()
                                      .applyDefaults(Theme.of(context)
                                          .inputDecorationTheme)
                                      .copyWith(
                                          contentPadding:
                                              EdgeInsets.only(right: 10)),
                                  hint: Text("Select Product Type",
                                      style: TextStyle(
                                          color: colors.greyText,
                                          fontWeight: FontWeight.normal)),
                                  value: selectedPtype,
                                  onChanged: (value) => setState(() {
                                    selectedPtype = value ?? "";
                                  }),
                                  items: productType,
                                ),
                                const Divider(color: Colors.transparent),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  maxLength: 7,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: (const InputDecoration())
                                      .applyDefaults(Theme.of(context)
                                          .inputDecorationTheme)
                                      .copyWith(
                                        labelText: "Quantity in Stock",
                                        counterText: "",
                                      ),
                                  controller: qtyInStockCtrl,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter quantity in stock";
                                    }
                                    return null;
                                  },
                                ),
                                const Divider(color: Colors.transparent),
                                TextFormField(
                                  enabled: false,
                                  decoration: (const InputDecoration())
                                      .applyDefaults(Theme.of(context)
                                          .inputDecorationTheme)
                                      .copyWith(
                                        labelText: "SKU ID",
                                      ),
                                  controller: skuIdCtrl,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter SKU Id";
                                    }
                                    return null;
                                  },
                                ),
                                // const Divider(color: Colors.transparent),
                                // TextFormField(
                                //   decoration: (const InputDecoration())
                                //       .applyDefaults(
                                //           Theme.of(context).inputDecorationTheme)
                                //       .copyWith(labelText: "Add Tags"),
                                //   controller: TagsCtrl,
                                //   validator: (value) {
                                //     if (value == null || value.isEmpty) {
                                //       return "Enter tags";
                                //     }
                                //     return null;
                                //   },
                                // ),
                                const Divider(color: Colors.transparent),
                                // TextFormField(
                                //   keyboardType: TextInputType.number,
                                //   decoration: (const InputDecoration())
                                //       .applyDefaults(Theme.of(context)
                                //           .inputDecorationTheme)
                                //       .copyWith(labelText: "Shipping Cost"),
                                //   controller: shippingCtrl,
                                //   validator: (value) {
                                //     if (value == null || value.isEmpty) {
                                //       return "Enter shipping cost";
                                //     }
                                //     return null;
                                //   },
                                // ),
                                // const Divider(color: Colors.transparent),
                                SizedBox(
                                  height: height * .15,
                                  child: TextFormField(
                                    maxLines: 5,
                                    enabled: false,
                                    decoration: (const InputDecoration())
                                        .applyDefaults(Theme.of(context)
                                            .inputDecorationTheme)
                                        .copyWith(
                                            labelText: "Short Description",
                                            contentPadding:
                                                const EdgeInsets.all(8)),
                                    controller: descCtrl,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter description";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const Divider(color: Colors.transparent),
                                DropdownButtonFormField2(
                                  decoration: const InputDecoration()
                                      .applyDefaults(Theme.of(context)
                                          .inputDecorationTheme)
                                      .copyWith(
                                          contentPadding:
                                              EdgeInsets.only(right: 10)),
                                  hint: Text("Select Tax",
                                      style: TextStyle(
                                          color: colors.greyText,
                                          fontWeight: FontWeight.normal)),
                                  value: selectedTax,
                                  onChanged: (value) => setState(() {
                                    selectedTax = value ?? "";
                                  }),
                                  items: Taxitems,
                                ),

                                const Divider(color: Colors.transparent),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  maxLength: 2,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: (const InputDecoration())
                                      .applyDefaults(Theme.of(context)
                                          .inputDecorationTheme)
                                      .copyWith(
                                          labelText: "Add Tax in %",
                                          counterText: ""),
                                  controller: TaxCtrl,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter Tax";
                                    }
                                    return null;
                                  },
                                ),
                                const Divider(color: Colors.transparent),
                                DropdownButtonFormField2(
                                  decoration: const InputDecoration()
                                      .applyDefaults(Theme.of(context)
                                          .inputDecorationTheme)
                                      .copyWith(
                                          contentPadding:
                                              EdgeInsets.only(right: 10)),
                                  hint: Text("Select Unit",
                                      style: TextStyle(
                                          color: colors.greyText,
                                          fontWeight: FontWeight.normal)),
                                  value: selectedUnit,
                                  onChanged: (value) => setState(() {
                                    selectedUnit = value;
                                  }),
                                  items: unitType,
                                ),
                                const Divider(color: Colors.transparent),
                                // DropdownButtonFormField2(
                                //   decoration: const InputDecoration()
                                //       .applyDefaults(
                                //           Theme.of(context).inputDecorationTheme)
                                //       .copyWith(
                                //           contentPadding:
                                //               EdgeInsets.only(right: 10)),
                                //   hint: Text("Select Indicator",
                                //       style: TextStyle(
                                //           color: colors.greyText,
                                //           fontWeight: FontWeight.normal)),
                                //   value: selectedIndicator,
                                //   onChanged: (value) => setState(() {
                                //     selectedIndicator = value ?? "";
                                //   }),
                                //   items: indicatoritems,
                                // ),
                                // const Divider(color: Colors.transparent),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  maxLength: 3,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: (const InputDecoration())
                                      .applyDefaults(Theme.of(context)
                                          .inputDecorationTheme)
                                      .copyWith(
                                          labelText: "Minimum Order Quantity",
                                          counterText: ""),
                                  controller: minQtyCtrl,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter minimum order quantity";
                                    }
                                    return null;
                                  },
                                ),
                                // const Divider(color: Colors.transparent),
                                // TextFormField(
                                //   decoration: (const InputDecoration())
                                //       .applyDefaults(
                                //           Theme.of(context).inputDecorationTheme)
                                //       .copyWith(labelText: "Warranty Period"),
                                //   controller: warrantyCtrl,
                                //   validator: (value) {
                                //     if (value == null || value.isEmpty) {
                                //       return "Enter warranty period";
                                //     }
                                //     return null;
                                //   },
                                // ),
                                // const Divider(color: Colors.transparent),
                                // TextFormField(
                                //   decoration: (const InputDecoration())
                                //       .applyDefaults(
                                //           Theme.of(context).inputDecorationTheme)
                                //       .copyWith(labelText: "Guarantee Period"),
                                //   controller: guaranteeCtrl,
                                //   validator: (value) {
                                //     if (value == null || value.isEmpty) {
                                //       return "Enter guarantee period";
                                //     }
                                //     return null;
                                //   },
                                // ),
                                const Divider(color: Colors.transparent),
                                Consumer<ProductManagementViewModel>(
                                    builder: (context, brandVal, _) {
                                  return DropdownButtonFormField2(
                                    decoration: const InputDecoration()
                                        .applyDefaults(Theme.of(context)
                                            .inputDecorationTheme)
                                        .copyWith(
                                            contentPadding:
                                                EdgeInsets.only(right: 10)),
                                    hint: Text("Brand",
                                        style: TextStyle(
                                            color: colors.greyText,
                                            fontWeight: FontWeight.normal)),
                                    value: brandVal.selectedBrand,
                                    onChanged: (value) => setState(() {
                                      brandVal.setBrand(value);
                                    }),
                                    items: brandVal.brandList
                                        .map((e) => DropdownMenuItem(
                                              child: Text(
                                                e.name.toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              value: e,
                                            ))
                                        .toList(),
                                  );
                                }),
                                const Divider(color: Colors.transparent),
                                // TextFormField(
                                //   decoration: (const InputDecoration())
                                //       .applyDefaults(
                                //           Theme.of(context).inputDecorationTheme)
                                //       .copyWith(labelText: "Deliverable Type"),
                                // ),
                                // const Divider(color: Colors.transparent),
                                // DropdownButtonFormField2(
                                // decoration: const InputDecoration()
                                // .applyDefaults(
                                // Theme.of(context).inputDecorationTheme)
                                // .copyWith(
                                // contentPadding:
                                // EdgeInsets.only(right: 10)),
                                // hint: Text("Select Color",
                                // style: TextStyle(
                                // color: colors.greyText,
                                // fontWeight: FontWeight.normal)),
                                // value: selectedValue,
                                // onChanged: (value) => setState(() {
                                // selectedValue = value ?? "";
                                // }),
                                // items: Taxitems,
                                // ),
                                // const Divider(color: Colors.transparent),
                                Row(
                                  children: [
                                    DottedBorder(
                                      color: colors.buttonColor,
                                      strokeWidth: 1,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: GestureDetector(
                                          onTap: () => getImageFromGallery(),
                                          child: Container(
                                            padding: const EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                                color: Color(0xFFD5F6F6),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  Images.selectImage,
                                                  height: 30,
                                                  width: 30,
                                                  fit: BoxFit.fitHeight,
                                                ),
                                                Text(
                                                  "Main Image",
                                                  style: TextStyle(
                                                    color: colors.buttonColor,
                                                    fontSize: 12,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    VerticalDivider(color: Colors.transparent),
                                    Container(
                                      height: height * .1,
                                      width: width * .25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: colors.lightGrey,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: image == null
                                          ? Text(
                                              "Image\nContainer",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                              ),
                                            )
                                          : isFromFile
                                              ? Image.file(
                                                  _image!,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  image.toString(),
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      ErrorImageWidget(
                                                          height: height),
                                                ),
                                    ),
                                  ],
                                ),
                                // const Divider(color: Colors.transparent),
                                // Row(
                                //   children: [
                                //     DottedBorder(
                                //       color: colors.buttonColor,
                                //       strokeWidth: 1,
                                //       child: ClipRRect(
                                //         borderRadius: BorderRadius.circular(10),
                                //         child: Container(
                                //           padding: const EdgeInsets.all(15),
                                //           decoration: BoxDecoration(
                                //               color: Color(0xFFD5F6F6),
                                //               borderRadius:
                                //                   BorderRadius.circular(10)),
                                //           child: Column(
                                //             children: [
                                //               Image.asset(
                                //                 Images.selectImage,
                                //                 height: 30,
                                //                 width: 30,
                                //                 fit: BoxFit.fitHeight,
                                //               ),
                                //               Text(
                                //                 "Other Image",
                                //                 style: TextStyle(
                                //                   color: colors.buttonColor,
                                //                   fontSize: 12,
                                //                 ),
                                //               )
                                //             ],
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //     VerticalDivider(color: Colors.transparent),
                                //     Container(
                                //       height: height * .1,
                                //       width: width * .25,
                                //       alignment: Alignment.center,
                                //       decoration: BoxDecoration(
                                //           color: colors.lightGrey,
                                //           borderRadius:
                                //               BorderRadius.circular(10)),
                                //       child: Text(
                                //         "Image\nContainer",
                                //         textAlign: TextAlign.center,
                                //         style: TextStyle(
                                //           color: Colors.black,
                                //           fontSize: 12,
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // const Divider(color: Colors.transparent),
                                // Row(
                                //   children: [
                                //     DottedBorder(
                                //       color: colors.buttonColor,
                                //       strokeWidth: 1,
                                //       child: ClipRRect(
                                //         borderRadius: BorderRadius.circular(10),
                                //         child: Container(
                                //           width: width * .24,
                                //           padding: const EdgeInsets.all(15),
                                //           decoration: BoxDecoration(
                                //               color: Color(0xFFD5F6F6),
                                //               borderRadius:
                                //                   BorderRadius.circular(10)),
                                //           child: Column(
                                //             children: [
                                //               Icon(
                                //                   Icons
                                //                       .play_circle_outline_rounded,
                                //                   color: colors.buttonColor,
                                //                   size: 25),
                                //               Text(
                                //                 "Video",
                                //                 style: TextStyle(
                                //                   color: colors.buttonColor,
                                //                   fontSize: 12,
                                //                 ),
                                //               )
                                //             ],
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //     VerticalDivider(color: Colors.transparent),
                                //     Container(
                                //       height: height * .1,
                                //       width: width * .25,
                                //       alignment: Alignment.center,
                                //       decoration: BoxDecoration(
                                //           color: colors.lightGrey,
                                //           borderRadius:
                                //               BorderRadius.circular(10)),
                                //       child: Text(
                                //         "Video\nContainer",
                                //         textAlign: TextAlign.center,
                                //         style: TextStyle(
                                //           color: Colors.black,
                                //           fontSize: 12,
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),

                                const Divider(color: Colors.transparent),
                                Row(
                                  children: [
                                    Checkbox(
                                        value: freeDelivery,
                                        onChanged: (val) {
                                          setState(() {
                                            freeDelivery = val!;
                                          });
                                        }),
                                    Text("Free Delivery"),
                                    Checkbox(
                                        value: cancellable,
                                        onChanged: (val) {
                                          setState(() {
                                            cancellable = val!;
                                          });
                                        }),
                                    Text("Returnable / Cancellable"),
                                  ],
                                ),
                                const Divider(
                                    color: Colors.transparent, height: 5),
                                // Row(
                                //   children: [
                                //     SizedBox(
                                //       width: width * .78,
                                //       child: TextFormField(
                                //         decoration: (const InputDecoration())
                                //             .applyDefaults(Theme.of(context)
                                //                 .inputDecorationTheme)
                                //             .copyWith(labelText: "Coupon"),
                                //       ),
                                //     ),
                                //     Switch(
                                //       value: switchVal,
                                //       activeColor: colors.buttonColor,
                                //       inactiveThumbColor: colors.greyText,
                                //       inactiveTrackColor: colors.lightGrey,
                                //       onChanged: (value) => setState(() {
                                //         switchVal = value;
                                //       }),
                                //     )
                                //   ],
                                // ),
                                const Divider(color: Colors.transparent),
                                TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  controller: warranty,
                                  decoration: (const InputDecoration())
                                      .applyDefaults(Theme.of(context)
                                          .inputDecorationTheme)
                                      .copyWith(
                                          labelText: "Warranty",
                                          hintText: "Ex: 1 Year"),
                                ),
                                const Divider(color: Colors.transparent),
                                TextFormField(
                                  controller: manufacturing,
                                  readOnly: true,
                                  decoration: (const InputDecoration())
                                      .applyDefaults(Theme.of(context)
                                          .inputDecorationTheme)
                                      .copyWith(
                                        labelText: "Manufacturing Date",
                                        disabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        suffixIcon: IconButton(
                                            onPressed: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.parse(
                                                              manufacturing
                                                                  .text),
                                                      firstDate: DateTime(
                                                          1900), //DateTime.now() - not to allow to choose before today.
                                                      lastDate: DateTime.now());
                                              if (pickedDate != null) {
                                                print(
                                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                String formattedDate =
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(pickedDate);
                                                print(
                                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                                //you can implement different kind of Date Format here according to your requirement

                                                setState(() {
                                                  manufacturing.text =
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
                                // const Divider(color: Colors.transparent),
                                // DropdownButtonFormField2(
                                //   decoration: const InputDecoration()
                                //       .applyDefaults(Theme.of(context)
                                //           .inputDecorationTheme)
                                //       .copyWith(
                                //           enabledBorder: OutlineInputBorder(
                                //               borderRadius:
                                //                   BorderRadius.circular(10),
                                //               borderSide: BorderSide(
                                //                 color: colors.lightGrey,
                                //               )),
                                //           contentPadding:
                                //               EdgeInsets.only(right: 10)),
                                //   hint: Text("Simple Product",
                                //       style: TextStyle(
                                //           color: colors.greyText,
                                //           fontWeight: FontWeight.normal)),
                                //   value: selectedValue,
                                //   items: Taxitems,
                                // ),
                                const Divider(color: Colors.transparent),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: priceCtrl,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  maxLength: 7,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter price";
                                    }
                                    return null;
                                  },
                                  decoration: (const InputDecoration())
                                      .applyDefaults(Theme.of(context)
                                          .inputDecorationTheme)
                                      .copyWith(
                                          labelText: "Price", counterText: ""),
                                ),
                                const Divider(color: Colors.transparent),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  maxLength: 7,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: (const InputDecoration())
                                      .applyDefaults(Theme.of(context)
                                          .inputDecorationTheme)
                                      .copyWith(
                                          labelText: "Purchase Price",
                                          counterText: ""),
                                  controller: PurchaceCtrl,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter total allowed quantity";
                                    }
                                    return null;
                                  },
                                ),
                                const Divider(color: Colors.transparent),
                                DropdownButtonFormField2(
                                  decoration: const InputDecoration()
                                      .applyDefaults(Theme.of(context)
                                          .inputDecorationTheme)
                                      .copyWith(
                                          contentPadding:
                                              EdgeInsets.only(right: 10)),
                                  hint: Text("Discount",
                                      style: TextStyle(
                                          color: colors.greyText,
                                          fontWeight: FontWeight.normal)),
                                  value: selectedDiscount,
                                  onChanged: (value) => setState(() {
                                    selectedDiscount = value ?? "";
                                  }),
                                  items: discountItems,
                                ),
                                const Divider(color: Colors.transparent),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  maxLength:
                                      selectedDiscount == 'percent' ? 2 : 7,
                                  controller: discountPriceCtrl,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter discount price";
                                    }
                                    return null;
                                  },
                                  decoration: (const InputDecoration())
                                      .applyDefaults(Theme.of(context)
                                          .inputDecorationTheme)
                                      .copyWith(
                                          labelText: "Discount",
                                          counterText: ""),
                                ),
                                const Divider(color: Colors.transparent),
                              ],
                            ),
                          )),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (selectedDiscount!.isNotEmpty &&
                                  selectedPtype!.isNotEmpty &&
                                  selectedTax!.isNotEmpty &&
                                  selectedUnit!.isNotEmpty) {
                                print(nameCtrl.text);
                                print(productProvider.selectedCat?.id);
                                print(productProvider.selectedSubCat?.id);
                                print(selectedPtype);
                                print(qtyInStockCtrl.text);
                                print(skuIdCtrl.text);
                                print(shippingCtrl.text);
                                print(selectedTax);
                                print(TaxCtrl.text);
                                print(PurchaceCtrl.text);
                                print(minQtyCtrl.text);
                                if (!isFromFile) {
                                  List<String> url = image!.split("/");
                                  image = url.last;
                                }
                                print(image);
                                print(productProvider.selectedBrand?.id);
                                print(priceCtrl.text);
                                print(selectedDiscount);
                                print(discountPriceCtrl.text);
                                print(descCtrl.text.toString());
                                productProvider
                                    .updateProduct(
                                  productId: widget.productDetail.id.toString(),
                                  name: nameCtrl.text.toString(),
                                  category_id: productProvider.selectedCat!.id
                                      .toString(),
                                  sub_category_id: productProvider
                                      .selectedSubCat!.id
                                      .toString(),
                                  sub_sub_category_id: productProvider
                                      .selectedSubSubCat!.id
                                      .toString(),
                                  product_type: selectedPtype.toString(),
                                  unit: selectedUnit.toString(),
                                  thumbnail: image.toString(),
                                  discount_type: selectedDiscount.toString(),
                                  discount: discountPriceCtrl.text.toString(),
                                  tax: TaxCtrl.text.toString(),
                                  tax_type: selectedTax.toString(),
                                  unit_price: priceCtrl.text
                                      .toString()
                                      .replaceAll(RegExp('[^A-Za-z0-9.]'), ""),
                                  shipping_cost: shippingCtrl.text.toString(),
                                  skuId: skuIdCtrl.text.toString(),
                                  minimum_order_qty: minQtyCtrl.text.toString(),
                                  brand_id:
                                      productProvider.selectedBrand == null
                                          ? ""
                                          : productProvider.selectedBrand!.id
                                              .toString(),
                                  quantity: qtyInStockCtrl.text.toString(),
                                  description: descCtrl.text.toString(),
                                  purchase_price: PurchaceCtrl.text
                                      .toString()
                                      .replaceAll(RegExp('[^A-Za-z0-9.]'), ""),
                                  warranty: warranty.text.isEmpty
                                      ? " "
                                      : warranty.text.toString(),
                                  manufacturing: manufacturing.text.toString(),
                                  returnable: cancellable ? "1" : '0',
                                  freeDelivery: freeDelivery ? '1' : '0',
                                )
                                    .then((value) {
                                  if (value) {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.success,
                                      animType: AnimType.scale,
                                      autoDismiss: false,
                                      onDismissCallback: (type) {},
                                      title: "Product Updated Successfully",
                                      btnOkOnPress: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                    )..show();
                                  } else {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      animType: AnimType.scale,
                                      autoDismiss: false,
                                      onDismissCallback: (type) {},
                                      title: "Something went wrong!",
                                      btnOkColor: Colors.red,
                                      btnOkOnPress: () =>
                                          Navigator.pop(context),
                                    )..show();
                                  }
                                });
                              } else {
                                Utils.showTost(msg: "Some Fields Are Missing!");
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(width, 50),
                              backgroundColor: colors.buttonColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Text(
                            "UPDATE PRODUCT",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      Divider(color: Colors.transparent),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
