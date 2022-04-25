import 'package:washee/core/helpers/date_helper.dart';
import 'package:washee/core/helpers/web_communicator.dart';
import 'package:washee/core/network/network_info.dart';
import 'package:washee/injection_container.dart';

// TODO: Needs tests
// TODO: Needs to replace ExceptionHandler where that is used
// TODO: Probably needs to be split up, so that logging the information locally is the "log" method
//        And a "send" method sends all the logs when there is proper wifi connection or something like that
//        Avoids the problems of our "sometimes we don't have internet" problem

class Logger{
  Logger();

  String log({required String what, required String who, required String where}) {
    String exceptionMsg = what + who + where + DateHelper.currentTime().toString();
    try{
      sl<NetworkInfo>().isConnected.then((connected) => {
        if(connected){
          sl<WebCommunicator>().postLog(exception)
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