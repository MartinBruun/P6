// import 'dart:convert';

import 'package:flutter/services.dart' as rootBundle;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/washee_box/machine_model.dart';
import 'package:washee/injection_container.dart';

import '../../../../core/providers/global_provider.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/widgets/machine_card.dart';
import '../../../../injection_container.dart';
import '../../domain/usecases/get_machines.dart';
import 'refresh_machines.dart';

class MachineOverview extends StatefulWidget {
  @override
  State<MachineOverview> createState() => _MachineOverviewState();
}

class _MachineOverviewState extends State<MachineOverview> {
  // Future<String> loadAsset() async {
  //   return await rootBundle.rootBundle
  //       .loadString("assets/data/machine_list.json");
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
      builder: (context, value, _) => FutureBuilder(
          future: sl<GetMachinesUseCase>().call(NoParams()),
          builder: ((context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasData) {
                  value.updateMachines(snapshot.data as List<MachineModel>);
                  return Column(
                    children: [
                      RefreshMachines(),
                      SizedBox(
                        height: 50.h,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.all(10.h),
                            child: MachineCard(
                              machine: value.machines[index],
                            ),
                          ),
                          itemCount: value.machines.length,
                        ),
                      ),
                    ],
                  );
                }
                return Center(
                  child: Text("Der kunne ikke hentes nogen maskiner!"),
                );
              case ConnectionState.active:
                return const Text("Active");
              case ConnectionState.none:
                return Center(
                  child: Text("Der kunne ikke hentes nogen maskiner!"),
                );
            }
          })),
    );
  }
}
