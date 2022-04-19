import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/errors/error_handler.dart';
import 'package:washee/core/errors/http_error_prompt.dart';
import 'package:washee/core/pages/home_screen.dart';
import 'package:washee/core/pages/pages_enum.dart';
import 'package:washee/core/usecases/usecase.dart';
import 'package:washee/core/washee_box/machine_model.dart';
import 'package:washee/core/widgets/dialog_box_Ok.dart';
import 'package:washee/features/sign_out/presentation/widgets/no_buttton.dart';
import 'package:washee/features/unlock/domain/usecases/connect_box_wifi.dart';
import 'package:washee/features/unlock/domain/usecases/disconnect_box_wifi.dart';
import 'package:washee/features/unlock/domain/usecases/unlock.dart';
import 'package:washee/features/unlock/presentation/widgets/wash_started_dialog.dart';
import 'package:washee/injection_container.dart';

import '../../../../core/presentation/themes/colors.dart';
import '../../../../core/presentation/themes/dimens.dart';
import '../../../../core/presentation/themes/themes.dart';
import '../../../../core/widgets/common_used_widgets.dart';

// ignore: must_be_immutable
class InitiateWashDialog extends StatefulWidget {
  MachineModel machine;
  InitiateWashDialog({required this.machine});

  @override
  State<InitiateWashDialog> createState() => _InitiateWashDialogState();
}

class _InitiateWashDialogState extends State<InitiateWashDialog> {
  late MachineModel? fetchedMachine;
  bool _isUnlockingMachine = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(child: _dialogBox(context)),
    );
  }

  String _displayName() {
    if (widget.machine.name.toLowerCase() == "Vaskemaskine".toLowerCase() ||
        widget.machine.name.toLowerCase() == "Vaskemaskinen".toLowerCase()) {
      return "vask";
    }
    return "tørring";
  }

  Widget _dialogBox(BuildContext context) {
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
            child: svgAsset('question_mark_icon.svg',
                size: iconSize_120, color: AppColors.lightGray),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 45.h, bottom: 14.h, left: 10.w, right: 10.w),
            child: Container(
              width: 760.w,
              height: 170.h,
              child: Text(
                "Vil du igangsætte din ${_displayName()}?",
                style: textStyle.copyWith(
                  fontSize: textSize_32,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _isUnlockingMachine
                  ? CircularProgressIndicator()
                  : _yesButton(context),
              NoButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _yesButton(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              fixedSize: Size(254.w, 84.h),
              primary: AppColors.deepGreen,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.h))),
          child: Text(
            'Ja',
            style: textStyle.copyWith(
              fontSize: textSize_32,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          onPressed: () async {
            _unlockMachine(context);

            // setState(() {
            //   _machineStarted = true;
            // });
          },
        ));
  }

  Future<void> _unlockMachine(BuildContext context) async {
    setState(() {
      _isUnlockingMachine = true;
    });
    try {
      var result = kDebugMode
          ? true
          : await sl<ConnectBoxWifiUsecase>().call(NoParams());

      if (result) {
        fetchedMachine = await sl<UnlockUseCase>()
            .call(UnlockParams(machine: widget.machine));
        await sl<DisconnectBoxWifiUsecase>().call(NoParams());
        if (fetchedMachine == null) {
          setState(() {
            _isUnlockingMachine = false;
          });
          ErrorHandler.errorHandlerView(
              context: context,
              prompt: HTTPErrorPrompt(
                  message:
                      "Det ser ud til, at du ikke har forbindelse til WasheeBox"));
        } else {
          print("From start_wash.dart: fetchedMachine went correctly!");
          await sl<DisconnectBoxWifiUsecase>().call(NoParams());
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                page: PageNumber.WashScreen,
              ),
            ),
          );
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return WashStartedDialog();
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return HTTPErrorPrompt(
                message:
                    "Det ser ud til, at du ikke har forbindelse til WasheeBox. Forbind til boxen og prøv igen!");
          },
        );
      }
    } catch (e) {
      await sl<DisconnectBoxWifiUsecase>().call(NoParams());
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
  }
}
