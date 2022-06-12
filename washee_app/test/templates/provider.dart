import 'dart:core';

import 'package:flutter_test/flutter_test.dart';

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
    tags: ["unittest","FEATURE_NAME","providers","FILE_NAME","TEST_METHOD_NAME"]);
  });
}