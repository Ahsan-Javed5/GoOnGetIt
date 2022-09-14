class CategoriesDataSubCategoriesSubCategories {
/*
{
  "id": 9,
  "name": "Pizza",
  "level": 3,
  "discount": "50%",
  "image": "https://cdn0.iconfinder.com/data/icons/infographic",
  "icon": "https://cdn0.iconfinder.com/data/icons/infographic",
  "createdAt": "2021-12-16T05:20:48.000Z",
  "updatedAt": "2021-12-16T05:20:48.000Z",
  "parent_id": 8,
  "shop_counts": 5
}
*/

  int? id;
  String? name;
  int? level;
  String? discount;
  String? image;
  String? icon;
  String? createdAt;
  String? updatedAt;
  int? parentId;
  int? shopCounts;

  CategoriesDataSubCategoriesSubCategories({
    this.id,
    this.name,
    this.level,
    this.discount,
    this.image,
    this.icon,
    this.createdAt,
    this.updatedAt,
    this.parentId,
    this.shopCounts,
  });
  CategoriesDataSubCategoriesSubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    level = json['level']?.toInt();
    discount = json['discount']?.toString();
    image = json['image']?.toString();
    icon = json['icon']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    parentId = json['parent_id']?.toInt();
    shopCounts = json['shop_counts']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['level'] = level;
    data['discount'] = discount;
    data['image'] = image;
    data['icon'] = icon;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['parent_id'] = parentId;
    data['shop_counts'] = shopCounts;
    return data;
  }
}