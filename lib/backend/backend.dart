import 'package:dio/dio.dart';

import 'app_interceptor.dart';
import 'backend_routes.dart';

class Backend{


  Dio io;
  AppInterceptor interceptor;

  static Backend _backend;

  factory Backend.instance() {
    _backend ??= Backend._ctor();
    return _backend;
  }

  Backend._ctor(){

    io = Dio();
    interceptor = AppInterceptor();
    io.interceptors.add(interceptor);
    io.options.baseUrl = BackendRoutes.baseURL;
    io.options.connectTimeout = 5000; //5s
    io.options.receiveTimeout = 3000;

  }

  void addToken(){
    io.options.headers = {"Authorization" : "Bearer " + "eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJsb2dpbiIsInN1YiI6IjEiLCJpYXQiOjE1OTI2MDU0MDIsImV4cCI6ODY1NTkyNjA1NDAyfQ.bRlD4ezitr_7Q2BjwntDXz2hkzOdX5E_DT3ywOSCa4c"};
  }

}