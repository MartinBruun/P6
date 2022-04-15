// import 'dart:convert';

import 'package:flutter/services.dart' as rootBundle;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/global_provider.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/widgets/machine_card.dart';
import '../../../../injection_container.dart';
import '../../../booking/data/models/booking_model.dart';
import '../../domain/usecases/get_machines.dart';
import 'refresh_machines.dart';

class MachineOverview extends StatefulWidget {
  @override
  State<MachineOverview> createState() => _MachineOverviewState();
}

class _MachineOverviewState extends State<MachineOverview> {
  Future<String> loadAsset() async {
    return await rootBundle.rootBundle
        .loadString("assets/data/machine_list.json");
  }

  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback((_) async {
      var provider = Provider.of<GlobalProvider>(context, listen: false);
      provider.isConnectingToBox = true;
      await Future.delayed(Duration(seconds: 1));
      
        // var string = await loadAsset();
        // var stringAsJson = json.decode(string);
        // provider.constructMachineList(stringAsJson);
        //This is the usecase to be called on every initstate fetching from backend
        provider
            .updateMachines(await sl<GetMachinesUseCase>().call(NoParams()));
        provider.fetchedMachines = true;
      

      provider.isConnectingToBox = false;
    });

    super.initState();
  }

  // Might need to be a futurebuilder
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
      builder: (context, data, _) {
        return Center(
          child: data.isConnectingToBox || data.isRefreshing
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Column(
                  children: [
                    RefreshMachines(),
                    SizedBox(
                      height: 100.h,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.all(10.h),
                          child: MachineCard(
                            machine: data.machines[index],
                          ),
                        ),
                        itemCount: data.machines.length,
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
