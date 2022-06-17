

import 'package:dio/dio.dart';
import 'package:washee/core/externalities/web/web_connector.dart';

abstract class IWebUserRemote{
  Future<Map<String,dynamic>> getUser(int userId);
  Future<List<Map<String,dynamic>>> getUsers(Map<String,dynamic> valuesToGet);
  Future<Map<String,dynamic>> postUser(Map<String,dynamic> userAsJson);
  Future<Map<String,dynamic>> updateUser(Map<String,dynamic> userAsJson, Map<String,dynamic> valuesToUpdate);
  Future<Map<String,dynamic>> deleteUser(Map<String,dynamic> userAsJson);
  Future<Map<String,dynamic>> signIn(String username, String password);
  Future<Map<String,dynamic>> autoSignIn();
}

class WebUserRemote extends IWebUserRemote{
  final IWebConnector webConnector;

  WebUserRemote({required this.webConnector});

  String userEndpointURL = "/api/1/users/";

  @override
  Future<Map<String, dynamic>> deleteUser(Map<String, dynamic> userAsJson) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getUser(int userId) async {
    String finalEndpoint = userEndpointURL + userId.toString() + "/";
    Response response = await webConnector.retrieve(finalEndpoint);
    return response.data;
  }

  @override
  Future<List<Map<String, dynamic>>> getUsers(Map<String, dynamic> valuesToGet) {
    // TODO: implement getUsers
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> postUser(Map<String, dynamic> userAsJson) {
    // TODO: implement postUser
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> updateUser(Map<String, dynamic> userAsJson, Map<String, dynamic> valuesToUpdate) {
    // TODO: implement updateUser
    throw UnimplementedError();
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

    // TODO: implement signIn
    throw UnimplementedError();
  }
}