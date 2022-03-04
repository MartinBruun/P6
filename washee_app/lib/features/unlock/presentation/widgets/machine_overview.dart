import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../../core/widgets/unlock_button.dart';

class MachineOverview extends StatefulWidget {
  MachineOverview({Key? key}) : super(key: key);

  @override
  State<MachineOverview> createState() => _MachineOverviewState();
}

class _MachineOverviewState extends State<MachineOverview> {
  bool _isConnecting = false;
  _mockConnectingToBox() async {
    await Future.delayed(Duration(seconds: 3));
  }

  @override
  void initState() {
    setState(() {
      _isConnecting = true;
    });
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      _mockConnectingToBox();
    });
    setState(() {
      _isConnecting = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isConnecting
          ? CircularProgressIndicator()
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                UnlockButton(
                  text: "Washee 1",
                  available: true,
                ),
                UnlockButton(
                  text: "Washee 2",
                  available: true,
                ),
                UnlockButton(
                  text: "Tørre 1",
                  available: false,
                ),
              ],
            ),
    );
  }
}
