import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/helpers/date_helper.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';
import 'package:washee/features/sign_out/presentation/widgets/yes_button.dart';
import 'package:washee/features/unlock/domain/usecases/unlock.dart';
import 'package:washee/injection_container.dart' as ic;
import 'package:washee/core/presentation/themes/themes.dart';
import 'package:washee/core/providers/global_provider.dart';
import 'package:washee/features/booking/presentation/provider/booking_provider.dart';
import 'package:washee/features/booking/presentation/provider/calendar_provider.dart';
import 'package:washee/features/sign_in/presentation/provider/sign_in_provider.dart';
import 'package:washee/features/unlock/presentation/provider/unlock_provider.dart';

class MockUnlockUseCase extends Mock implements UnlockUseCase {}

class MockDateHelper extends Mock implements DateHelper {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockGlobalProvider extends Mock implements GlobalProvider {}

class MockUnlockProvider extends Mock implements UnlockProvider {}

setUp() {
  ic.initAll();
}

void main() {
  MockNavigatorObserver mockNavigatorObserver = MockNavigatorObserver();
  MockGlobalProvider mockGlobalProvider = MockGlobalProvider();
  MockUnlockProvider mockUnlockProvider = MockUnlockProvider();
  MockUnlockUseCase mockUnlockUseCase = MockUnlockUseCase();
  setUp();

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
          home: YesButton(),
          routes: {},
        ),
      ),
    );
  }

  group("Dynamic widgets: ", () {
    testWidgets(
        """
          When User press Yes on YesButton that asks to unlock a specific machine,
          it should return the user to the home screen,
          given UnlockUseCase is assumed to properly have unlocked the machine and updated the backend,
          and GlobalProvider gets properly updated with the new activated bookings, 
          and UnlockProvider correctly sets the timings of when unlocking is starting and finishing (for animations purposes).
        """,
        (WidgetTester tester) async {
      // arrange
      DateTime initStartTime = DateTime(2022, 01, 01, 2, 0);
      MockDateHelper mockDateHelper = MockDateHelper();
      when(() => mockDateHelper.convertToNonNaiveTime(initStartTime))
        .thenAnswer((_) => "2022-01-01T01:02:00Z");
      BookingModel fakeBooking = BookingModel(
        dateHelper: mockDateHelper,
        bookingID: 12,
        startTime: initStartTime,
        machineResource: "http://test.com/machines/12",
        serviceResource: "http://test.com/services/12",
        accountResource: "http://test.com/accouts/12");
      List<BookingModel> bookingsToUnlock = [fakeBooking];
      UnlockParams params = UnlockParams(bookings: bookingsToUnlock);
      List<BookingModel> bookingsToUnlockActivated = bookingsToUnlock;
      bookingsToUnlockActivated[0].activated = true;
      when(() => mockUnlockUseCase.call(params))
        .thenAnswer((_) async => bookingsToUnlockActivated);
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // act
      expect(find.byType(ElevatedButton), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // assert
      // TODO:: updateMachine sounds kind of wrong? 
      // The Provide sets "updateCurrentlyActiveMachine" or not? 
      //And shouldnt it set a time? 
      //I havent been much into this specific part of the code
      verify(mockGlobalProvider.updateMachine(bookingsToUnlockActivated)); 
      // TODO: Consider encapsulating these in a verifyInOrder to make sure the order is right
      verify(mockUnlockProvider.startUnlocking().called(1));
      verify(mockUnlockUseCase.call(params).called(1));
      verify(mockUnlockProvider.stopUnlocking().called(1));
      // Dont know how to put route and previous route on a "ReplaceRoute" call which the yes button does
      verify(mockNavigatorObserver.didPush(route, previousRoute));
    });
  });
}