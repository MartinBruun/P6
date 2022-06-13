import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/features/account/domain/usecases/sign_in.dart';
import 'package:washee/main.dart';
import 'package:washee/injection_container.dart' as ic;

class MockSignInUsecase extends Mock implements SignInUseCase {}

void main() {
  group("SignInPage base (requirements)",() {
    testWidgets(
      """
        Should be the first page the user sees
        Given they cannot automatically sign in
      """,
      (tester) async {
      // arrange
      ic.initAll();
      WasheeApp mainWidget = WasheeApp();
      await tester.pumpWidget(mainWidget);
      await tester.pumpAndSettle();
      String expectedTextToBeSeen = "Log ind";
      
      // navigate
      // act
      // assert
      expect(find.text(expectedTextToBeSeen),findsOneWidget);
    },
    tags: ["widgettest","account","pages"]);
    testWidgets(
      """
        Should go to a different screen with a logged in user
        When the user enters the username and password in the form
        Given the username and password given is correct
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
    tags: ["widgettest","account","pages"]);
  });
  group("SignInPage UX (requirements)",() {
    test(
      """
        Should XXX
        When YYY
        Given ZZZ
      """,
      () async {
      // arrange

      // navigate

      // act

      // assert
    }, skip: true,
    tags: ["widgettest","account","pages"]);
  });
  group("SignInPage security (requirements)",() {
    test(
      """
        Should XXX
        When YYY
        Given ZZZ
      """,
      () async {
      // arrange

      // navigate

      // act

      // assert
    }, skip: true,
    tags: ["widgettest","account","pages"]);
  });
}