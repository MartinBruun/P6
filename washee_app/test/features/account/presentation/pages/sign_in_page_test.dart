import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';
import 'package:washee/features/account/domain/usecases/auto_sign_in.dart';
import 'package:washee/features/account/domain/usecases/sign_in.dart';
import 'package:washee/main.dart';
import 'package:washee/injection_container.dart' as ic;

import '../../../../fixtures/entities/account/users.dart';

class MockAutoSignInUsecase extends Mock implements AutoSignInUsecase {}
class MockSignInUsecase extends Mock implements SignInUseCase {}

void main() {

  UserEntity automaticSignIn(bool autoSignIn){
    UserEntity activeUser = UserEntity.anonymousUser();
    if(autoSignIn){
      activeUser = firstUserFixture();
    }
    when(
      () => MockAutoSignInUsecase().call(AutoSignInParams()))
      .thenAnswer((_) async => activeUser);
    return activeUser;
  }

  group("SignInPage basic navigation",() {
    testWidgets(
      """
        Should be the first page the user sees
        Given they cannot automatically sign in
      """,
      (tester) async {
      // arrange
      ic.initAll();
      UserEntity currentUser = automaticSignIn(false);
      expect(currentUser.loggedIn, false);
      WasheeApp mainWidget = WasheeApp();
      await tester.pumpWidget(mainWidget);
      await tester.pumpAndSettle();

      String expectedTextToBeSeen = "Velkommen til Washee";
      
      // navigate
      // act
      // assert
      expect(find.text(expectedTextToBeSeen),findsOneWidget);
    },
    tags: ["widgettest","account","pages"]);
    testWidgets(
      """
        Should skip the page entirely
        Given the user can automatically sign in
      """,
      (tester) async {
      // arrange
      ic.initAll();
      UserEntity currentUser = automaticSignIn(true);
      expect(currentUser.loggedIn, true);
      WasheeApp mainWidget = WasheeApp();
      await tester.pumpWidget(mainWidget);
      await tester.pumpAndSettle();
      String expecteNotVisibleText = "Velkommen til Washee";
      
      // navigate
      // act
      // assert
      expect(find.text(expecteNotVisibleText),findsNothing);
    }, skip: true,
    tags: ["widgettest","account","pages"]);
  });
  group("SignInPage SignInUsecase",() {
    testWidgets(
      """
        Should go to a different screen with a logged in user
        When the user enters the username and password in the form
        Given the username and password given is correct
      """,
      (tester) async {
      // arrange
      ic.initAll();
      UserEntity currentUser = automaticSignIn(false);
      expect(currentUser.loggedIn, false);
      WasheeApp mainWidget = WasheeApp();
      await tester.pumpWidget(mainWidget);
      await tester.pumpAndSettle();

      currentUser.loggedIn = true;
      when(
        () => MockSignInUsecase().call(SignInParams(email: currentUser.email, password: "testPassword")));
      //  .thenAnswer((_) => currentUser);

      String expecteNotVisibleText = "Velkommen til Washee";
      
      // navigate
      // act
      // assert
      expect(currentUser.loggedIn, true);
      expect(find.text(expecteNotVisibleText),findsNothing);
    }, skip: true,
    tags: ["widgettest","account","pages"]);
  });
}