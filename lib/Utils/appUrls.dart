// ignore_for_file: file_names
class AppUrl {
  static const baseURL =
      "https://tlk-mart.alphawizzserver.com/api/v2/";
  static const baseURL1 =
      "https://tlk-mart.alphawizzserver.com/api/v1/";

  static const apitoken = '';

  static String sendLoginOtp = "${baseURL}auth/send-login-otp";
  static String sendRegisterOtp = "${baseURL}auth/send-otp";
  static String getSellerDashboard = "${baseURL1}seller/dashboard";

  static String getProfile = "${baseURL}customer/info";
  static String updateProfile = "${baseURL}customer/update-profile";

  static String languages = "${baseURL}languages";
  static String currencies = "${baseURL}currencies";

  static String brands = "${baseURL}brands";
  static String specialOffers = "${baseURL}offers/special-offers";
  static String dailyDeals = "${baseURL}deal-of-the-day";
  static String productsList = "${baseURL}products";
  static String categories = "${baseURL}categories";
  static String banners = "${baseURL}banners?banner_type=";

  static String wishlist = "${baseURL}customer/wish-list";

  static String addToWishlist = "${baseURL}customer/wish-list/add";
  static String removeFromWishlist = "${baseURL}customer/wish-list/remove";

  static String cartList = "${baseURL}cart?coupan=";

  static String addToCart = "${baseURL}cart/add";
  static String removeFromCart = "${baseURL}cart/remove";
  static String updateCart = "${baseURL}cart/update";
  static String applyCoupon = "${baseURL}coupon/apply?code=";
  static String placeOrder = "${baseURL}customer/order/place?";

  static String savedList = "${baseURL}customer/save-list";
  static String addToSaveLater = "${baseURL}customer/save-list/add";
  static String removeFromSaveLater = "${baseURL}customer/save-list/remove";

  static String couponList = "${baseURL}coupon";

  static String vendorList = "${baseURL}seller/all";

  static String addressList = "${baseURL}customer/address/list";
  static String addAddressList = "${baseURL}customer/address/add";
  static String updateAddressList = "${baseURL}customer/address/update";
  static String deleteAddress = "${baseURL}customer/address?address_id=";

  static String contactForm = "${baseURL}contact/store";
//Vendor
  static const String loginOtp = "${baseURL}seller/login-otp";
  static const String loginWithEmailPassword = "${baseURL}seller/auth/login";
  static const String registerOtp = "${baseURL}seller/send-otp";
  static const String register = "${baseURL}seller/registration";
  static const String productMgmt = "${baseURL}seller/product-management";
  static const String productList = "${baseURL}seller/products/list";
  static const String categoriesList = "${baseURL}seller/get-categories";
  static const String brandList = "${baseURL}seller/brands";
  static const String imageUpload = "${baseURL}seller/products/upload-images";
  static const String addProduct = "${baseURL}seller/products/add";
  static const String dashboardData = "${baseURL}seller/dashboard";
  static const String orderList = "${baseURL}seller/orders/list";
  static const String productDetailAndedit = "${baseURL}seller/products/edit/";
  static const String statusUpdate = "${baseURL}seller/products/status-update";
  static const String deleteProduct = "${baseURL}seller/products/delete/";
  static const String updateProduct = "${baseURL}seller/products/update";
  static const String vendorProfile = "${baseURL}seller/shop-info";
  static const String RequestCategory =
      "${baseURL}seller/request-category-name";
  static const String updateBusinessDetail =
      "${baseURL}seller/update-bussiness-details";
  static const String updatePassword = '${baseURL}seller/update-password';
  static const String updateAddressDetail =
      "${baseURL}seller/update-address-details";
  static const String updateBankingDetail =
      "${baseURL}seller/update-bank-details";
  static const String updateProfileDetail = "${baseURL}seller/update-profile";
  static const String staticPage = '${baseURL}seller/static-pages';
  static const String Customers = '${baseURL}seller/customers';
  static const String DeliveryMan = '${baseURL}seller/seller-delivery-man';
  static const String updateOrderStatus =
      '${baseURL}seller/orders/order-detail-status/';
  static const String assignDriver =
      '${baseURL}seller/orders/assign-delivery-man';
  static const String withdrawRequest = '${baseURL}seller/balance-withdraw';
  static const String purchasePlan = '${baseURL}seller/purchase-plan';
  static const String transactions = '${baseURL}seller/transactions';
  static const String Ordertransactions =
      '${baseURL}seller/orders/transaction-list';
  static const String getSubscription = '${baseURL}seller/plans';
  static const String buySubscription = '${baseURL}seller/purchase-plan';
  static const String updateStoreDetail =
      '${baseURL}seller/update-store-details';
  static const String getAdvert = '${baseURL}seller/get-advertisement';
  static const String getSupportQueries = '${baseURL}seller/support-ticket/get';
  static const String referral = '${baseURL}seller/get-referrals';
  static const String orderStatusUpdate =
      '${baseURL}seller/orders/order-detail-status/';
  static const String getCountries = '${baseURL1}countries';
  static const String getStates = '${baseURL1}states';
  static const String getCities = '${baseURL1}cities';
  static const String supportChat = '${baseURL}seller/support-ticket/conv/';
  static const String supportChatReply =
      '${baseURL}seller/support-ticket/reply/';
  static const String updateStock = '${baseURL}seller/products/update-stock/';
  static const String ratingReview = '${baseURL}seller/rating_n_reviews';
  static const String ReviewDetail = '${baseURL}seller/review_details';
  static const String buyAdvert = '${baseURL}seller/purchase-advertisement';
  static const String forgetPassOtp = '${baseURL}seller/auth/forgot-password';
  static const String ResetPassword = '${baseURL}seller/auth/reset-password';
  static const String Notification = '${baseURL}seller/notifications';
  static const String OrderReport = '${baseURL}seller/orders-report';
  static const String DeactivateAcc = '${baseURL}seller/account-delete';
  static const String uploadBanner = '${baseURL}seller/purchase-advertisement';
  static const String adgetRequest =
      "${baseURL}seller/get-request-advertisement";
}
