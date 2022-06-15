import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/ui/navigation/home_screen.dart';
import 'package:washee/core/ui/themes/themes.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';
import 'package:washee/features/account/presentation/provider/account_provider.dart';

class MockAccountProvider extends Mock implements AccountProvider {}

void main() {

    Future<void> initializeApp(WidgetTester tester, {required AccountProvider mockAcc}) async {
        await tester.pumpWidget(MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (ctx) => mockAcc),
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
        AccountProvider mockAccountProvider = MockAccountProvider();
        UserEntity providedUser = UserEntity.anonymousUser(); // CHANGE THIS to firstUserFixture(). It is only to avoid syntax errors in the template
        providedUser.loggedIn = true;
        when(() => mockAccountProvider.currentUser).thenAnswer((_) => providedUser);
        await initializeApp(tester, mockAcc: mockAccountProvider);
      
        // act
        await navigateToPage();

        // assert
        String expectedTextToBeSeen = "UseALanguageProviderToSetTheTextHere";
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
        AccountProvider mockAccountProvider = MockAccountProvider();
        UserEntity providedUser = UserEntity.anonymousUser(); // CHANGE THIS to firstUserFixture(). It is only to avoid syntax errors in the template
        providedUser.loggedIn = true;
        when(() => mockAccountProvider.currentUser).thenAnswer((_) => providedUser);
        await initializeApp(tester, mockAcc: mockAccountProvider);
        await navigateToPage();
      
        // act
        
        // assert
        String expectedTextToBeSeen = "UseALanguageProviderToSetTheTextHere";
        expect(find.text(expectedTextToBeSeen),findsOneWidget);
    },
    tags: ["widgettest","FEATURE_NAME","pages"]);
  });
}