class CustomerModel {
  CustomerModel({
    required this.status,
    required this.message,
    required this.data,
    required this.errors,
  });

  final bool? status;
  final String? message;
  final List<CustomerData> data;
  final List<dynamic> errors;

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<CustomerData>.from(
              json["data"]!.map((x) => CustomerData.fromJson(x))),
      errors: json["errors"] == null
          ? []
          : List<dynamic>.from(json["errors"]!.map((x) => x)),
    );
  }
}

class CustomerData {
  CustomerData({
    required this.id,
    required this.fName,
    required this.email,
    required this.phone,
    required this.streetAddress,
    required this.country,
    required this.state,
    required this.city,
    required this.zip,
    required this.image,
    required this.products,
  });

  final int? id;
  final String? fName;
  final String? email;
  final String? phone;
  final String? streetAddress;
  final String? country;
  final String? state;
  final String? city;
  final String? zip;
  final String? image;
  final List<Product> products;

  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
      id: json["id"],
      fName: json["f_name"],
      email: json["email"],
      phone: json["phone"],
      streetAddress: json["street_address"],
      country: json["country"],
      state: json["state"],
      city: json["city"],
      zip: json["zip"],
      image: json["image"],
      products: json["products"] == null
          ? []
          : List<Product>.from(
              json["products"]!.map((x) => Product.fromJson(x))),
    );
  }
}

class Product {
  Product({
    required this.id,
    required this.categoryIds,
    required this.userId,
    required this.shop,
    required this.name,
    required this.slug,
    required this.images,
    required this.colorImage,
    required this.thumbnail,
    required this.brandId,
    required this.unit,
    required this.minQty,
    required this.featured,
    required this.refundable,
    required this.variantProduct,
    required this.attributes,
    required this.choiceOptions,
    required this.variation,
    required this.weight,
    required this.published,
    required this.unitPrice,
    required this.specialPrice,
    required this.purchasePrice,
    required this.tax,
    required this.taxType,
    required this.taxModel,
    required this.taxAmount,
    required this.discount,
    required this.discountType,
    required this.currentStock,
    required this.minimumOrderQty,
    required this.freeShipping,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.featuredStatus,
    required this.metaTitle,
    required this.metaDescription,
    required this.metaImage,
    required this.requestStatus,
    required this.shippingCost,
    required this.multiplyQty,
    required this.code,
    required this.reviewsCount,
    required this.rating,
    required this.tags,
    required this.translations,
    required this.shareLink,
    required this.reviews,
    required this.colorsFormatted,
    required this.isFavorite,
    required this.isCart,
    required this.cartId,
    required this.manufacturingDate,
    required this.madeIn,
    required this.warranty,
    required this.useCoinsWithAmount,
    required this.amountAfterCoinUse,
  });

