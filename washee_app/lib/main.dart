import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/environments/environment.dart';
import 'package:washee/core/pages/home_screen.dart';
import 'package:washee/core/providers/global_provider.dart';
import 'package:washee/features/unlock/presentation/provider/unlock_provider.dart';
import 'injection_container.dart' as ic;
import 'core/presentation/themes/themes.dart';

void main() async {
  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.DEV,
  );
  Environment().initConfig(environment);
  WidgetsFlutterBinding.ensureInitialized();
  ic.initAll();
  runApp(WasheeApp());
}

class WasheeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UnlockProvider()),
        ChangeNotifierProvider(create: (ctx) => GlobalProvider()),
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
