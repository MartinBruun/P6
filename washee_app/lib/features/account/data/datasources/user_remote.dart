

import 'package:dio/dio.dart';
import 'package:washee/core/externalities/web/web_connector.dart';

abstract class IWebUserRemote{
  Future<Map<String,dynamic>> getUser(int userId);
  Future<List<Map<String,dynamic>>> getUsers(Map<String,dynamic> valuesToGet);
  Future<Map<String,dynamic>> postUser(Map<String,dynamic> userAsJson);
  Future<Map<String,dynamic>> updateUser(int userId, Map<String,dynamic> valuesToUpdate);
  Future<Map<String,dynamic>> deleteUser(int userId);
  Future<Map<String,dynamic>> signIn(String username, String password);
  Future<Map<String,dynamic>> autoSignIn();
}

class WebUserRemote extends IWebUserRemote{
  final IWebConnector webConnector;

  WebUserRemote({required this.webConnector});

  String userEndpointURL = "/api/1/users/";

  @override
  Future<Map<String, dynamic>> deleteUser(int userId) async {
    String finalEndpoint = userEndpointURL + userId.toString() + "/";
    Response response = await webConnector.delete(finalEndpoint);
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> getUser(int userId) async {
    String finalEndpoint = userEndpointURL + userId.toString() + "/";
    Response response = await webConnector.retrieve(finalEndpoint, queryParameters: {});
    return response.data;
  }

  @override
  Future<List<Map<String, dynamic>>> getUsers(Map<String, dynamic> valuesToGet) async {
    Response response = await webConnector.retrieve(userEndpointURL, queryParameters: valuesToGet);
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> postUser(Map<String, dynamic> userAsJson) async {
    Response response = await webConnector.create(userEndpointURL, userAsJson);
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> updateUser(int userId, Map<String, dynamic> valuesToUpdate) async {
    String finalEndpoint = userEndpointURL + userId.toString() + "/";
    Response response = await webConnector.update(finalEndpoint, valuesToUpdate);
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> autoSignIn() async {
    Response? response = await webConnector.renewAuthorization();
    if(response == null){
      return {};
    }
    else if (response.statusCode == 200){
      return response.data;
    }
    else{
      return {};
    }
  }

  @override
  Future<Map<String, dynamic>> signIn(String username, String password) async {
    Response response = await webConnector.authorize(username, password);
    return response.data;
  }
}