class ProductDetailModel {
  ProductDetailModel({
    required this.status,
    required this.message,
    required this.product,
  });

  final bool? status;
  final String? message;
  final List<Product> product;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      status: json["status"],
      message: json["message"],
      product: json["product"] == null
          ? []
          : List<Product>.from(
              json["product"]!.map((x) => Product.fromJson(x))),
    );
  }
}

class Product {
  Product({
    required this.id,
    required this.addedBy,
    required this.userId,
    required this.name,
    required this.slug,
    required this.productType,
    required this.categoryIds,
    required this.categoryId,
    required this.subCategoryId,
    required this.subSubCategoryId,
    required this.brandId,
    required this.unit,
    required this.minQty,
    required this.refundable,
    required this.digitalProductType,
    required this.digitalFileReady,
    required this.images,
    required this.colorImage,
    required this.thumbnail,
    required this.featured,
    required this.flashDeal,
    required this.videoProvider,
    required this.videoUrl,
    required this.colors,
    required this.variantProduct,
    required this.attributes,
    required this.choiceOptions,
    required this.variation,
    required this.published,
    required this.unitPrice,
    required this.purchasePrice,
    required this.tax,
    required this.taxType,
    required this.taxModel,
    required this.discount,
    required this.discountType,
    required this.discountPrice,
    required this.currentStock,
    required this.minimumOrderQty,
    required this.details,
    required this.freeShipping,
    required this.attachment,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.featuredStatus,
    required this.metaTitle,
    required this.metaDescription,
    required this.metaImage,
    required this.requestStatus,
    required this.deniedNote,
    required this.shippingCost,
    required this.multiplyQty,
    required this.tempShippingCost,
    required this.isShippingCostUpdated,
    required this.code,
    required this.shop,
    required this.colorsFormatted,
    required this.weight,
    required this.specialPrice,
    required this.taxAmount,
    required this.reviewsCount,
    required this.rating,
    required this.tags,
    required this.translations,
    required this.shareLink,
    required this.reviews,
    required this.isFavorite,
    required this.isCart,
    required this.cartId,
    required this.manufacturingDate,
    required this.madeIn,
    required this.shortDescription,
    required this.specification,
    required this.warranty,
    required this.useCoinsWithAmount,
    required this.amountAfterCoinUse,
    required this.freeDelivery,
    required this.returnable,
  });

