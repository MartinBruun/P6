import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:washee/injection_container.dart' as ic;
import 'package:washee/core/account/user.dart';
import 'package:washee/core/pages/home_screen.dart';
import 'package:washee/core/pages/pages_enum.dart';
import 'package:washee/core/presentation/themes/themes.dart';
import 'package:washee/core/providers/global_provider.dart';
import 'package:washee/features/booking/presentation/provider/booking_provider.dart';
import 'package:washee/features/booking/presentation/provider/calendar_provider.dart';
import 'package:washee/features/sign_in/presentation/provider/sign_in_provider.dart';
import 'package:washee/features/unlock/presentation/provider/unlock_provider.dart';

void main() {
  Widget createWidgetUnderTest() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UnlockProvider()),
        ChangeNotifierProvider(create: (ctx) => GlobalProvider()),
        ChangeNotifierProvider(create: (ctx) => CalendarProvider()),
        ChangeNotifierProvider(create: (ctx) => SignInProvider()),
        ChangeNotifierProvider(create: (ctx) => BookingProvider()),
      ],
      child: ScreenUtilInit(
        designSize: Size(1000, 1600),
        builder: () => MaterialApp(
          title: "Washee App",
          debugShowCheckedModeBanner: true,
          theme: getMainTheme(),
          home: HomeScreen(
            page: PageNumber.WashScreen,
          ),
          routes: {},
        ),
      ),
    );
  }

  setUp() {
    ic.initAll();
  }

  testWidgets("Maskiner text is displayed", (WidgetTester tester) async {
    setUp();
    ActiveUser user = ActiveUser();
    user.initUser(1, "email", "username", [
      {'account_id': 1, 'name': "some_name", 'balance': 20.0}
    ]);
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.text("Maskiner"), findsOneWidget);
  });
}
