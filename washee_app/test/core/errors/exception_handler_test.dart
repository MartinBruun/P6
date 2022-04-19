import 'package:flutter_test/flutter_test.dart';
import 'package:washee/core/errors/exception_handler.dart';

void main() {
  test(
    'test exception handler can be initialized',
    () async {
      // arrange
      final eh = ExceptionHandler();

      if (eh.runtimeType == ExceptionHandler){
        expect(true, true);
      }
    },
  );
/* Logging functionality sadly doesnt work in production, and makes the mobile crash.
    The logging functionality should be updated to make an API call to the backend instead!
  test(
    'test exception handler can write exception to a log',
    () async {
      // arrange
      final eh = ExceptionHandler();
      eh.resetLog();

      // act
      try{
        throw new Exception("Example Exception");
      }
      catch(e){
        eh.handle(e, log:true);
      }

      // assert
      var logString = File(eh.logLocation).readAsStringSync();
      expect(logString.contains("Example Exception"), true);
      eh.resetLog();
    },
  );
*/

  test(
    'test exception handler can fail silently and show to console',
    () async {
      // arrange
      final eh = ExceptionHandler();
      var err;

      // act
      try{
        throw new Exception("Example Exception");
      }
      catch(e){
        err = eh.handle(e.toString(), show:true);
      }

      // assert
      expect(err.contains("Example Exception"), true);
    },
  );

  test(
    'test exception handler can fail and crash the program',
    () async {
      // arrange
      final eh = ExceptionHandler();
      // act
      try{
        throw new Exception("Example Exception");
      }
      catch(e){
        // assert
        expect(() => eh.handle(e.toString(), crash:true), throwsA(isA<Exception>()));
      }
    },
  );

  test(
    'test exception handler should crash and warn if no option has been given',
    () async {
      // arrange
      final eh = ExceptionHandler();
      // act
      try{
        throw new Exception("Example Exception");
      }
      catch(e){
        // assert
        expect(() => eh.handle(e.toString()), throwsA(isA<Exception>()));
      }
    },
  );
/* Logging functionality is sadly broken
    Also, these tests are no longer applicable. Should instead make a call to the backend when something goes wrong
  test(
    'test exception handlers log is timestamped',
    () async {
      // arrange
      final eh = ExceptionHandler();
      eh.resetLog();

      // act
      try{
        throw new Exception("Some Exception");
      }
      catch(e){
        eh.handle(e, log:true);
      }

      // assert
      var logString = File(eh.logLocation).readAsStringSync();
      var now = DateHelper.currentTime();
      var nowWithoutSeconds = DateTime(now.year, now.month, now.day, now.hour, now.minute).toString().substring(0,16);
      expect(logString.contains(nowWithoutSeconds), true);
      eh.resetLog();
    },
  );
*/

// NEW TEST: If the Exception handler crashes while handling the Exception (like sending it to the backend), present some information to the user so as to contact customer support or something!
// DESIGN: The ExceptionHandler should never depend on anything else in the entire program!
}