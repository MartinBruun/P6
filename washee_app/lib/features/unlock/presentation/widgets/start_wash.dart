import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
import 'package:washee/core/pages/home_screen.dart';
// import 'package:washee/core/providers/global_provider.dart';
import 'package:washee/core/washee_box/machine_model.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/http_error_prompt.dart';
import '../../../../core/presentation/themes/colors.dart';
import '../../../../core/presentation/themes/dimens.dart';
import '../../../../core/presentation/themes/themes.dart';
import '../../../../injection_container.dart';
import '../../domain/usecases/unlock.dart';

// ignore: must_be_immutable
class StartWash extends StatelessWidget {
  final MachineModel currentMachine;

  StartWash({required this.currentMachine});

  late MachineModel? fetchedMachine;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.dialogLightGray,
        borderRadius: BorderRadius.circular(30.h),
      ),
      height: 586.h,
      width: 754.w,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 90.h),
            child: Icon(
              Icons.check_circle,
              color: AppColors.main,
              size: 200.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 45.h, bottom: 24.h, left: 10.w, right: 10.w),
            child: Container(
              width: 760.w,
              height: 100.h,
              child: Text(
                "Din maskine er nu låst op!",
                style: textStyle.copyWith(
                  fontSize: textSize_40,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Container(
                  height: 84.h,
                  width: 254.w,
                  decoration: BoxDecoration(
                    color: AppColors.deepGreen,
                    borderRadius: BorderRadius.circular(20.h),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () async {
                        try {
                          fetchedMachine = await sl<UnlockUseCase>().call(
                              UnlockParams(
                                  machine: currentMachine,
                                  duration: Duration(hours: 2, minutes: 30)));
                          if (fetchedMachine == null) {
                            ErrorHandler.errorHandlerView(
                                context: context,
                                prompt: HTTPErrorPrompt(
                                    message:
                                        "Det ser ud til, at du ikke har forbindelse til WasheeBox"));
                          }
                        } catch (e) {
                          print(e.toString());
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return HTTPErrorPrompt(
                                  message:
                                      "Noget gik galt da vi forsøgte at låse maskinen op! Prøv venligst igen");
                            },
                          );
                        }
                        // var provider =
                        //     Provider.of<GlobalProvider>(context, listen: false);
                        // var machineToStart = provider.machines.where(
                        //     (element) =>
                        //         element.name.toLowerCase() ==
                        //         fetchedMachine!.name.toLowerCase());
                        // provider.machines.removeWhere((element) =>
                        //     element.name.toLowerCase() ==
                        //     fetchedMachine!.name.toLowerCase());
                        // machineToStart.startTime = DateTime.now();
                        // machineToStart.endTime = machineToStart.startTime!
                        //     .add(Duration(hours: 7, minutes: 30));
                        // provider.machines.add(machineToStart);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                      child: Text(
                        'Start',
                        style: textStyle.copyWith(
                          fontSize: textSize_32,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
