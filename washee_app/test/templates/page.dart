import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
import 'package:washee/main.dart';
import 'package:washee/injection_container.dart' as ic;

// class MockUSECASE_NAME extends Mock implements USECASE_NAME {}

void main() {
  group("TEST_PAGE USE_CASE",() {
    testWidgets(
      """
        Should XXX
        When YYY
        Given ZZZ
      """,
      (tester) async {
      // arrange
      ic.initAll();
      await tester.pumpWidget(WasheeApp());
      await tester.pumpAndSettle();

      // navigate

      // act

      // assert
    }, skip: true,
    tags: ["widgettest","FEATURE_NAME","pages"]);
  });
}