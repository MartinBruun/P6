import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:washee/features/account/presentation/provider/account_language_provider.dart';

import '../lib/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> navigateToFeature() async {

  }

  group('FEATURE Navigation Test', () {
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
      await navigateToFeature();

      // assert
      expect(find.text(langProv.getText("SignInPage", "presentationText")), findsOneWidget);
    },
    tags: ["integrationtest","FEATURE","navigationtest"]);
  });

  group('Account End to End Tests', () {
    testWidgets("""
      Should be possible to login as a user on the sign in page
      Given the supplied user exists on the backend
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
    }, skip: true,
    tags: ["integrationtest","account","endtoendtest"]);
  });
}