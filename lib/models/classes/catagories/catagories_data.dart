import 'package:go_on_get_it/models/classes/catagories/categories_data_sub_categories.dart';

class CategoriesData {
  int? id;
  String? name;
  int? level;
  String? discount;
  String? image;
  String? icon;
  String? createdAt;
  String? updatedAt;
  String? parentId;
  int? shopCounts;
  List<CategoriesDataSubCategories?>? SubCategories;

  CategoriesData({
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
    this.SubCategories,
  });
  CategoriesData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    level = json['level']?.toInt();
    discount = json['discount']?.toString();
    image = json['image']?.toString();
    icon = json['icon']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    parentId = json['parent_id']?.toString();
    shopCounts = json['shop_counts']?.toInt();
    if (json['SubCategories'] != null) {
      final v = json['SubCategories'];
      final arr0 = <CategoriesDataSubCategories>[];
      v.forEach((v) {
        arr0.add(CategoriesDataSubCategories.fromJson(v));
      });
      SubCategories = arr0;
    }
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
    if (SubCategories != null) {
      final v = SubCategories;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['SubCategories'] = arr0;
    }
    return data;
  }
}