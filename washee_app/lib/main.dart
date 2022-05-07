import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart';
import 'package:washee/core/environments/environment.dart';
import 'package:washee/core/helpers/authorizer.dart';
import 'package:washee/core/pages/home_screen.dart';
import 'package:washee/core/providers/global_provider.dart';
import 'package:washee/features/booking/presentation/provider/booking_provider.dart';
import 'package:washee/features/booking/presentation/provider/calendar_provider.dart';
import 'package:washee/features/sign_in/presentation/provider/sign_in_provider.dart';
import 'package:washee/features/unlock/presentation/provider/unlock_provider.dart';
import 'injection_container.dart' as ic;
import 'core/presentation/themes/themes.dart';
import 'package:washee/injection_container.dart';

void main() async {
  await setupEnvironment();
  WidgetsFlutterBinding.ensureInitialized();
  ic.initAll();
  ByteData tzf = await rootBundle.load('assets/2021a.tzf');
  initializeDatabase(tzf.buffer.asUint8List());

  print("From main.dart: webApiHost = ${Environment().config.webApiHost}");
  print("From main.dart: boxApiHost = ${Environment().config.boxApiHost}");
  print("From main.dart: boxWifiSSID = ${Environment().config.boxWifiSSID}");
  print(
      "From main.dart: boxWifiPassword = ${Environment().config.boxWifiPassword}");
  print(
      "From main.dart: boxHasInternetAccess = ${Environment().config.boxHasInternetAccess}");

  if (kDebugMode) {
    await sl<Authorizer>().removeAllCredentials();
  }
  await sl<Authorizer>().autoSignIn();
  runApp(WasheeApp());
}

class WasheeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          home: HomeScreen(),
          routes: {},
        ),
      ),
    );
  }
}

Future<void> setupEnvironment() async {
  String env = Environment.PROD;
  String envFile = Environment.PROD_ENV;
  if (kDebugMode) {
    env = Environment.DEV;
    envFile = Environment.DEV_ENV;
  }
  await dotenv.load(fileName: envFile);

  Environment().initConfig(env);
}
