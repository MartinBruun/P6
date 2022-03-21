import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' as rootBundle;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/global_provider.dart';
import '../../../../core/widgets/machine_card.dart';

class MachineOverview extends StatefulWidget {
  @override
  State<MachineOverview> createState() => _MachineOverviewState();
}

class _MachineOverviewState extends State<MachineOverview> {
  bool _isConnecting = false;

  Future<String> loadAsset() async {
    return await rootBundle.rootBundle
        .loadString("assets/data/machine_list.json");
  }

  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback((_) async {
      setState(() {
        _isConnecting = true;
      });
      await Future.delayed(Duration(seconds: 3));
      var provider = Provider.of<GlobalProvider>(context, listen: false);
      if (!provider.fetchedMachines) {
        var string = await loadAsset();
        var stringAsJson = json.decode(string);
        provider.constructMachineList(stringAsJson);
        //This is the usecase to be called on every initstate fetching from backend
        // await sl<GetMachinesUseCase>().call(NoParams()));
        provider.fetchedMachines = true;
      }

      // should be provider
      setState(() {
        _isConnecting = false;
      });
    });

    super.initState();
  }

  // Might need to be a futurebuilder
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
