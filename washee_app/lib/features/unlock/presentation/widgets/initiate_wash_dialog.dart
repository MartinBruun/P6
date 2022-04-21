import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/washee_box/machine_model.dart';
import 'package:washee/features/unlock/presentation/provider/unlock_provider.dart';
import 'package:washee/features/unlock/presentation/widgets/no_button.dart';
import 'package:washee/features/unlock/presentation/widgets/wash_started_dialog.dart';
import 'package:washee/features/unlock/presentation/widgets/yes_button.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/http_error_prompt.dart';
import '../../../../core/pages/home_screen.dart';
import '../../../../core/pages/pages_enum.dart';
import '../../../../core/presentation/themes/colors.dart';
import '../../../../core/presentation/themes/dimens.dart';
import '../../../../core/presentation/themes/themes.dart';
import '../../../../core/providers/global_provider.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/widgets/common_used_widgets.dart';
import '../../../../injection_container.dart';
import '../../domain/usecases/connect_box_wifi.dart';
import '../../domain/usecases/disconnect_box_wifi.dart';
import '../../domain/usecases/unlock.dart';

class InitiateWashDialog extends StatefulWidget {
  final MachineModel machine;
  InitiateWashDialog({required this.machine});

  @override
  State<InitiateWashDialog> createState() => _InitiateWashDialogState();
}

class _InitiateWashDialogState extends State<InitiateWashDialog> {
  late MachineModel? fetchedMachine;
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  String _displayName() {
    if (widget.machine.name.toLowerCase() == "Vaskemaskine".toLowerCase() ||
        widget.machine.name.toLowerCase() == "Vaskemaskinen".toLowerCase()) {
      return "vask";
    }
    return "tørring";
  }

  @override
  Widget build(BuildContext context) {
    var unlock = Provider.of<UnlockProvider>(context, listen: true);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      body: Center(
          child:
              // WashDialogBox(
              //   machine: widget.machine,
              // ),
              Container(
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
            unlock.isUnlocking
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Låser op...",
                            style: textStyle.copyWith(
                                fontSize: textSize_28, color: Colors.white),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.h),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // YesButton(
                      //   machine: widget.machine,
                      // ),
                      Padding(
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
                            unlock.startUnlocking();
                            await _unlockMachine(context);
                          },
                        ),
                      ),
                      NoButton(),
                    ],
                  ),
          ],
        ),
      )),
    );
  }

  Future<void> _unlockMachine(BuildContext context) async {
    var global = Provider.of<GlobalProvider>(context, listen: false);
    var unlock = Provider.of<UnlockProvider>(context, listen: false);

    // unlock.stopUnlocking();
    try {
      var result = await sl<ConnectBoxWifiUsecase>().call(NoParams());
      // kDebugMode
      //     ? true
      //  // await sl<ConnectBoxWifiUsecase>().call(NoParams());
      print("Result er: " + result.toString());
      if (result) {
        fetchedMachine = await sl<UnlockUseCase>()
            .call(UnlockParams(machine: widget.machine));
        if (fetchedMachine == null) {
          print("Fetched Machine er null: " + fetchedMachine.toString());
          unlock.stopUnlocking();
          await ErrorHandler.errorHandlerView(
              context: context,
              prompt: HTTPErrorPrompt(
                  message:
                      "Det lykkedes ikke at låse maskinen op. Du har muligvis ikke forbindelse til boksen"));
        } else {
          print("Fetched Machine er ikke-null: " + fetchedMachine.toString());
          print("From start_wash.dart: fetchedMachine went correctly!");
          unlock.stopUnlocking();
          print("Opdaterer maskinen");
          global.updateMachine(fetchedMachine!);

          Navigator.pushReplacement(
            _scaffoldKey.currentContext!,
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
        print("Result er false");
        unlock.stopUnlocking();
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
      unlock.stopUnlocking();
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
  }
}
