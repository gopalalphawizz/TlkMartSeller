import 'package:alpha_work/Model/productManagementModel.dart';
import 'package:alpha_work/Utils/appUrls.dart';
import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/shared_pref..dart';
import 'package:alpha_work/Utils/utils.dart';
import 'package:alpha_work/View/Product/model/brandModel.dart';
import 'package:alpha_work/View/Product/model/categoryModel.dart';
import 'package:alpha_work/View/Product/model/productDetailModel.dart';
import 'package:alpha_work/View/Product/model/productListModel.dart';
import 'package:alpha_work/repository/productMgmtEepository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class ProductManagementViewModel extends ChangeNotifier {
  final _myRepo = ProductManagementRepository();
  late ManagementData productManagementData;
  List<ProductData> productList = [];
  List<CategoryData> categories = [];
  List<CategoryData> subcategories = [];
  List<CategoryData> subsubcategories = [];
  List<BrandData> brandList = [];
  List<Product> productDetail = [];
  List<ProductData> lowStock = [];
  List<ProductData> outOfStock = [];
  bool isLoading = true;
  CategoryData? selectedCat;
  CategoryData? selectedSubCat;
  CategoryData? selectedSubSubCat;
  BrandData? selectedBrand;
  final List<ProductData> selectedAdProducts = [];
  String thumbnail = '';
  bool get loading => isLoading;
  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  setCategory(CategoryData? value) {
    selectedCat = value;
    print('country${selectedCat!.name}');
    selectedSubCat = null;
    subcategories.clear();
    selectedSubSubCat = null;
    subsubcategories.clear();
    notifyListeners();
  }

  setSubCategory(CategoryData? value) {
    selectedSubCat = value;
    print(selectedSubCat!.name);
    selectedSubSubCat = null;
    subsubcategories.clear();
    notifyListeners();
  }

  setSubSubCategory(CategoryData? value) {
    selectedSubSubCat = value;
    print(selectedSubSubCat!.name);
    notifyListeners();
  }

  setBrand(var value) {
    selectedBrand = value;
    notifyListeners();
  }

//Function to get productmgmt list
  Future<void> getProductManagement() async {
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    isLoading = true;
    await _myRepo.ProductMgmtDataRequest(
            api: AppUrl.productMgmt, bearerToken: token)
        .then((value) {
      productManagementData = value.data!;

      setLoading(false);
    }).onError((error, stackTrace) => setLoading(false));
  }

//Function to get Product list based on status (Active,Inactive,All)
  Future<void> getProductsListWithStatus({
    required String Type,
    required String? stockType,
  }) async {
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);

    isLoading = true;
    await _myRepo.ProductListRequest(
            api: AppUrl.productList,
            bearerToken: token,
            type: Type,
            cat: null,
            stockType: stockType,
            subcat: null,
            isCat: false)
        .then((value) {
      if (stockType == "low_stock") {
        lowStock = value.data;
        print("Low list length ${lowStock.length}");
      } else if (stockType == "out_of_stock") {
        outOfStock = value.data;
        print("out list length ${outOfStock.length}");
      } else {
        productList = value.data;
        print("Product list length ${productList.length}");
      }

      setLoading(false);
    }).onError((error, stackTrace) => setLoading(false));
  }

//Function to get Product list based on cat and subcat id
  Future<void> getProductsListWithCategory({
    required String Type,
    required String catId,
    required String subcatId,
  }) async {
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    print(Type);
    isLoading = true;
    await _myRepo.ProductListRequest(
            api: AppUrl.productList,
            bearerToken: token,
            cat: catId,
            subcat: subcatId,
            stockType: "",
            type: Type,
            isCat: true)
        .then((value) {
      productList = value.data;
      print("Product list length ${productList.length}");
      setLoading(false);
    }).onError((error, stackTrace) => setLoading(false));
  }

//Function to get category with id
  Future<void> getCategory({required String id}) async {
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    await _myRepo
        .categoryListRequest(
            api: AppUrl.categoriesList, bearerToken: token, id: id)
        .then((value) {
      categories = value.data;
      print("here");
      print(categories.length);
      setLoading(false);
    }).onError((error, stackTrace) => setLoading(false));
  }

  //Function to get category with id
  Future<void> getsubCategory({required String id}) async {
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    await _myRepo
        .categoryListRequest(
            api: AppUrl.categoriesList, bearerToken: token, id: id)
        .then((value) {
      subcategories = value.data;
      print(subcategories.length);
      setLoading(false);
    }).onError((error, stackTrace) => setLoading(false));
  }

  //Function to get category with id
  Future<void> getsubsubCategory({required String id}) async {
    await _myRepo
        .categoryListRequest(
            api: AppUrl.categoriesList, bearerToken: AppUrl.apitoken, id: id)
        .then((value) {
      subsubcategories = value.data;
      print("here");
      print(categories.length);
      setLoading(false);
    }).onError((error, stackTrace) => setLoading(false));
  }

//Funcation to get brand data
  Future<void> getBrandList() async {
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    await _myRepo
        .brandListRequest(
      api: AppUrl.brandList,
      bearerToken: token,
    )
        .then((value) {
      brandList = value.data;

      print("Btand list  ${brandList.length}");
      setLoading(false);
    }).onError((error, stackTrace) => setLoading(false));
  }

