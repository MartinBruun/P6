import 'package:washee/core/externalities/web/web_connector.dart';
import 'package:washee/core/standards/time/date_helper.dart';
import 'package:washee/core/externalities/network/network_info.dart';

// TODO: Needs tests
// TODO: Needs to replace ExceptionHandler where that is used
// TODO: Probably needs to be split up, so that logging the information locally is the "log" method
//        And a "send" method sends all the logs when there is proper wifi connection or something like that
//        Avoids the problems of our "sometimes we don't have internet" problem

class Logger{
  late DateHelper dateHelper;
  late WebConnector webConnector;
  late NetworkInfo networkInfo;

  Logger(DateHelper dateHelp, WebConnector webCon, NetworkInfo netInfo){
    dateHelper = dateHelp;
    webConnector = webCon;
    networkInfo = netInfo;
  }

  String log({required String what, required String who, required String where}) {
    String exceptionMsg = what + who + where + dateHelper.currentTime().toString();
    try{
      networkInfo.isConnected.then((connected) => {
        if(connected){
          //webConnector.postLog(exceptionMsg)
          throw UnimplementedError()
        }
    });
    }
    catch (e){
      print("Error could not be send to logs: ");
    }
    print(exceptionMsg);

    return exceptionMsg;
  }
} 