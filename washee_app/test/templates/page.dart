import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/navigation/home_screen.dart';
import 'package:washee/core/ui/themes/themes.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';
import 'package:washee/features/account/presentation/providers/account_current_user_provider.dart';

class MockAccountProvider extends Mock implements AccountCurrentUserProvider {}

void main() {

    Future<void> initializeApp(WidgetTester tester, {required bool autoLogin, required AccountCurrentUserProvider mockAcc}) async {
        // Setup Automatic login
        UserEntity providedUser = UserEntity.anonymousUser();
        providedUser.loggedIn = autoLogin;
        when(() => mockAcc.currentUser).thenAnswer((_) => providedUser);
        // Setup home widget
        await tester.pumpWidget(MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (ctx) => mockAcc),
          ],
          child: ScreenUtilInit(
            designSize: Size(1000, 1600),
            builder: (context, child) => MaterialApp(
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

  Future<void> navigateToPage() async {

  }

  group("TEST_PAGE basic navigation",() {
    testWidgets(
      """
        Should be able to navigate to TEST_PAGE
        Given the user can automatically sign in
      """,
      (tester) async {
        // arrange
        AccountCurrentUserProvider mockAccountProvider = MockAccountProvider();
        await initializeApp(tester, autoLogin: true, mockAcc: mockAccountProvider);
      
        // act
        await navigateToPage();

        // assert
        String expectedTextToBeSeen = "UseANonMockedLanguageProviderToSetTheTextHere";
        expect(find.text(expectedTextToBeSeen),findsOneWidget);
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
        AccountCurrentUserProvider mockAccountProvider = MockAccountProvider();
        await initializeApp(tester, autoLogin: true, mockAcc: mockAccountProvider);
        await navigateToPage();
      
        // act
        
        // assert
        String expectedTextToBeSeen = "UseANonMockedLanguageProviderToSetTheTextHere";
        expect(find.text(expectedTextToBeSeen),findsOneWidget);
    },
    tags: ["widgettest","FEATURE_NAME","pages"]);
  });
}