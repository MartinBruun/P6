

import 'package:dio/dio.dart';
import 'package:washee/core/externalities/web/web_connector.dart';

abstract class  IWebAccountRemote{
  Future<Map<String,dynamic>> getAccount(int accountId);
  Future<List<Map<String,dynamic>>> getAccounts(Map<String,dynamic> valuesToGet);
  Future<Map<String,dynamic>> postAccount(Map<String,dynamic> accountAsJson);
  Future<Map<String,dynamic>> updateAccount(int accountId, Map<String,dynamic> valuesToUpdate);
  Future<Map<String,dynamic>> deleteAccount(int accountId);
}

class WebAccountRemote extends IWebAccountRemote{
  final IWebConnector webConnector;
  String accountEndpointURL = "/api/1/accounts/";

  WebAccountRemote({required this.webConnector});

  @override
  Future<Map<String, dynamic>> deleteAccount(int accountId) async {
    String finalEndpoint = accountEndpointURL + accountId.toString() + "/";
    Response response = await webConnector.delete(finalEndpoint);
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> getAccount(int accountId) async {
    String finalEndpoint = accountEndpointURL + accountId.toString() + "/";
    Response response = await webConnector.retrieve(finalEndpoint);
    return response.data;
  }

  @override
  Future<List<Map<String, dynamic>>> getAccounts(Map<String, dynamic> valuesToGet) async {
    Response response = await webConnector.retrieve(accountEndpointURL);
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> postAccount(Map<String, dynamic> accountAsJson) async {
    Response response = await webConnector.create(accountEndpointURL, accountAsJson);
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> updateAccount(int accountId, Map<String, dynamic> valuesToUpdate) async {
    String finalEndpoint = accountEndpointURL + accountId.toString() + "/";
    Response response = await webConnector.update(finalEndpoint, valuesToUpdate);
    return response.data;
  }

}