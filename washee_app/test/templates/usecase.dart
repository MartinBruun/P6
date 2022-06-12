import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// class MockREPOSITORY_NAME extends Mock implements REPOSITORY_NAME {}

void main() {
  group("TEST_CLASS_NAME TEST_METHOD_NAME",() {
    test(
      """
        Should XXX
        When YYY
        Given ZZZ
      """,
      () async {
      // arrange

      // act

      // assert
    }, skip: true,
    tags: ["unittest","FEATURE_NAME","usecases","FILE_NAME","TEST_METHOD_NAME"]);
  });
}