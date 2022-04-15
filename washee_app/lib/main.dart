import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/environments/environment.dart';
import 'package:washee/core/pages/home_screen.dart';
import 'package:washee/core/providers/global_provider.dart';
import 'package:washee/features/booking/presentation/provider/calendar_provider.dart';
import 'package:washee/features/unlock/presentation/provider/unlock_provider.dart';
import 'injection_container.dart' as ic;
import 'core/presentation/themes/themes.dart';

void main() async {
  final String env = kDebugMode ? Environment.DEV : Environment.PROD;

  print("YOU ARE USING THE ("+ env + ") ENVIRONMENT!");
  Environment().initConfig(env);
  WidgetsFlutterBinding.ensureInitialized();
  ic.initAll();
  print(Environment().config.webApiHost);
  print(Environment().config.boxApiHost);
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
      ],
      child: ScreenUtilInit(
        designSize: Size(1000, 1600),
        builder: () => MaterialApp(
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
