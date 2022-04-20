import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/errors/error_handler.dart';
import 'package:washee/core/errors/http_error_prompt.dart';
import 'package:washee/core/pages/home_screen.dart';
import 'package:washee/core/pages/pages_enum.dart';
import 'package:washee/core/presentation/themes/colors.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';
import 'package:washee/core/providers/global_provider.dart';
import 'package:washee/core/usecases/usecase.dart';
import 'package:washee/core/washee_box/machine_model.dart';
import 'package:washee/features/unlock/domain/usecases/connect_box_wifi.dart';
import 'package:washee/features/unlock/domain/usecases/disconnect_box_wifi.dart';
import 'package:washee/features/unlock/domain/usecases/unlock.dart';
import 'package:washee/features/unlock/presentation/provider/unlock_provider.dart';
import 'package:washee/features/unlock/presentation/widgets/wash_started_dialog.dart';
import 'package:washee/injection_container.dart';

// ignore: must_be_immutable
class YesButton extends StatefulWidget {
  YesButton({required this.machine});

  MachineModel machine;

  @override
  State<YesButton> createState() => _YesButtonState();
}

class _YesButtonState extends State<YesButton> {
  late MachineModel? fetchedMachine;

  @override
  Widget build(BuildContext context) {
    var unlockProvider = Provider.of<UnlockProvider>(context, listen: true);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: unlockProvider.isUnlocking
          ? ElevatedButton(
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
              },
            )
          : Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
    );
  }

  Future<void> _unlockMachine(BuildContext context) async {
    var unlockProvider = Provider.of<UnlockProvider>(context, listen: false);
    var global = Provider.of<GlobalProvider>(context, listen: false);

    unlockProvider.isUnlocking = true;

    try {
      var result = await sl<ConnectBoxWifiUsecase>().call(NoParams());

      if (result) {
        fetchedMachine = await sl<UnlockUseCase>()
            .call(UnlockParams(machine: this.widget.machine));
        if (fetchedMachine == null) {
          unlockProvider.isUnlocking = false;
          ErrorHandler.errorHandlerView(
              context: context,
              prompt: HTTPErrorPrompt(
                  message:
                      "Det ser ud til, at du ikke har forbindelse til WasheeBox"));
        } else {
          print("From start_wash.dart: fetchedMachine went correctly!");
          unlockProvider.isUnlocking = false;

          global.updateMachine(fetchedMachine!);

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
      unlockProvider.isUnlocking = false;
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
    unlockProvider.isUnlocking = false;
  }
}
