import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/pages/home_screen.dart';
import 'injection_container.dart' as ic;
import 'core/presentation/themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ic.initAll();
  runApp(WasheeApp());
}

class WasheeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1000, 1600),
      builder: () => MaterialApp(
        title: "Washee App",
        debugShowCheckedModeBanner: true,
        theme: getMainTheme(),
        home: HomeScreen(),
        routes: {},
      ),
    );
  }
}
