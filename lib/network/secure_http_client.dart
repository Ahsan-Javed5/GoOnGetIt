import 'package:dio/dio.dart';

class MySecureHttpClient {
  static Dio? secureClient;
  static Dio? insecureClient;

  static Dio getClient() {
    ///getting token from MyHive..
    secureClient ??= Dio(
      BaseOptions(baseUrl: 'https://backend.goongetit.codesorbit.net/api/'),
    );
    //secureClient!.options.headers['authorization'] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJpZCI6NCwidV9pZCI6IjIzMjEzMTIzMTIzIiwibGF0IjoiMjIuMzIyMyIsImxvbmciOiIzMi4zMjM0MzQzNCIsInVwZGF0ZWRBdCI6IjIwMjItMDEtMTNUMDc6MDA6MDIuMDc5WiIsImNyZWF0ZWRBdCI6IjIwMjItMDEtMTNUMDc6MDA6MDIuMDc5WiJ9.s4FWtZ0aLnSIBZUTI55w0r4Q3UcUCYYCrWJXUjq073g';
    //secureClient!.options.headers['authorization'] = MyHive.getToken() ?? '';
    return secureClient!;
  }

  static Dio getInsecureClient() {
    return insecureClient ??= Dio(
        BaseOptions(baseUrl: 'https://backend.goongetit.codesorbit.net/api/'));
  }
}
