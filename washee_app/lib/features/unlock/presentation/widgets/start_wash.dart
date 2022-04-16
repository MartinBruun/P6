import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/pages/home_screen.dart';
import 'package:washee/core/washee_box/machine_model.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/http_error_prompt.dart';
import '../../../../core/presentation/themes/colors.dart';
import '../../../../core/presentation/themes/dimens.dart';
import '../../../../core/presentation/themes/themes.dart';
import '../../../../injection_container.dart';
import '../../domain/usecases/unlock.dart';

// ignore: must_be_immutable
class StartWash extends StatefulWidget {
  final MachineModel currentMachine;

  StartWash({required this.currentMachine});

  @override
  State<StartWash> createState() => _StartWashState();
}

class _StartWashState extends State<StartWash> {
  late MachineModel? fetchedMachine;

  bool _isUnlockingMachine = false;

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
                child: Center(
                  child: _startButton(context) 

                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _startButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await _pressed(context);
      },
      child: _isUnlockingMachine
      ? CircularProgressIndicator(
        color: Colors.black,
      )
      : Text(
        'Start',
        style: textStyle.copyWith(
          fontSize: textSize_32,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(254.w, 84.h),
        primary: AppColors.deepGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.h)
        )
      ),
    );
  }

  Future<void> _pressed(BuildContext context) async {
    setState(() {
      _isUnlockingMachine = true;
    });
    try {
        fetchedMachine = await sl<UnlockUseCase>().call(
          UnlockParams(
              machine: widget.currentMachine,
              duration: Duration(seconds: 10)));
        if (fetchedMachine == null) {
          setState(() {
            _isUnlockingMachine = false;
          });
          ErrorHandler.errorHandlerView(
            context: context,
            prompt: HTTPErrorPrompt(
                message:
                    "Det ser ud til, at du ikke har forbindelse til WasheeBox"));
        }
        else{
          print("From start_wash.dart: fetchedMachine went correctly!");
        }
    } catch (e) {
      setState(() {
        _isUnlockingMachine = false;
      });
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
    setState(() {
      _isUnlockingMachine = false;
    });
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
  }
}
