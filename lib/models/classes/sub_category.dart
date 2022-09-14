class SubCategory {
  bool? error;
  String? message;
  List<SubCategoryDataRows>? rows;

  SubCategory({this.error, this.message, this.rows});

  SubCategory.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      rows = <SubCategoryDataRows>[];
      json['data'].forEach((v) {
        rows!.add(new SubCategoryDataRows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.rows != null) {
      data['data'] = this.rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategoryDataRows {
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
  int? subCategories;

  SubCategoryDataRows(
      {this.id,
      this.name,
      this.level,
      this.discount,
      this.image,
      this.icon,
      this.createdAt,
      this.updatedAt,
      this.parentId,
      this.shopCounts,
      this.subCategories});

  SubCategoryDataRows.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    level = json['level'];
    discount = json['discount'];
    image = json['image'];
    icon = json['icon'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    parentId = json['parent_id'];
    shopCounts = json['shop_counts'];
    subCategories = json['sub_categories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['level'] = this.level;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['icon'] = this.icon;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['parent_id'] = this.parentId;
    data['shop_counts'] = this.shopCounts;
    data['sub_categories'] = this.subCategories;
    return data;
  }
}
