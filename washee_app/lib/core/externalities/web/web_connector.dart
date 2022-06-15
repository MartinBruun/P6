

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:washee/core/standards/environments/environment.dart';
import 'package:washee/core/standards/failures/failures.dart';

abstract class IWebConnector{
  String get baseURL;
  Future<Response> authorize(String username, String password);
  Future<Response?> renewAuthorization();
  Future<Response> retrieve(String endpoint);
  Future<Response> update(String endpoint, Map<String,dynamic> data);
  Future<Response> create(String endpoint, Map<String,dynamic> data);
  Future<Response> delete(String endpoint, Map<String,dynamic> data);
}

class WebConnector extends IWebConnector{
  late Dio httpConnection;
  late FlutterSecureStorage secureStorage;
  late String secureStorageTokenKey;
  late String secureStorageUsernameKey;
  late String secureStoragePasswordKey;

  WebConnector({required this.httpConnection, required this.secureStorage}){
    httpConnection.options.headers["content-Type"] = "application/json";
    secureStorageTokenKey = "token";
    secureStorageUsernameKey = "username";
    secureStoragePasswordKey = "password";
  }

  @override
  String get baseURL => Environment().config.webApiHost;

  @override
  Future<Response> authorize(String username, String password) async {
    Response response;
    String authorizeURL = baseURL + "/api-token-auth/";

    Map<String,dynamic> data = {
      "username": username,
      "password": password
    };
    response = await httpConnection.post(authorizeURL, data: data);
    String token = response.data["token"];
    await secureStorage.write(key: secureStorageTokenKey, value: token);
    await secureStorage.write(key: secureStorageUsernameKey, value: username);
    await secureStorage.write(key: secureStoragePasswordKey, value: password);
    httpConnection.options.headers["authorization"] = "TOKEN $token"; 
    return response;
  }

  // TODO: enhance to also check if token is expired!
  Future<bool> isAuthorized() async {
    String? token = await secureStorage.read(key: secureStorageTokenKey);
    if(token == null){
      Response? response = await renewAuthorization();
      if(response == null){
        return false;
      }
      else if(response.statusCode == 200){
        return true;
      }
      else{
        return false;
      }
    }
    else{
      return true;
    }
  }

  Future<Response?> renewAuthorization() async {
    String? username = await secureStorage.read(key: secureStorageUsernameKey);
    String? password = await secureStorage.read(key: secureStoragePasswordKey);
    if(username == null || password == null){
      return null;
    }
    else{
      Response response = await authorize(username, password);
      return response;
    }
  }

  @override
  Future<Response> delete(String endpoint, Map<String, dynamic> data) async {
    if(await isAuthorized()){
      String url = baseURL + endpoint;
      return httpConnection.delete(url, data:data);
    }
    else{
      throw new NotAuthorizedFailure();
    }
  }

  @override
  Future<Response> retrieve(String endpoint) async {
    if(await isAuthorized()){
      String url = baseURL + endpoint;
      return httpConnection.delete(url);
    }
    else{
      throw new NotAuthorizedFailure();
    }
  }

  @override
  Future<Response> create(String endpoint, Map<String, dynamic> data) async {
    if(await isAuthorized()){
      String url = baseURL + endpoint;
      return httpConnection.post(url, data:data);
    }
    else{
      throw new NotAuthorizedFailure();
    }
  }

  @override
  Future<Response> update(String endpoint, Map<String, dynamic> data) async {
    if(await isAuthorized()){
      String url = baseURL + endpoint;
      return httpConnection.patch(url, data:data);
    }
    else{
      throw new NotAuthorizedFailure();
    }
  }
}