//Function to upload Image
  Future<void> getImageUrl({required String path}) async {
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    await _myRepo
        .uploadImage(path: path, api: AppUrl.imageUpload, token: token)
        .then((value) {
      thumbnail = value;
    });
  }

//Function to add product
  Future<bool> appProduct({
    required String name,
    required String category_id,
    required String sub_category_id,
    required String product_type,
    required String unit,
    required String thumbnail,
    required String discount_type,
    required String discount,
    required String tax,
    required String tax_type,
    required String unit_price,
    required String shipping_cost,
    required String skuId,
    required String minimum_order_qty,
    required String brand_id,
    required String quantity,
    required String description,
    required String purchase_price,
    required String freeDelivery,
    required String returnable,
    required String manufacturing,
    required String warranty,
    required String sub_sub_category_id,
  }) async {
    bool status = false;
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    await _myRepo
        .addProductPostRequest(
          token: token,
          sub_sub_category_id: sub_sub_category_id,
          api: AppUrl.addProduct,
          name: name,
          category_id: category_id,
          sub_category_id: sub_category_id,
          product_type: product_type,
          unit: unit,
          thumbnail: thumbnail,
          discount_type: discount_type,
          discount: discount,
          tax: tax,
          tax_type: tax_type,
          unit_price: unit_price,
          shipping_cost: shipping_cost,
          skuId: skuId,
          minimum_order_qty: minimum_order_qty,
          brand_id: brand_id,
          quantity: quantity,
          description: description,
          purchase_price: purchase_price,
          freeDelivery: freeDelivery,
          manufacturing: manufacturing,
          returnable: returnable,
          warranty: warranty,
        )
        .then((value) => status = value);
    return status;
  }

//Funtion to get product details
  Future<void> getProductDetail({required String id}) async {
    isLoading = true;
    productDetail.clear();
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    await _myRepo
        .productDetailGetRequest(
            api: AppUrl.productDetailAndedit, bearerToken: token, id: id)
        .then((value) {
      print(value.product.length);
      productDetail = value.product;
      setLoading(false);
    }).onError((error, stackTrace) => setLoading(false));
  }

//Function to update product status (Active,Inactive)
  Future<void> updateProductStatus(
      {required String id, required String status}) async {
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    // setLoading(true);
    await _myRepo
        .productStatusUpdateGetRequest(
            api: AppUrl.statusUpdate,
            bearerToken: token,
            status: status,
            id: id)
        .then((value) => print(value))
        .then((value) => setLoading(false));
  }

//Function to delete Product
  Future<bool> deleteProduct({required String id}) async {
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    bool val = false;
    await _myRepo
        .deleteProductPostRequest(
            api: AppUrl.deleteProduct, bearerToken: token, id: id)
        .then((value) => val = value)
        .then((value) => setLoading(false));
    return val;
  }

//Function to add product
  Future<bool> updateProduct({
    required String productId,
    required String name,
    required String category_id,
    required String sub_category_id,
    required String product_type,
    required String unit,
    required String thumbnail,
    required String discount_type,
    required String discount,
    required String tax,
    required String tax_type,
    required String unit_price,
    required String shipping_cost,
    required String skuId,
    required String minimum_order_qty,
    required String brand_id,
    required String quantity,
    required String description,
    required String purchase_price,
    required String freeDelivery,
    required String returnable,
    required String manufacturing,
    required String warranty,
    required String sub_sub_category_id,
  }) async {
    bool status = false;
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    print('${productId}------');
    await _myRepo
        .updateProductPostRequest(
          token: token,
          api: '${AppUrl.updateProduct}/$productId',
          name: name,
          category_id: category_id,
          sub_category_id: sub_category_id,
          sub_sub_category_id: sub_sub_category_id,
          product_type: product_type,
          unit: unit,
          thumbnail: thumbnail,
          discount_type: discount_type,
          discount: discount,
          tax: tax,
          tax_type: tax_type,
          unit_price: unit_price,
          shipping_cost: shipping_cost,
          skuId: skuId,
          minimum_order_qty: minimum_order_qty,
          brand_id: brand_id,
          quantity: quantity,
          description: description,
          purchase_price: purchase_price,
          freeDelivery: freeDelivery,
          manufacturing: manufacturing,
          returnable: returnable,
          warranty: warranty,
        )
        .then((value) => status = value);
    return status;
  }

//Function to request category
  Future<void> RequestCategory({
    required String catName,
    required String subcatName,
    required BuildContext context,
    required String subSubName,
  }) async {
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    await _myRepo
        .addCategoryPostRequest(
            api: AppUrl.RequestCategory,
            bearerToken: token,
            catName: catName,
            subcatName: subcatName,
            subSubName: subSubName)
        .then(
          (value) => Fluttertoast.showToast(
            msg: value['message'],
            backgroundColor: colors.buttonColor,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
          ),
        )
        .then((value) => setLoading(false));
  }

//Function to update product Stock
  Future<bool> updateStock({
    required quantity,
    required productId,
  }) async {
    bool val = false;
    String token = PreferenceUtils.getString(PrefKeys.jwtToken);
    await _myRepo
        .updateStockGetRequest(
            token: token,
            api: "${AppUrl.updateStock}$productId",
            quantity: quantity)
        .then((value) {
      Utils.showTost(msg: value['message'].toString());
      val = value['status'];
      setLoading(false);
    });
    return val;
  }
}
