import 'dart:io';

import 'package:dio/dio.dart';
import 'package:washee/core/environments/environment.dart';

import '../errors/exception_handler.dart';

abstract class Authorizer {
  Dio initDio();
  String token = ""; // Should probably be cached someway different than in memory when the program is running...
  String get tokenURL;
  String getTokenFromCache();
  Future<void> getAndSaveTokenToCache(String email, String password);
}

class AuthorizerImpl implements Authorizer {
  Dio dio;

  AuthorizerImpl({required this.dio}){
    dio = initDio();
  }

  @override
  Dio initDio() {
    Dio dio = new Dio();
    dio.options.headers["content-Type"] = "application/json";
    return dio;
  }

  @override
  String token = "";

  @override
  String get tokenURL => Environment().config.webApiHost + "/api/1/api-token-auth";

  @override
  String getTokenFromCache() {
    if (this.token != ""){
      return this.token;
    }
    else{
      ExceptionHandler().handle(
        "Token expected to be found, even though it was empty. User not logged in properly!", 
        show:true, log:true, crash:true);
      return ""; 
    }
  } 

  @override
  Future<void> getAndSaveTokenToCache(String email, String password) async {
    Response response;
    String email = "";
    String password = "";

    response = await dio.post(tokenURL, data:{ "username": email, "password": password});
    if (response.statusCode == 200){
      this.token = response.data["token"];
    }
    else {
      ExceptionHandler().handle(
        "Something went wrong with status code: " + response.statusCode.toString() + " with response:\n" + response.data['response'],
        log:true, show:true, crash: false);
    }
  }
}