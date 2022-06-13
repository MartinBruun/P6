import 'dart:core';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group("TEST_MODEL TEST_METHOD_NAME",() {
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
    tags: ["unittest","FEATURE_NAME","models"]);
  });
}