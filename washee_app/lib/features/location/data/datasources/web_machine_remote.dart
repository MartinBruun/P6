import 'package:dio/dio.dart';
import 'package:washee/core/externalities/network/network_info.dart';
import 'package:washee/core/externalities/web/web_connector.dart';

abstract class  IWebMachineRemote{
  Future<List<Map<String,dynamic>>> getMachines();
}

class WebMachineRemote extends IWebMachineRemote{
  IWebConnector connector;
  NetworkInfo networkInfo;

  WebMachineRemote({required this.connector, required this.networkInfo});

  @override
  Future<List<Map<String,dynamic>>> getMachines() async {
    if (await networkInfo.isConnected) {
      Response response = await connector.retrieve("api/1/machines", queryParameters: {});
      return response.data;
    }
    return [];
  }
}