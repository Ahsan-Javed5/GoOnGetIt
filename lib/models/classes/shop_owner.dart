

class ShopOwner {
  int? id;
  String? name;
  String? shopLogo;

  ShopOwner({this.id, this.name, this.shopLogo});

  ShopOwner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shopLogo = json['shop_logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['shop_logo'] = shopLogo;
    return data;
  }
}