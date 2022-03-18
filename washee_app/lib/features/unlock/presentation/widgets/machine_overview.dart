import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/global_provider.dart';
import '../../../../core/widgets/machine_card.dart';

class MachineOverview extends StatefulWidget {
  MachineOverview({Key? key}) : super(key: key);

  @override
  State<MachineOverview> createState() => _MachineOverviewState();
}

class _MachineOverviewState extends State<MachineOverview> {
  bool _isConnecting = false;

  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback((_) async {
      setState(() {
        _isConnecting = true;
      });
      await Future.delayed(Duration(seconds: 3));
      // Provider.of<GlobalProvider>(context, listen: false)
      //     .updateMachines(await sl<GetMachinesUseCase>().call(NoParams()));

      setState(() {
        _isConnecting = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isConnecting
          ? CircularProgressIndicator(
              color: Colors.white,
            )
          : Column(
              children: [
                SizedBox(
                  height: 300.h,
                ),
                Consumer<GlobalProvider>(
                  builder: (context, data, _) {
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.all(10.h),
                          child: MachineCard(
                            machine: data.machines[index],
                          ),
                        ),
                        itemCount: data.machines.length,
                      ),
                    );
                  },
                )
              ],
            ),
    );
  }
}
