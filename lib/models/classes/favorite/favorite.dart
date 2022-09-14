class FavoriteDataRowsOffers {
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

  FavoriteDataRowsOffers({
    this.id,
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
  });
  FavoriteDataRowsOffers.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    title = json['title']?.toString();
    validity = json['validity']?.toInt();
    bannerImage = json['banner_image']?.toString();
    isEnabled = json['is_enabled'];
    expiryDate = json['expiry_date']?.toString();
    metaData = json['meta_data']?.toString();
    isProcessed = json['is_processed'];
    ratePerClick = json['rate_per_click']?.toString();
    status = json['status']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    shopId = json['shop_id']?.toInt();
    isExpired = json['is_expired']?.toInt();
  }
}

class FavoriteDataRows {
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
  String? openTime;
  String? closeTime;
  String? createdAt;
  String? updatedAt;
  String? catId;
  int? isLiked;
  int? distance;
  double? distanceKm;
  int? clicks;
  List<FavoriteDataRowsOffers?>? Offers;
  List<ShopItemsFavorite?>? shopItems;

  FavoriteDataRows({
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
    this.isLiked,
    this.distance,
    this.distanceKm,
    this.clicks,
    this.Offers,
    this.shopItems,
  });
  FavoriteDataRows.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    phone = json['phone']?.toString();
    email = json['email']?.toString();
    certificateNo = json['certificate_no']?.toString();
    address = json['address']?.toString();
    lat = json['lat']?.toString();
    long = json['long']?.toString();
    shopLogo = json['shop_logo']?.toString();
    isApproved = json['is_approved'];
    city = json['city']?.toString();
    emailPin = json['email_pin']?.toInt();
    isVerified = json['is_verified'];
    status = json['status']?.toString();
    ratePerClick = json['rate_per_click']?.toString();
    verifyPin = json['verify_pin']?.toString();
    description = json['description']?.toString();
    otherCatalog = json['other_catalog']?.toString();
    openTime = json['open_time']?.toString();
    closeTime = json['close_time']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    catId = json['cat_id']?.toString();
    isLiked = json['is_liked']?.toInt();
    distance = json['distance']?.toInt();
    distanceKm = json['distance_km']?.toDouble();
    clicks = json['clicks']?.toInt();
    if (json['Offers'] != null) {
      final v = json['Offers'];
      final arr0 = <FavoriteDataRowsOffers>[];
      v.forEach((v) {
        arr0.add(FavoriteDataRowsOffers.fromJson(v));
      });
      Offers = arr0;
    }
    if (json['ShopItems'] != null) {
      final v = json['ShopItems'];
      final arr0 = <ShopItemsFavorite>[];
      v.forEach((v) {
        arr0.add(ShopItemsFavorite.fromJson(v));
      });
      shopItems = arr0;
    }
  }
}

class FavoriteData {
  int? count;
  List<FavoriteDataRows?>? rows;

  FavoriteData({
    this.count,
    this.rows,
  });
  FavoriteData.fromJson(Map<String, dynamic> json) {
    count = json['count']?.toInt();
    if (json['rows'] != null) {
      final v = json['rows'];
      final arr0 = <FavoriteDataRows>[];
      v.forEach((v) {
        arr0.add(FavoriteDataRows.fromJson(v));
      });
      rows = arr0;
    }
  }
}

class ShopItemsFavorite {
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

  ShopItemsFavorite(
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

  ShopItemsFavorite.fromJson(Map<String, dynamic> json) {
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
}
