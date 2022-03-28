import 'package:flutter/material.dart';

import '../../../get_machines/presentation/widgets/machine_overview.dart';

class WashScreen extends StatefulWidget {
  static const routeName = "/wash-screen";
  const WashScreen({Key? key}) : super(key: key);

  @override
  _WashScreenState createState() => _WashScreenState();
}

class _WashScreenState extends State<WashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: MachineOverview(),
    );
  }
}
