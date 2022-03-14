import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:washee/core/usecases/usecase.dart';
import 'package:washee/core/washee_box/machine_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/features/get_machines/domain/usecases/get_machines.dart';
import 'package:washee/injection_container.dart';
import '../../../../core/widgets/unlock_button.dart';

class MachineOverview extends StatefulWidget {
  MachineOverview({Key? key}) : super(key: key);

  @override
  State<MachineOverview> createState() => _MachineOverviewState();
}

class _MachineOverviewState extends State<MachineOverview> {
  List<MachineModel> machines = [];
  bool _isConnecting = false;

  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback((_) async {
      setState(() {
        _isConnecting = true;
      });
      machines = await sl<GetMachinesUseCase>().call(NoParams());
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
                  height: 500.h,
                ),
                Expanded(
                    child: ListView.builder(
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.all(20.h),
                    child: UnlockButton(
                      machine: machines[index],
                    ),
                  ),
                  itemCount: machines.length,
                ))
              ],
            ),
    );
  }
}
