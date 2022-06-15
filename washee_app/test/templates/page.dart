import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:washee/main.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';
import 'package:washee/features/account/domain/usecases/auto_sign_in.dart';

// import '../../../../fixtures/entities/account/users.dart';

class MockAutoSignInUsecase extends Mock implements AutoSignInUsecase {}
// class MockUSECASE_NAME extends Mock implements USECASE_NAME {}

final List<String> passedTests = [];

void main() {

  UserEntity automaticSignIn(bool autoSignIn){
    UserEntity activeUser = UserEntity.anonymousUser();
    if(autoSignIn){
      // activeUser = firstUserFixture();  // REMEMBER TO UNCOMMENT!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    }
    when(
      () => MockAutoSignInUsecase().call(AutoSignInParams()))
      .thenAnswer((_) async => activeUser);
    return activeUser;
  }

  void navigateToPage(){

  }

  group("TEST_PAGE basic navigation",() {
    testWidgets(
      """
        Should XXX
        When YYY
        Given ZZZ
      """,
      (tester) async {
        // arrange
        UserEntity currentUser = automaticSignIn(true);
        WasheeApp mainWidget = WasheeApp(currentUser: currentUser);
        await tester.pumpWidget(mainWidget);
        await tester.pumpAndSettle();
        navigateToPage();
        String expectedTextToBeSeen = "OutputAUserCanActuallyExperience";

        // act

        // assert
        expect(find.text(expectedTextToBeSeen),findsOneWidget);
        passedTests.add("canNavigateToPage");
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
        UserEntity currentUser = automaticSignIn(true);
        WasheeApp mainWidget = WasheeApp(currentUser: currentUser);
        await tester.pumpWidget(mainWidget);
        await tester.pumpAndSettle();
        navigateToPage();
        String expectedTextToBeSeen = "OutputAUserCanActuallyExperience";

        // act

        // assert
        expect(find.text(expectedTextToBeSeen),findsOneWidget);
    }, skip: !passedTests.contains("canNavigateToPage"),
    tags: ["widgettest","FEATURE_NAME","pages"]);
  });
}