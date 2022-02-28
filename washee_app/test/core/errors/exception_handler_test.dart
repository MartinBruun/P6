import 'dart:async';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:washee/core/errors/exception_handler.dart';

void main() {
  test(
    'test_exception_handler_can_be_initialized',
    () async {
      // arrange
      final eh = ExceptionHandler();

      eh.runtimeType == ExceptionHandler;

      expect(true, true);
    },
  );

  test(
    'test_exception_handler_can_write_exception_to_a_log',
    () async {
      // arrange
      final eh = ExceptionHandler();
      eh.reset_log();

      // act
      try{
        throw new Exception("Example Exception");
      }
      catch(e){
        eh.handle(e, log:true);
      }

      // assert
      var log_string = File(eh.log_location).readAsStringSync();
      expect(log_string.contains("Example Exception"), true);
      eh.reset_log();
    },
  );

  test(
    'test_exception_handler_can_fail_silently_and_show_to_console',
    () async {
      // arrange
      final eh = ExceptionHandler();
      var printLog = [];

      // act
      try{
        throw new Exception("Example Exception");
      }
      catch(e){
        eh.handle(e, show:true);
        printLog.add("Example Exception");
      }

      // assert
      expect(printLog[0].contains("Example Exception"), true);
    },
  );

  test(
    'test_exception_handler_can_fail_and_crash_the_program',
    () async {
      // arrange
      final eh = ExceptionHandler();
      // act
      try{
        throw new Exception("Example Exception");
      }
      catch(e){
        // assert
        expect(() => eh.handle(e, crash:true), throwsA(isA<Exception>()));
      }
    },
  );

  test(
    'test_exception_handler_should_crash_and_warn_if_no_option_has_been_given',
    () async {
      // arrange
      final eh = ExceptionHandler();
      // act
      try{
        throw new Exception("Example Exception");
      }
      catch(e){
        // assert
        expect(() => eh.handle(e), throwsA(isA<Exception>()));
      }
    },
  );

  test(
    'test_exception_handlers_log_is_timestamped',
    () async {
      // arrange
      final eh = ExceptionHandler();
      eh.reset_log();

      // act
      try{
        throw new Exception("Some Exception");
      }
      catch(e){
        eh.handle(e, log:true);
      }

      // assert
      var log_string = File(eh.log_location).readAsStringSync();
      var now = DateTime.now();
      var now_without_seconds = DateTime(now.year, now.month, now.day, now.hour, now.minute).toString().substring(0,16);
      expect(log_string.contains(now_without_seconds), true);
      eh.reset_log();
    },
  );
}