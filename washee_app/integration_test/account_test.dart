import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:washee/features/account/presentation/providers/account_language_provider.dart';

import '../lib/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() async {
    // Reset dependencies for each test
    final getIt = GetIt.instance;

    await getIt.reset();
  });

  group('Account Navigation Test', () {
    testWidgets(
      """
      Should be the initial page seen without any navigation
      """,
        (tester) async {
      // arrange
      app.main();
      await tester.pumpAndSettle();
      var langProv = AccountLanguageProvider();

      // act

      // assert
      expect(find.text(langProv.getText("SignInPage", "presentationText")), findsOneWidget);
    },
    tags: ["integrationtest","account","navigationtest"]);
  });

  group('Account Acceptance Tests', () {
    testWidgets("""
      As a User
      I want to be able to login to my account
      Because i want the application to register my actions, 
        so it remembers what i did previously making my use more seamless
      """,
        (tester) async {
      // arrange
      app.main();
      await tester.pumpAndSettle();
      var langProv = AccountLanguageProvider();
      String testUsernameOnBackend = "admin@mail.com";
      String testPasswordOnBackend = "password";

      // act
      Finder usernameTextInputField = find.byKey(Key(langProv.getText("SignInPage", "usernameField")));
      expect(usernameTextInputField, findsOneWidget);
      await tester.enterText(usernameTextInputField, testUsernameOnBackend);
      Finder passwordTextInputField = find.byKey(Key(langProv.getText("SignInPage", "passwordField")));
      expect(passwordTextInputField, findsOneWidget);
      await tester.enterText(passwordTextInputField, testPasswordOnBackend);
      await tester.pumpAndSettle();
      await tester.tap(find.text(langProv.getText("SignInPage", "buttonText")));
      await tester.pumpAndSettle();

      // assert
      String expectedTextNotToBeSeen = langProv.getText("SignInPage", "presentationText");
      expect(find.text(expectedTextNotToBeSeen),findsNothing);
    },
    tags: ["integrationtest","account","acceptance"]);
  });
    group('Account Penetration Tests', () {
    testWidgets("""
      As an *Hacker*
      I will try *Attack*
      Because of *Reason*
      """,
        (tester) async {
      // arrange
      app.main();
      await tester.pumpAndSettle();

      // act

      // assert
    }, skip: true,
    tags: ["integrationtest","account","penetration"]);
  });
}