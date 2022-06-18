import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/ui/navigation/home_screen.dart';
import 'package:washee/core/ui/themes/themes.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';
import 'package:washee/features/account/presentation/provider/account_language_provider.dart';
import 'package:washee/features/account/presentation/provider/account_current_user_provider.dart';

import '../../../../fixtures/entities/account/users.dart';

class MockAccountFunctionalityProvider extends Mock implements AccountCurrentUserProvider {}

void main() {

  Future<void> initializeApp(WidgetTester tester, {required AccountCurrentUserProvider mockAcc, required AccountLanguageProvider mockAccountLang}) async {
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => mockAcc),
        ChangeNotifierProvider(create: (ctx) => mockAccountLang),
      ],
      child: ScreenUtilInit(
        designSize: Size(1000, 1600),
        builder: (_) => MaterialApp(
          title: "Washee App",
          debugShowCheckedModeBanner: true,
          theme: getMainTheme(),
          home: HomeScreen(),
          routes: {},
        ),
      ),
    ));
    await tester.pumpAndSettle();
  }

  group("SignInPage basic navigation",() {
    testWidgets(
      """
        Should be the first page the user sees
        Given they cannot automatically sign in
      """,
      (tester) async {
      // arrange
      AccountCurrentUserProvider mockAccountProvider = MockAccountFunctionalityProvider();
      UserEntity providedUser = UserEntity.anonymousUser();
      providedUser.loggedIn = false;
      when(() => mockAccountProvider.currentUser).thenAnswer((_) => providedUser);
      when(() => mockAccountProvider.signinIn).thenAnswer((_) => false);
      AccountLanguageProvider langProv = AccountLanguageProvider();
      await initializeApp(tester, mockAcc: mockAccountProvider, mockAccountLang: langProv);
      
      // navigate
      // act
      // assert
      String expectedTextToBeSeen = langProv.getText("SignInPage", "presentationText");
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
      AccountCurrentUserProvider mockAccountProvider = MockAccountFunctionalityProvider();
      UserEntity providedUser = firstUserFixture();
      providedUser.loggedIn = true;
      when(() => mockAccountProvider.currentUser).thenAnswer((_) => providedUser);
      AccountLanguageProvider langProv = AccountLanguageProvider();
      await initializeApp(tester, mockAcc: mockAccountProvider, mockAccountLang: langProv);
      
      // act
      // assert
      String expectedTextNotToBeSeen = langProv.getText("SignInPage", "presentationText");
      expect(find.text(expectedTextNotToBeSeen),findsNothing);
    },
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
      AccountCurrentUserProvider mockAccountProvider = MockAccountFunctionalityProvider();
      UserEntity initialUser = UserEntity.anonymousUser();
      initialUser.loggedIn = false;
      String testUsername = initialUser.username;
      String testPassword = "SomePassword";
      when(() => mockAccountProvider.currentUser).thenAnswer((_) => initialUser);
      when(() => mockAccountProvider.signIn(username: testUsername, password: testPassword)).thenAnswer((_) async {
        initialUser.loggedIn = true;
      });
      when(() => mockAccountProvider.signinIn).thenAnswer((_) => false);
      AccountLanguageProvider langProv = AccountLanguageProvider();
      await initializeApp(tester, mockAcc: mockAccountProvider, mockAccountLang: langProv);
      
      // act
      //expect(find.text(langProv.getText("SignInPage", "usernameField")), findsOneWidget);
      //expect(1,0);
      Finder usernameTextInputField = find.byKey(Key(langProv.getText("SignInPage", "usernameField")));
      expect(usernameTextInputField, findsOneWidget);
      await tester.enterText(usernameTextInputField, testUsername);
      Finder passwordTextInputField = find.byKey(Key(langProv.getText("SignInPage", "passwordField")));
      expect(passwordTextInputField, findsOneWidget);
      await tester.enterText(passwordTextInputField, testPassword);
      await tester.pumpAndSettle();
      await tester.tap(find.text(langProv.getText("SignInPage", "buttonText")));
      await tester.pumpAndSettle();

      // assert
      String expectedTextNotToBeSeen = langProv.getText("SignInPage", "presentationText");
      expect(find.text(expectedTextNotToBeSeen),findsNothing);
      expect(mockAccountProvider.currentUser.loggedIn, true);
    },
    tags: ["widgettest","account","pages"]);
  });
}