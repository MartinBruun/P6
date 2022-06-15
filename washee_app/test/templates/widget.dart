import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// class MockUSECASE_NAME extends Mock implements USECASE_NAME {}

// THIS TEMPLATE IS NOT WORKING YET! SEE PAGE FOR A WORKING EXAMPLE!
// THIS TEMPLATE IS FOR TESTING A SINGLE, MODULAR WIDGET! PAGE IS FOR TESTING NAVIGATION AND USECASES!

void main() {  
    group("TEST_WIDGET no interactions",() {
    testWidgets(
      """
        Should XXX
        When YYY
        Given ZZZ
      """,
      (tester) async {
        // arrange
        // WidgetName testWidget = WidgetName();
        // await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        String expectedTextToBeSeen = "OutputAUserCanActuallyExperience";

        // act

        // assert
        expect(find.text(expectedTextToBeSeen),findsOneWidget);
    }, skip: true,
    tags: ["widgettest","FEATURE_NAME","widgets"]);
  });
  group("TEST_WIDGET USE_CASE",() {
    testWidgets(
      """
        Should XXX
        When YYY
        Given ZZZ
      """,
      (tester) async {
        // arrange
        // WidgetName testWidget = WidgetName();
        // await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        String expectedTextToBeSeen = "OutputAUserCanActuallyExperience";

        // act

        // assert
        expect(find.text(expectedTextToBeSeen),findsOneWidget);
    }, skip: true,
    tags: ["widgettest","FEATURE_NAME","widgets"]);
  });
}