  final int? id;
  final List<CategoryId> categoryIds;
  final int? userId;
  final Shop? shop;
  final String? name;
  final String? slug;
  final List<String> images;
  final List<ColorImage> colorImage;
  final String? thumbnail;
  final int? brandId;
  final String? unit;
  final int? minQty;
  final int? featured;
  final String? refundable;
  final int? variantProduct;
  final List<int> attributes;
  final List<ChoiceOption> choiceOptions;
  final List<Variation> variation;
  final String? weight;
  final int? published;
  final String? unitPrice;
  final String? specialPrice;
  final String? purchasePrice;
  final int? tax;
  final String? taxType;
  final String? taxModel;
  final String? taxAmount;
  final int? discount;
  final String? discountType;
  final int? currentStock;
  final int? minimumOrderQty;
  final int? freeShipping;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? status;
  final int? featuredStatus;
  final String? metaTitle;
  final String? metaDescription;
  final String? metaImage;
  final int? requestStatus;
  final String? shippingCost;
  final int? multiplyQty;
  final String? code;
  final int? reviewsCount;
  final List<dynamic> rating;
  final List<Tag> tags;
  final List<dynamic> translations;
  final String? shareLink;
  final List<dynamic> reviews;
  final List<ColorsFormatted> colorsFormatted;
  final bool? isFavorite;
  final bool? isCart;
  final int? cartId;
  final DateTime? manufacturingDate;
  final String? madeIn;
  final String? warranty;
  final String? useCoinsWithAmount;
  final String? amountAfterCoinUse;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      categoryIds: json["category_ids"] == null
          ? []
          : List<CategoryId>.from(
              json["category_ids"]!.map((x) => CategoryId.fromJson(x))),
      userId: json["user_id"],
      shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
      name: json["name"],
      slug: json["slug"],
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
      colorImage: json["color_image"] == null
          ? []
          : List<ColorImage>.from(
              json["color_image"]!.map((x) => ColorImage.fromJson(x))),
      thumbnail: json["thumbnail"],
      brandId: json["brand_id"],
      unit: json["unit"],
      minQty: json["min_qty"],
      featured: json["featured"],
      refundable: json["refundable"],
      variantProduct: json["variant_product"],
      attributes: json["attributes"] == null
          ? []
          : List<int>.from(json["attributes"]!.map((x) => x)),
      choiceOptions: json["choice_options"] == null
          ? []
          : List<ChoiceOption>.from(
              json["choice_options"]!.map((x) => ChoiceOption.fromJson(x))),
      variation: json["variation"] == null
          ? []
          : List<Variation>.from(
              json["variation"]!.map((x) => Variation.fromJson(x))),
      weight: json["weight"],
      published: json["published"],
      unitPrice: json["unit_price"],
      specialPrice: json["special_price"],
      purchasePrice: json["purchase_price"],
      tax: json["tax"],
      taxType: json["tax_type"],
      taxModel: json["tax_model"],
      taxAmount: json["tax_amount"],
      discount: json["discount"],
      discountType: json["discount_type"],
      currentStock: json["current_stock"],
      minimumOrderQty: json["minimum_order_qty"],
      freeShipping: json["free_shipping"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      status: json["status"],
      featuredStatus: json["featured_status"],
      metaTitle: json["meta_title"],
      metaDescription: json["meta_description"],
      metaImage: json["meta_image"],
      requestStatus: json["request_status"],
      shippingCost: json["shipping_cost"],
      multiplyQty: json["multiply_qty"],
      code: json["code"],
      reviewsCount: json["reviews_count"],
      rating: json["rating"] == null
          ? []
          : List<dynamic>.from(json["rating"]!.map((x) => x)),
      tags: json["tags"] == null
          ? []
          : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
      translations: json["translations"] == null
          ? []
          : List<dynamic>.from(json["translations"]!.map((x) => x)),
      shareLink: json["share_link"],
      reviews: json["reviews"] == null
          ? []
          : List<dynamic>.from(json["reviews"]!.map((x) => x)),
      colorsFormatted: json["colors_formatted"] == null
          ? []
          : List<ColorsFormatted>.from(json["colors_formatted"]!
              .map((x) => ColorsFormatted.fromJson(x))),
      isFavorite: json["is_favorite"],
      isCart: json["is_cart"],
      cartId: json["cart_id"],
      manufacturingDate: DateTime.tryParse(json["manufacturing_date"] ?? ""),
      madeIn: json["made_in"],
      warranty: json["warranty"],
      useCoinsWithAmount: json["use_coins_with_amount"],
      amountAfterCoinUse: json["amount_after_coin_use"],
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

class ChoiceOption {
  ChoiceOption({
    required this.name,
    required this.title,
    required this.options,
  });

  final String? name;
  final String? title;
  final List<String> options;

  factory ChoiceOption.fromJson(Map<String, dynamic> json) {
    return ChoiceOption(
      name: json["name"],
      title: json["title"],
      options: json["options"] == null
          ? []
          : List<String>.from(json["options"]!.map((x) => x)),
    );
  }
}

class ColorImage {
  ColorImage({
    required this.color,
    required this.imageName,
  });

  final String? color;
  final String? imageName;

  factory ColorImage.fromJson(Map<String, dynamic> json) {
    return ColorImage(
      color: json["color"],
      imageName: json["image_name"],
    );
  }
}

class ColorsFormatted {
  ColorsFormatted({
    required this.name,
    required this.code,
  });

  final String? name;
  final String? code;

  factory ColorsFormatted.fromJson(Map<String, dynamic> json) {
    return ColorsFormatted(
      name: json["name"],
      code: json["code"],
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
    );
  }
}

class Tag {
  Tag({
    required this.id,
    required this.tag,
    required this.visitCount,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  final int? id;
  final String? tag;
  final int? visitCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Pivot? pivot;

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json["id"],
      tag: json["tag"],
      visitCount: json["visit_count"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
    );
  }
}

class Pivot {
  Pivot({
    required this.productId,
    required this.tagId,
  });

  final int? productId;
  final int? tagId;

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      productId: json["product_id"],
      tagId: json["tag_id"],
    );
  }
}

class Variation {
  Variation({
    required this.type,
    required this.price,
    required this.sku,
    required this.qty,
  });

  final String? type;
  final String? price;
  final String? sku;
  final int? qty;

  factory Variation.fromJson(Map<String, dynamic> json) {
    return Variation(
      type: json["type"],
      price: json["price"],
      sku: json["sku"],
      qty: json["qty"],
    );
  }
}
