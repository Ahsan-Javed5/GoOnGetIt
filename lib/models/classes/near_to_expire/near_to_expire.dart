class NearToExpireData {
  bool? error;
  String? message;
  NearExpireData? data;

  NearToExpireData({this.error, this.message, this.data});

  NearToExpireData.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data =
        json['data'] != null ? new NearExpireData.fromJson(json['data']) : null;
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

class NearExpireData {
  int? count;
  List<NearExpireRows>? rows;

  NearExpireData({this.count, this.rows});

  NearExpireData.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <NearExpireRows>[];
      json['rows'].forEach((v) {
        rows!.add(new NearExpireRows.fromJson(v));
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

class NearExpireRows {
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
  ShopOwner? shopOwner;

  NearExpireRows(
      {this.id,
      this.name,
      this.price,
      this.quantity,
      this.imageUrl,
      this.expiryDate,
      this.createdAt,
      this.updatedAt,
      this.shopId,
      this.isExpired,
      this.shopOwner});

  NearExpireRows.fromJson(Map<String, dynamic> json) {
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
    shopOwner = json['ShopOwner'] != null
        ? new ShopOwner.fromJson(json['ShopOwner'])
        : null;
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
    if (this.shopOwner != null) {
      data['ShopOwner'] = this.shopOwner!.toJson();
    }
    return data;
  }
}

class ShopOwner {
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
  Null? verifyPin;
  Null? description;
  String? otherCatalog;
  Null? openTime;
  Null? closeTime;
  String? createdAt;
  String? updatedAt;
  Null? catId;
  int? distance;
  double? distanceKm;
  int? isLiked;

  ShopOwner({
    this.id,
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
    this.distance,
    this.distanceKm,
    this.isLiked,
  });

  ShopOwner.fromJson(Map<String, dynamic> json) {
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
    verifyPin = json['verify_pin'];
    description = json['description'];
    otherCatalog = json['other_catalog'];
    openTime = json['open_time'];
    closeTime = json['close_time'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    catId = json['cat_id'];
    distance = json['distance'];
    distanceKm = json['distance_km'];
    isLiked = json['is_liked'];
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
    data['distance'] = this.distance;
    data['distance_km'] = this.distanceKm;
    data['is_liked'] = this.isLiked;
    return data;
  }
}
