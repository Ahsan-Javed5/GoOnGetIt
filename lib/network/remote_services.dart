import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:go_on_get_it/data/local/my_hive.dart';
import 'package:go_on_get_it/network/network_exception.dart';
import 'package:go_on_get_it/network/secure_http_client.dart';

class RemoteServices {
  late final secureRepository;
  late final InsecureClient;

  void init() {
    secureRepository = MySecureHttpClient.getClient();
    InsecureClient = MySecureHttpClient.getInsecureClient();
  }

  Future<dynamic> postRequest(String endPoint, Map<String, dynamic> map,
      {Map<String, dynamic>? queryParams}) async {
    dynamic resJson;
    try {
      dynamic _user = await secureRepository.post(endPoint,
          data: map, queryParameters: queryParams);
      print('this is status code');
      print(_user.statusCode.toString());
      if (_user.statusCode == 200) {
        resJson = json.decode(_user.toString());
        return resJson;
      }
    } catch (e) {
      if (kDebugMode) print('Error');
      if (e is DioError) {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        if (kDebugMode) print(errorMessage);
        print('ERR: ${e.toString()}');
        print('dio error');
      }
    }
  }

  Future<dynamic> getRequest(String endPoint, Map<String, dynamic> map) async {
    dynamic resJson;
    try {
      String token = MyHive.getToken();
      secureRepository!.options.headers['authorization'] = token;
      debugPrint('Token: $token}');
      // secureRepository!.options.headers['authorization'] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MywibGF0IjoyNCwibG9uZyI6NzMsInVfaWQiOiIxMjEyMTIiLCJjcmVhdGVkQXQiOiIyMDIxLTEyLTMxVDA2OjQzOjQ1LjAwMFoiLCJ1cGRhdGVkQXQiOiIyMDIxLTEyLTMxVDA2OjQzOjQ1LjAwMFoifQ.BAvPK-vn_5wxULTiyygtrNREtQmi237TRlq6wBchazQ';
      dynamic _user =
          await secureRepository.get(endPoint, queryParameters: map);
      print('status_code: ${_user.statusCode}');
      if (_user.statusCode == 200) {
        resJson = json.decode(_user.toString());
        return resJson;
      }
    } catch (e) {
      if (kDebugMode) print('Error');
      if (e is DioError) {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        if (kDebugMode) print(errorMessage);
      }
    }
  }
}
