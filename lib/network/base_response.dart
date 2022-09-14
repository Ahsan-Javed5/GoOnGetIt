class BaseResponse<T> {
  bool? error = false;
  String? message;
  T? data;

  BaseResponse({this.error, this.message, this.data});

  BaseResponse.fromJson(Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    error = json['error'];
    message = json['message'];

    if (json["data"] is List) {
      final v = json['data'];
      final arr0 = [];
      v.forEach((v) {
        arr0.add(create(v));
      });
      data = arr0 as T;
    }
    else {
      data = create(json["data"]);
    }
  }
}
