import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// class MockDEPENDENCY_NAME extends Mock implements DEPEDENDENCY_NAME {}

void main() {
  group("TEST_CLASS TEST_METHOD_NAME",() {
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
    tags: ["unittest","core","FOLDER_NAME"]);
  });
}