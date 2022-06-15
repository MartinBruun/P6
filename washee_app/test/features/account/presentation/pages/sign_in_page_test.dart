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
import 'package:washee/features/account/presentation/provider/account_provider.dart';
import 'package:washee/features/account/presentation/provider/sign_in_provider.dart';

import '../../../../fixtures/entities/account/users.dart';

class MockAccountProvider extends Mock implements AccountProvider {}

void main() {

  Future<void> initializeApp(WidgetTester tester, {required AccountProvider mockAcc, required AccountLanguageProvider mockAccountLang}) async {
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => SignInProvider()),
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
      AccountProvider mockAccountProvider = MockAccountProvider();
      UserEntity providedUser = UserEntity.anonymousUser();
      providedUser.loggedIn = false;
      when(() => mockAccountProvider.currentUser).thenAnswer((_) => providedUser);
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
      AccountProvider mockAccountProvider = MockAccountProvider();
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
      AccountProvider mockAccountProvider = MockAccountProvider();
      UserEntity providedUser = firstUserFixture();
      providedUser.loggedIn = true;
      when(() => mockAccountProvider.currentUser).thenAnswer((_) => providedUser);
      AccountLanguageProvider langProv = AccountLanguageProvider();
      await initializeApp(tester, mockAcc: mockAccountProvider, mockAccountLang: langProv);
      
      // act
      await tester.pump(Duration(milliseconds: 400));
      expect(langProv.getText("SignInPage", "usernameField"), "Email");
      var a = find.text(langProv.getText("SignInPage", "usernameField"));
      expect(a, findsOneWidget);
      expect(langProv.getText("SignInPage", "usernameField"), "Email1");

      await tester.enterText(find.text(langProv.getText("SignInPage", "usernameField")), "ValidUsername");
      await tester.enterText(find.text(langProv.getText("SignInPage", "passwordField")), "ValidPassword");
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