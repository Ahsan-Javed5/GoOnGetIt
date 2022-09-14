// import 'package:go_on_get_it/models/classes/favorite/favorite.dart';
//
// class Favorite {
//   bool? error;
//   String? message;
//   FavoriteData? data;
//
//   Favorite({
//     this.error,
//     this.message,
//     this.data,
//   });
//   Favorite.fromJson(Map<String, dynamic> json) {
//     error = json['error'];
//     message = json['message']?.toString();
//     data = (json['data'] != null) ? FavoriteData.fromJson(json['data']) : null;
//   }
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['error'] = error;
//     data['message'] = message;
//     if (data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }