import 'package:hive/hive.dart';

part 'user_data.g.dart';

@HiveType(typeId: 3)
class UserData {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? uId;
  @HiveField(2)
  String? lat;
  @HiveField(3)
  String? long;
  @HiveField(4)
  String? updatedAt;
  @HiveField(5)
  String? createdAt;
  @HiveField(6)
  String? token;

  UserData({
    this.id,
    this.uId,
    this.lat,
    this.long,
    this.updatedAt,
    this.createdAt,
    this.token,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    uId = json['u_id']?.toString();
    lat = json['lat']?.toString();
    long = json['long']?.toString();
    updatedAt = json['updatedAt']?.toString();
    createdAt = json['createdAt']?.toString();
    token = json['token']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['u_id'] = uId;
    data['lat'] = lat;
    data['long'] = long;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    data['token'] = token;
    return data;
  }
}
