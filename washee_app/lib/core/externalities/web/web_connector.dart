

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:washee/core/standards/environments/environment.dart';
import 'package:washee/core/standards/failures/failures.dart';

abstract class IWebConnector{
  String get baseURL;
  Future<Response> authorize(String username, String password);
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

  WebConnector({required Dio httpCon, required FlutterSecureStorage secStorage}){
    secureStorage = secStorage;
    httpConnection.options.headers["content-Type"] = "application/json";
    httpConnection = httpCon;
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

  // Checks if already authorized
  // TODO: enhance to also check if token is expired!
  Future<bool> isAuthorized() async {
    String? token = await secureStorage.read(key: secureStorageTokenKey);
    if(token == null){
      return renewAuthorization();
    }
    else{
      return true;
    }
  }

  Future<bool> renewAuthorization() async {
    String? username = await secureStorage.read(key: secureStorageUsernameKey);
    String? password = await secureStorage.read(key: secureStoragePasswordKey);
    if(username == null || password == null){
      return false;
    }
    else{
      Response response = await authorize(username, password);
      if(response.statusCode == 200){
        return true;
      }
      else{
        return false;
      }
    }
  }

  @override
  Future<Response> delete(String endpoint, Map<String, dynamic> data) async {
    if(await isAuthorized()){
      return httpConnection.delete(endpoint, data:data);
    }
    else{
      throw new NotAuthorizedFailure();
    }
  }

  @override
  Future<Response> retrieve(String endpoint) async {
    if(await isAuthorized()){
      return httpConnection.delete(endpoint);
    }
    else{
      throw new NotAuthorizedFailure();
    }
  }

  @override
  Future<Response> create(String endpoint, Map<String, dynamic> data) async {
    if(await isAuthorized()){
      return httpConnection.post(endpoint, data:data);
    }
    else{
      throw new NotAuthorizedFailure();
    }
  }

  @override
  Future<Response> update(String endpoint, Map<String, dynamic> data) async {
    if(await isAuthorized()){
      return httpConnection.patch(endpoint, data:data);
    }
    else{
      throw new NotAuthorizedFailure();
    }
  }
}