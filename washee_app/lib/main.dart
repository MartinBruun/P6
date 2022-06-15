import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart';
import 'package:washee/core/standards/environments/environment.dart';
import 'package:washee/core/externalities/web/authorizer.dart';
import 'package:washee/core/ui/navigation/home_screen.dart';
import 'package:washee/core/ui/global_providers/global_provider.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';
import 'package:washee/features/account/domain/usecases/auto_sign_in.dart';
import 'package:washee/features/account/presentation/provider/user_provider.dart';
import 'package:washee/features/booking/presentation/provider/booking_provider.dart';
import 'package:washee/features/booking/presentation/provider/calendar_provider.dart';
import 'package:washee/features/account/presentation/provider/sign_in_provider.dart';
import 'package:washee/features/location/presentation/provider/unlock_provider.dart';
import 'injection_container.dart' as ic;
import 'core/ui/themes/themes.dart';
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

  await sl<Authorizer>().autoSignIn();

  UserEntity currentUser = await sl<AutoSignInUsecase>().call(AutoSignInParams());
  runApp(WasheeApp(currentUser: currentUser));
}

class WasheeApp extends StatelessWidget {
  final UserEntity currentUser;

  WasheeApp({required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UnlockProvider()),
        ChangeNotifierProvider(create: (ctx) => GlobalProvider()),
        ChangeNotifierProvider(create: (ctx) => CalendarProvider()),
        ChangeNotifierProvider(create: (ctx) => SignInProvider()),
        ChangeNotifierProvider(create: (ctx) => BookingProvider()),
        ChangeNotifierProvider(create: (ctx) => UserProvider(currentUser: currentUser)),
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
