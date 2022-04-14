import 'dart:io';

import 'package:dio/dio.dart';
import 'package:washee/core/environments/environment.dart';

import '../errors/exception_handler.dart';

abstract class Authorizer {
  Dio initDio();
  String get token;
  String get tokenURL;
  String getTokenFromCache();
  Future<bool> signIn({required String email, required String password});
}

class AuthorizerImpl implements Authorizer {
  Dio dio;

  AuthorizerImpl({required this.dio}) {
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
  String get tokenURL => Environment().config.webApiHost + "/api-token-auth/";

  @override
  String getTokenFromCache() {
    if (this.token != "") {
      return this.token;
    } else {
      ExceptionHandler().handle(
          "Token expected to be found, even though it was empty. User not logged in properly!",
          show: true,
          log: true,
          crash: true);
      return "";
    }
  }

  @override
  Future<bool> signIn({required String email, required String password}) async {
    Response response;
    Map<String, dynamic> data = {"username": email, "password": password};

    try {
      response = await dio.post(tokenURL, data: data);
      if (response.statusCode == 200) {
        this.token = response.data["token"];
        return true;
      } else {
        ExceptionHandler().handle(
            "Something went wrong with status code: " +
                response.statusCode.toString() +
                " with response:\n" +
                response.data['response'],
            log: true,
            show: true,
            crash: false);
        return false;
      }
    } catch (e) {
      ExceptionHandler()
          .handle(e.toString(), log: true, show: true, crash: false);
      return false;
    }
  }
}
