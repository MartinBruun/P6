import 'package:dio/dio.dart';
import 'package:washee/core/account/user.dart';
import 'package:washee/core/environments/environment.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:washee/core/helpers/web_communicator.dart';
import 'package:washee/injection_container.dart';

import '../errors/exception_handler.dart';

abstract class Authorizer {
  Dio initDio();
  String get tokenURL;
  Future<String> getTokenFromCache();
  Future<bool> signIn({required String email, required String password});
  Future<bool> autoSignIn();
  Future<void> removeAllCredentials();
}

class AuthorizerImpl implements Authorizer {
  Dio dio;

  ActiveUser user = ActiveUser();

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
  String get tokenURL => Environment().config.webApiHost + "/api-token-auth/";

  @override
  Future<String> getTokenFromCache() async {
    String? token = await sl<FlutterSecureStorage>().read(key: "token");
    if (token != null) {
      return token;
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
        await sl<FlutterSecureStorage>().write(key: "token", value: response.data["token"]);
        await sl<FlutterSecureStorage>().write(key: "username", value: email);
        await sl<FlutterSecureStorage>().write(key: "password", value: password);
        sl<WebCommunicator>().initDio();

        user.initUser(response.data["user_id"], response.data["email"], response.data["username"], response.data["accounts"]);

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

  Future<bool> autoSignIn() async {
    String? username = await sl<FlutterSecureStorage>().read(key: "username");
    String? password = await sl<FlutterSecureStorage>().read(key: "password");
    if( username != null && password != null ){
      return await this.signIn(email: username, password: password);
    }
    else{
      return await false;
    }
  }

  Future<void> removeAllCredentials() async {
    await sl<FlutterSecureStorage>().deleteAll();
  }
}
