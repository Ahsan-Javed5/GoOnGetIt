import 'package:go_on_get_it/models/classes/user_data.dart';

class User {
  bool? error;
  String? message;
  List<UserData?>? data;

  User({
    this.error,
    this.message,
    this.data,
  });

  User.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <UserData>[];
      v.forEach((v) {
        arr0.add(UserData.fromJson(v));
      });
      data = arr0;
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['error'] = error;
    data['message'] = message;
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['data'] = arr0;
    }
    return data;
  }
}
