class NearToExpireShopItems {
  bool? error;
  String? message;
  NearExpireShopData? data;

  NearToExpireShopItems({this.error, this.message, this.data});

  NearToExpireShopItems.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null
        ? new NearExpireShopData.fromJson(json['data'])
        : null;
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

class NearExpireShopData {
  int? count;
  NearExpireShopRows? rows;

  NearExpireShopData({this.count, this.rows});

  NearExpireShopData.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    rows = json['rows'] != null
        ? new NearExpireShopRows.fromJson(json['rows'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.rows != null) {
      data['rows'] = this.rows!.toJson();
    }
    return data;
  }
}

class NearExpireShopRows {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? certificateNo;
  String? address;
  String? lat;
  String? long;
  Location? location;
  String? shopLogo;
  bool? isApproved;
  String? city;
  String? password;
  int? emailPin;
  bool? isVerified;
  String? status;
  String? ratePerClick;
  Null? verifyPin;
  Null? description;
  String? otherCatalog;
  Null? openTime;
  Null? closeTime;
  String? createdAt;
  String? updatedAt;
  Null? catId;
  int? isLiked;
  List<ShopItems>? shopItems;

  NearExpireShopRows(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.certificateNo,
      this.address,
      this.lat,
      this.long,
      this.location,
      this.shopLogo,
      this.isApproved,
      this.city,
      this.password,
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
      this.shopItems});

  NearExpireShopRows.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    certificateNo = json['certificate_no'];
    address = json['address'];
    lat = json['lat'];
    long = json['long'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    shopLogo = json['shop_logo'];
    isApproved = json['is_approved'];
    city = json['city'];
    password = json['password'];
    emailPin = json['email_pin'];
    isVerified = json['is_verified'];
    status = json['status'];
    ratePerClick = json['rate_per_click'];
    verifyPin = json['verify_pin'];
    description = json['description'];
    otherCatalog = json['other_catalog'];
    openTime = json['open_time'];
    closeTime = json['close_time'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    catId = json['cat_id'];
    isLiked = json['is_liked'];
    if (json['ShopItems'] != null) {
      shopItems = <ShopItems>[];
      json['ShopItems'].forEach((v) {
        shopItems!.add(new ShopItems.fromJson(v));
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
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['shop_logo'] = this.shopLogo;
    data['is_approved'] = this.isApproved;
    data['city'] = this.city;
    data['password'] = this.password;
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
    if (this.shopItems != null) {
      data['ShopItems'] = this.shopItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class ShopItems {
  int? id;
  String? name;
  String? price;
  String? quantity;
  String? imageUrl;
  String? expiryDate;
  String? createdAt;
  String? updatedAt;
  int? shopId;

  ShopItems(
      {this.id,
      this.name,
      this.price,
      this.quantity,
      this.imageUrl,
      this.expiryDate,
      this.createdAt,
      this.updatedAt,
      this.shopId});

  ShopItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    imageUrl = json['image_url'];
    expiryDate = json['expiry_date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    shopId = json['shop_id'];
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
    return data;
  }
}
