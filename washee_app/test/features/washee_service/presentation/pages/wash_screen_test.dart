import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/usecases/usecase.dart';
import 'package:washee/core/washee_box/machine_model.dart';
import 'package:washee/core/widgets/machine_card.dart';
import 'package:washee/features/get_machines/domain/usecases/get_machines.dart';
import 'package:washee/features/unlock/presentation/pages/wash_screen.dart';
import 'package:washee/injection_container.dart' as ic;
import 'package:washee/core/account/user.dart';
import 'package:washee/core/presentation/themes/themes.dart';
import 'package:washee/core/providers/global_provider.dart';
import 'package:washee/features/booking/presentation/provider/booking_provider.dart';
import 'package:washee/features/booking/presentation/provider/calendar_provider.dart';
import 'package:washee/features/sign_in/presentation/provider/sign_in_provider.dart';
import 'package:washee/features/unlock/presentation/provider/unlock_provider.dart';

class MockGetMachinesUseCase extends Mock implements GetMachinesUseCase {}

late List<MachineModel> mockMachines;

// This function sets up the prerequisites needed for the tests to run.
setUp() {
  ic.initAll();
  ActiveUser user = ActiveUser();
  user.initUser(1, "email", "username", [
    {'account_id': 1, 'name': "some_name", 'balance': 20.0}
  ]);
  mockMachines = [
    MachineModel(machineID: "machineID1", name: "name1", machineType: "Wash"),
    MachineModel(machineID: "machineID2", name: "name2", machineType: "Wash"),
    MachineModel(machineID: "machineID3", name: "name3", machineType: "Dry")
  ];
}

// Mocking a response from the usecase
arrangeMachineModelsReturnAfter3Seconds(MockGetMachinesUseCase usecase) {
  when(() => usecase.call(NoParams())).thenAnswer((_) async {
    await Future.delayed(const Duration(seconds: 3));
    return mockMachines;
  });
}

arrangeMachineModelsReturned(MockGetMachinesUseCase usecase) {
  when(() => usecase.call(NoParams())).thenAnswer((_) async {
    return mockMachines;
  });
}

void main() {
  MockGetMachinesUseCase usecase = MockGetMachinesUseCase();
  setUp();

  // Returns the widget we want to test - in this case the WashScreen
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
        builder: (_) => MaterialApp(
          title: "Washee App",
          debugShowCheckedModeBanner: true,
          theme: getMainTheme(),
          home: WashScreen(),
          routes: {},
        ),
      ),
    );
  }

  group("Static widgets: ", () {
    testWidgets("Maskiner text is displayed on WashScreen",
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.text("Maskiner"), findsOneWidget);
    });
  });

  group("Dynamic widgets: ", () {
    testWidgets(
        "CircularProgressIndicator is displayed on WashScreen when fetching from backend",
        (WidgetTester tester) async {
      // arrange
      arrangeMachineModelsReturnAfter3Seconds(usecase);
      await tester.pumpWidget(createWidgetUnderTest());

      // act
      // We "pump" a frame on the stack every 500 miliseconds
      // This is needed to capture the progress indicator spinning
      await tester.pump(const Duration(milliseconds: 500));

      // assert
      expect(find.byKey(Key('machines-progress-indicator')), findsOneWidget);
    });

    testWidgets("Refresh text is displayed on WashScreen after backend fetch",
        (WidgetTester tester) async {
      tester.runAsync(() async {
        await arrangeMachineModelsReturned(usecase);
        await tester.pumpWidget(createWidgetUnderTest());

        // this pumps every frame to the stack and waits for them all to finish
        await tester.pumpAndSettle();

        expect(find.byKey(Key('refresh-text')), findsOneWidget);
      });
    });

    testWidgets(
        "Refresh IconButton is displayed on WashScreen after backend fetch",
        (WidgetTester tester) async {
      tester.runAsync(() async {
        await arrangeMachineModelsReturned(usecase);
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pumpAndSettle();
        expect(find.byKey(Key('refresh-iconbutton')), findsOneWidget);
      });
    });

    testWidgets("Machines are displayed after successfull backend fetch",
        (WidgetTester tester) async {
      tester.runAsync(() async {
        await arrangeMachineModelsReturned(usecase);
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pumpAndSettle();
        for (final machine in mockMachines) {
          expect(find.byType(MachineCard), findsOneWidget);
        }
      });
    });
  });
}
