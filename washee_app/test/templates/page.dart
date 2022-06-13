import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:washee/main.dart';
import 'package:washee/injection_container.dart' as ic;
import 'package:mocktail/mocktail.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';
import 'package:washee/features/account/domain/usecases/auto_sign_in.dart';

// import '../../../../fixtures/entities/account/users.dart';

class MockAutoSignInUsecase extends Mock implements AutoSignInUsecase {}
// class MockUSECASE_NAME extends Mock implements USECASE_NAME {}

void main() {
  void automaticSignIn(bool autoSignIn){
    UserEntity activeUser = UserEntity.anonymousUser();
    if(autoSignIn){
      // activeUser = firstUserFixture();
    }
    when(
      () => MockAutoSignInUsecase().call(AutoSignInParams()))
      .thenAnswer((_) async => activeUser);
  }
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
        automaticSignIn(true);
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