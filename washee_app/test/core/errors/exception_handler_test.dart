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

      // act

      // assert
      expect(true, false);
    },
  );

  test(
    'test_exception_handler_can_fail_silently_and_show_to_console',
    () async {
      // arrange

      // act

      // assert
      expect(true, false);
    },
  );

  test(
    'test_exception_handler_can_fail_and_crash_the_program',
    () async {
      // arrange

      // act

      // assert
      expect(true, false);
    },
  );

  test(
    'test_exception_handler_should_crash_and_warn_if_no_option_has_been_given',
    () async {
      // arrange
      final eh = ExceptionHandler();
      try{
        throw new Exception("Example Exception");
      }
      catch(e){
        // act & assert
        expect(() => eh.handle(e), throwsA(isA<Exception>()));
      }
    },
  );

  test(
    'test_exception_handlers_log_is_timestamped',
    () async {
      // arrange

      // act

      // assert
      expect(true, false);
    },
  );
}