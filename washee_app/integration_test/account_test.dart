import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:washee/features/account/presentation/provider/account_language_provider.dart';

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
    },
    tags: ["integrationtest","account","endtoendtest"]);
  });
}