  final int? id;
  final String? addedBy;
  final int? userId;
  final String? name;
  final String? slug;
  final String? productType;
  final List<CategoryId> categoryIds;
  final String? categoryId;
  final String? subCategoryId;
  final String? subSubCategoryId;
  final int? brandId;
  final String? unit;
  final int? minQty;
  final int? refundable;
  final String? digitalProductType;
  final String? digitalFileReady;
  final List<String> images;
  final List<dynamic> colorImage;
  final String? thumbnail;
  final int? featured;
  final int? flashDeal;
  final String? videoProvider;
  final String? videoUrl;
  final List<dynamic> colors;
  final int? variantProduct;
  final List<dynamic> attributes;
  final List<dynamic> choiceOptions;
  final List<dynamic> variation;
  final int? published;
  final String? unitPrice;
  final String? purchasePrice;
  final int? tax;
  final String? taxType;
  final String? taxModel;
  final int? discount;
  final String? discountType;
  final String? discountPrice;
  final int? currentStock;
  final int? minimumOrderQty;
  final String? details;
  final int? freeShipping;
  final String? attachment;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? status;
  final int? featuredStatus;
  final String? metaTitle;
  final String? metaDescription;
  final String? metaImage;
  final int? requestStatus;
  final String? deniedNote;
  final String? shippingCost;
  final int? multiplyQty;
  final int? tempShippingCost;
  final int? isShippingCostUpdated;
  final String? code;
  final Shop? shop;
  final List<dynamic> colorsFormatted;
  final String? weight;
  final String? specialPrice;
  final String? taxAmount;
  final int? reviewsCount;
  final List<dynamic> rating;
  final List<dynamic> tags;
  final List<dynamic> translations;
  final String? shareLink;
  final List<dynamic> reviews;
  final bool? isFavorite;
  final bool? isCart;
  final int? cartId;
  final String? manufacturingDate;
  final String? madeIn;
  final String? shortDescription;
  final String? specification;
  final String? warranty;
  final String? useCoinsWithAmount;
  final String? amountAfterCoinUse;
  final int? freeDelivery;
  final int? returnable;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      addedBy: json["added_by"],
      userId: json["user_id"],
      name: json["name"],
      slug: json["slug"],
      productType: json["product_type"],
      categoryIds: json["category_ids"] == null
          ? []
          : List<CategoryId>.from(
              json["category_ids"]!.map((x) => CategoryId.fromJson(x))),
      categoryId: json["category_id"],
      subCategoryId: json["sub_category_id"],
      subSubCategoryId: json["sub_sub_category_id"],
      brandId: json["brand_id"],
      unit: json["unit"],
      minQty: json["min_qty"],
      refundable: json["refundable"],
      digitalProductType: json["digital_product_type"],
      digitalFileReady: json["digital_file_ready"],
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
      colorImage: json["color_image"] == null
          ? []
          : List<dynamic>.from(json["color_image"]!.map((x) => x)),
      thumbnail: json["thumbnail"],
      featured: json["featured"],
      flashDeal: json["flash_deal"],
      videoProvider: json["video_provider"],
      videoUrl: json["video_url"],
      colors: json["colors"] == null
          ? []
          : List<dynamic>.from(json["colors"]!.map((x) => x)),
      variantProduct: json["variant_product"],
      attributes: json["attributes"] == null
          ? []
          : List<dynamic>.from(json["attributes"]!.map((x) => x)),
      choiceOptions: json["choice_options"] == null
          ? []
          : List<dynamic>.from(json["choice_options"]!.map((x) => x)),
      variation: json["variation"] == null
          ? []
          : List<dynamic>.from(json["variation"]!.map((x) => x)),
      published: json["published"],
      unitPrice: json["unit_price"],
      purchasePrice: json["purchase_price"],
      tax: json["tax"],
      taxType: json["tax_type"],
      taxModel: json["tax_model"],
      discount: json["discount"],
      discountType: json["discount_type"],
      discountPrice: json["discount_price"],
      currentStock: json["current_stock"],
      minimumOrderQty: json["minimum_order_qty"],
      details: json["details"],
      freeShipping: json["free_shipping"],
      attachment: json["attachment"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      status: json["status"],
      featuredStatus: json["featured_status"],
      metaTitle: json["meta_title"],
      metaDescription: json["meta_description"],
      metaImage: json["meta_image"],
      requestStatus: json["request_status"],
      deniedNote: json["denied_note"],
      shippingCost: json["shipping_cost"].toString(),
      multiplyQty: json["multiply_qty"],
      tempShippingCost: json["temp_shipping_cost"],
      isShippingCostUpdated: json["is_shipping_cost_updated"],
      code: json["code"],
      shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
      colorsFormatted: json["colors_formatted"] == null
          ? []
          : List<dynamic>.from(json["colors_formatted"]!.map((x) => x)),
      weight: json["weight"],
      specialPrice: json["special_price"],
      taxAmount: json["tax_amount"],
      reviewsCount: json["reviews_count"],
      rating: json["rating"] == null
          ? []
          : List<dynamic>.from(json["rating"]!.map((x) => x)),
      tags: json["tags"] == null
          ? []
          : List<dynamic>.from(json["tags"]!.map((x) => x)),
      translations: json["translations"] == null
          ? []
          : List<dynamic>.from(json["translations"]!.map((x) => x)),
      shareLink: json["share_link"],
      reviews: json["reviews"] == null
          ? []
          : List<dynamic>.from(json["reviews"]!.map((x) => x)),
      isFavorite: json["is_favorite"],
      isCart: json["is_cart"],
      cartId: json["cart_id"],
      manufacturingDate: json["manufacturing_date"],
      madeIn: json["made_in"],
      shortDescription: json["short_description"],
      specification: json["specification"],
      warranty: json["warranty"],
      useCoinsWithAmount: json["use_coins_with_amount"],
      amountAfterCoinUse: json["amount_after_coin_use"],
      freeDelivery: json['free_delivery'],
      returnable: json['returnable'],
    );
  }
}

class CategoryId {
  CategoryId({
    required this.id,
    required this.position,
  });

  final String? id;
  final int? position;

  factory CategoryId.fromJson(Map<String, dynamic> json) {
    return CategoryId(
      id: json["id"],
      position: json["position"],
    );
  }
}

class Shop {
  Shop({
    required this.id,
    required this.sellerId,
    required this.name,
    required this.address,
    required this.contact,
    required this.image,
    required this.bottomBanner,
    required this.vacationStartDate,
    required this.vacationEndDate,
    required this.vacationNote,
    required this.vacationStatus,
    required this.temporaryClose,
    required this.createdAt,
    required this.updatedAt,
    required this.rating,
    required this.followers,
    required this.isVerified,
    required this.isFollowing,
    required this.banner,
    required this.productCount,
  });

  final String? id;
  final String? sellerId;
  final String? name;
  final String? address;
  final String? contact;
  final String? image;
  final String? bottomBanner;
  final String? vacationStartDate;
  final String? vacationEndDate;
  final String? vacationNote;
  final int? vacationStatus;
  final int? temporaryClose;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? rating;
  final String? followers;
  final String? isVerified;
  final String? isFollowing;
  final String? banner;
  final String? productCount;

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json["id"],
      sellerId: json["seller_id"],
      name: json["name"],
      address: json["address"],
      contact: json["contact"],
      image: json["image"],
      bottomBanner: json["bottom_banner"],
      vacationStartDate: json["vacation_start_date"],
      vacationEndDate: json["vacation_end_date"],
      vacationNote: json["vacation_note"],
      vacationStatus: json["vacation_status"],
      temporaryClose: json["temporary_close"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      rating: json["rating"],
      followers: json["followers"],
      isVerified: json["is_verified"],
      isFollowing: json["is_following"],
      banner: json["banner"],
      productCount: json["product_count"],
    );
  }
}
