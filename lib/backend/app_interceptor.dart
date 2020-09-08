

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

///Interceptor para tratar os erros gerados do backend.
class AppInterceptor extends Interceptor {
  List errors;
  bool returnLogin = false;

  BuildContext get context => null;

  @override
  Future onRequest(RequestOptions options) {
    return super.onRequest(options);
  }

  @override
  Future onError(DioError err) async {
    //400,401,403,500
    int statusCode = err.response?.statusCode;
    if (statusCode != null) {
      switch (statusCode) {
        case 400:
          errors = [err.response?.data["title"]];
          break;
        case 404:
          errors = [err.response?.data["title"]];
          break;
        case 401:
          errors = [err.response?.data["title"]];
          Navigator.pushNamed(context, '/splash');
          break;
        case 403:
          errors = [err.response?.data["title"]];
          Navigator.pushNamed(context, '/splash');
          break;
        case 500:
          errors = [err.response?.data["title"]];
          break;
        default:
          errors = err.response?.data["titles"];
      }
    } else {
      errors = [err.response?.data["title"]];
    }
    return super.onError(err);
  }

  @override
  Future onResponse(Response response) {
    return super.onResponse(response);
  }
}
