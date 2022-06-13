import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:washee/main.dart';
import 'package:washee/injection_container.dart' as ic;
// import 'package:mocktail/mocktail.dart';

// class MockUSECASE_NAME extends Mock implements USECASE_NAME {}

void main() {
group("TEST_PAGE no interactions",() {
    testWidgets(
      """
        Should XXX
        When YYY
        Given ZZZ
      """,
      (tester) async {
        // arrange
        ic.initAll();
        WasheeApp mainWidget = WasheeApp();
        await tester.pumpWidget(mainWidget);
        await tester.pumpAndSettle();
        String expectedTextToBeSeen = "OutputAUserCanActuallyExperience";
        
        // navigate

        // act

        // assert
        expect(find.text(expectedTextToBeSeen),findsOneWidget);
    }, skip: true,
    tags: ["widgettest","FEATURE_NAME","pages"]);
  });
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
        WasheeApp mainWidget = WasheeApp();
        await tester.pumpWidget(mainWidget);
        await tester.pumpAndSettle();
        String expectedTextToBeSeen = "OutputAUserCanActuallyExperience";
        
        // navigate

        // act

        // assert
        expect(find.text(expectedTextToBeSeen),findsOneWidget);
    }, skip: true,
    tags: ["widgettest","FEATURE_NAME","pages"]);
  });
}