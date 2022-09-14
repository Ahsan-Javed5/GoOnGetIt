class Shop {
  bool? error;
  String? message;
  ShopData? data;

  Shop({this.error, this.message, this.data});

  Shop.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? new ShopData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ShopData {
  int? count;
  List<ShopDataRows>? rows;

  ShopData({this.count, this.rows});

  ShopData.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <ShopDataRows>[];
      json['rows'].forEach((v) {
        rows!.add(new ShopDataRows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopDataRows {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? certificateNo;
  String? address;
  String? lat;
  String? long;
  String? shopLogo;
  bool? isApproved;
  String? city;
  int? emailPin;
  bool? isVerified;
  String? status;
  String? ratePerClick;
  String? verifyPin;
  String? description;
  String? otherCatalog;
  Null? openTime;
  Null? closeTime;
  String? createdAt;
  String? updatedAt;
  Null? catId;
  int? isLiked;
  int? distance;
  double? distanceKm;
  int? clicks;
  List<Offers>? offers;
  List<ShopsItems>? shopItems;

  ShopDataRows(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.certificateNo,
      this.address,
      this.lat,
      this.long,
      this.shopLogo,
      this.isApproved,
      this.city,
      this.emailPin,
      this.isVerified,
      this.status,
      this.ratePerClick,
      this.verifyPin,
      this.description,
      this.otherCatalog,
      this.openTime,
      this.closeTime,
      this.createdAt,
      this.updatedAt,
      this.catId,
      this.isLiked,
      this.distance,
      this.distanceKm,
      this.clicks,
      this.offers,
      this.shopItems});

  ShopDataRows.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    certificateNo = json['certificate_no'];
    address = json['address'];
    lat = json['lat'];
    long = json['long'];
    shopLogo = json['shop_logo'];
    isApproved = json['is_approved'];
    city = json['city'];
    emailPin = json['email_pin'];
    isVerified = json['is_verified'];
    status = json['status'];
    ratePerClick = json['rate_per_click'];
    verifyPin = json['verify_pin'] ?? '';
    description = json['description'];
    otherCatalog = json['other_catalog'];
    openTime = json['open_time'];
    closeTime = json['close_time'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    catId = json['cat_id'];
    isLiked = json['is_liked'];
    distance = json['distance'];
    distanceKm = json['distance_km'];
    clicks = json['clicks'];
    if (json['Offers'] != null) {
      offers = <Offers>[];
      json['Offers'].forEach((v) {
        offers!.add(new Offers.fromJson(v));
      });
    }
    if (json['ShopItems'] != null) {
      shopItems = <ShopsItems>[];
      json['ShopItems'].forEach((v) {
        shopItems!.add(new ShopsItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['certificate_no'] = this.certificateNo;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['shop_logo'] = this.shopLogo;
    data['is_approved'] = this.isApproved;
    data['city'] = this.city;
    data['email_pin'] = this.emailPin;
    data['is_verified'] = this.isVerified;
    data['status'] = this.status;
    data['rate_per_click'] = this.ratePerClick;
    data['verify_pin'] = this.verifyPin;
    data['description'] = this.description;
    data['other_catalog'] = this.otherCatalog;
    data['open_time'] = this.openTime;
    data['close_time'] = this.closeTime;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['cat_id'] = this.catId;
    data['is_liked'] = this.isLiked;
    data['distance'] = this.distance;
    data['distance_km'] = this.distanceKm;
    data['clicks'] = this.clicks;
    if (this.offers != null) {
      data['Offers'] = this.offers!.map((v) => v.toJson()).toList();
    }
    if (this.shopItems != null) {
      data['ShopItems'] = this.shopItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Offers {
  int? id;
  String? title;
  int? validity;
  String? bannerImage;
  bool? isEnabled;
  String? expiryDate;
  String? metaData;
  bool? isProcessed;
  String? ratePerClick;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? shopId;
  int? isExpired;
  int? clicks;

  Offers(
      {this.id,
      this.title,
      this.validity,
      this.bannerImage,
      this.isEnabled,
      this.expiryDate,
      this.metaData,
      this.isProcessed,
      this.ratePerClick,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.shopId,
      this.isExpired,
      this.clicks});

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    validity = json['validity'];
    bannerImage = json['banner_image'];
    isEnabled = json['is_enabled'];
    expiryDate = json['expiry_date'];
    metaData = json['meta_data'];
    isProcessed = json['is_processed'];
    ratePerClick = json['rate_per_click'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    shopId = json['shop_id'];
    isExpired = json['is_expired'];
    clicks = json['clicks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['validity'] = this.validity;
    data['banner_image'] = this.bannerImage;
    data['is_enabled'] = this.isEnabled;
    data['expiry_date'] = this.expiryDate;
    data['meta_data'] = this.metaData;
    data['is_processed'] = this.isProcessed;
    data['rate_per_click'] = this.ratePerClick;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['shop_id'] = this.shopId;
    data['is_expired'] = this.isExpired;
    data['clicks'] = this.clicks;
    return data;
  }
}

class ShopsItems {
  int? id;
  String? name;
  String? price;
  String? quantity;
  String? imageUrl;
  String? expiryDate;
  String? createdAt;
  String? updatedAt;
  int? shopId;
  int? isExpired;

  ShopsItems(
      {this.id,
      this.name,
      this.price,
      this.quantity,
      this.imageUrl,
      this.expiryDate,
      this.createdAt,
      this.updatedAt,
      this.shopId,
      this.isExpired});

  ShopsItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    imageUrl = json['image_url'];
    expiryDate = json['expiry_date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    shopId = json['shop_id'];
    isExpired = json['is_expired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['image_url'] = this.imageUrl;
    data['expiry_date'] = this.expiryDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['shop_id'] = this.shopId;
    data['is_expired'] = this.isExpired;
    return data;
  }
}
