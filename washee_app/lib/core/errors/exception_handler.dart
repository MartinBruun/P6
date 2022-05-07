import 'dart:io';

import 'package:washee/core/helpers/web_communicator.dart';
import 'package:washee/core/network/network_info.dart';
import 'package:washee/injection_container.dart';
import 'package:washee/core/helpers/date_helper.dart';

class ExceptionHandler{
  // ExceptionHandler is a class where all try/catch blocks in the codebase use the .handle() method on any catched Exception.
  // This is to reuse and standardise how errors are handled across the codebase.

  // Flutter will highly likely have its own way of handling exceptions.
  // It would be nice though, if these ways of handling exceptions are "wrapped" in a custom class
  // So everyone knows where to look for, and improve, security "stuff", rather than it being spread out
  String logLocation = Directory.current.path + "/lib/core/errors/exception_log.txt";

  ExceptionHandler();

  void resetLog(){
    File(logLocation).writeAsStringSync("ExceptionHandler reset log file at: " + DateHelper().currentTime().toString() + "\n", mode: FileMode.write);
  }

  String handle(String exception, {log=false, show=false, crash=false}) {
    //File(logLocation).writeAsStringSync("ExceptionHandler initialized at: " + DateHelper.currentTime().toString() + "\n", mode: FileMode.append);

    if (log==false && show==false && crash==false){
      throw new Exception("ExceptionHandler not configured properly.\n" +
                        "ExceptionHandler has to have set at least one parameter of (log, show or crash) to True\n" +
                        "Error occured with the following exception:\n" +
                        exception.toString());
    }

    if (log){
      try{
        sl<NetworkInfo>().isConnected.then((connected) => {
          if(connected){
            sl<WebCommunicator>().postLog(exception)
          }
      });
      }
      catch (e){
        print("Error could not be send to logs: " + exception);
      }
    }
    if (show){
      print(exception.toString());
    }
    if (crash){
      throw new Exception(exception.toString());
    }

    return exception.toString();
  }
}