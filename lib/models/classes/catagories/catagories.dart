// import 'package:go_on_get_it/models/classes/catagories/catagories_data.dart';
//
// class Categories {
// /*
// {
//   "error": false,
//   "message": "success",
//   "data": [
//     {
//       "id": 3,
//       "name": "Food",
//       "level": 1,
//       "discount": "50",
//       "image": "https://cdn0.iconfinder.com/data/icons/infographic",
//       "icon": "https://cdn0.iconfinder.com/data/icons/infographic",
//       "createdAt": "2021-12-16T05:20:48.000Z",
//       "updatedAt": "2021-12-24T22:34:42.000Z",
//       "parent_id": "null",
//       "shop_counts": 5,
//       "SubCategories": [
//         {
//           "id": 8,
//           "name": "Fast food",
//           "level": 2,
//           "discount": "30",
//           "image": "https://cdn0.iconfinder.com/data/icons/infographic",
//           "icon": "https://cdn0.iconfinder.com/data/icons/infographic",
//           "createdAt": "2021-12-16T05:20:48.000Z",
//           "updatedAt": "2021-12-21T11:13:48.000Z",
//           "parent_id": 3,
//           "shop_counts": 5,
//           "SubCategories": [
//             {
//               "id": 9,
//               "name": "Pizza",
//               "level": 3,
//               "discount": "50%",
//               "image": "https://cdn0.iconfinder.com/data/icons/infographic",
//               "icon": "https://cdn0.iconfinder.com/data/icons/infographic",
//               "createdAt": "2021-12-16T05:20:48.000Z",
//               "updatedAt": "2021-12-16T05:20:48.000Z",
//               "parent_id": 8,
//               "shop_counts": 5
//             }
//           ]
//         }
//       ]
//     }
//   ]
// }
// */
//
//   bool? error;
//   String? message;
//   List<CategoriesData?>? data;
//
//   Categories({
//     this.error,
//     this.message,
//     this.data,
//   });
//   Categories.fromJson(Map<String, dynamic> json) {
//     error = json['error'];
//     message = json['message']?.toString();
//     if (json['data'] != null) {
//       final v = json['data'];
//       final arr0 = <CategoriesData>[];
//       v.forEach((v) {
//         arr0.add(CategoriesData.fromJson(v));
//       });
//       this.data = arr0;
//     }
//   }
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['error'] = error;
//     data['message'] = message;
//     if (this.data != null) {
//       final v = this.data;
//       final arr0 = [];
//       v!.forEach((v) {
//         arr0.add(v!.toJson());
//       });
//       data['data'] = arr0;
//     }
//     return data;
//   }
// }