

import 'package:dio/dio.dart';
import 'package:washee/core/externalities/web/web_connector.dart';

abstract class  IWebAccountRemote{
  Future<Map<String,dynamic>> getAccount(int accountId);
  Future<List<Map<String,dynamic>>> getAccounts(Map<String,dynamic> valuesToGet);
  Future<Map<String,dynamic>> postAccount(Map<String,dynamic> accountAsJson);
  Future<Map<String,dynamic>> updateAccount(Map<String,dynamic> accountAsJson, Map<String,dynamic> valuesToUpdate);
  Future<Map<String,dynamic>> deleteAccount(Map<String,dynamic> accountAsJson);
}

class WebAccountRemote extends IWebAccountRemote{
  final IWebConnector webConnector;
  String accountEndpointURL = "/api/1/accounts/";

  WebAccountRemote({required this.webConnector});

  @override
  Future<Map<String, dynamic>> deleteAccount(Map<String, dynamic> accountAsJson) {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getAccount(int accountId) async {
    String finalEndpoint = accountEndpointURL + accountId.toString() + "/";
    Response response = await webConnector.retrieve(finalEndpoint);
    return response.data;
  }

  @override
  Future<List<Map<String, dynamic>>> getAccounts(Map<String, dynamic> valuesToGet) {
    // TODO: implement getAccounts
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> postAccount(Map<String, dynamic> accountAsJson) {
    // TODO: implement postAccount
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> updateAccount(Map<String, dynamic> accountAsJson, Map<String, dynamic> valuesToUpdate) {
    // TODO: implement updateAccunt
    throw UnimplementedError();
  }

}