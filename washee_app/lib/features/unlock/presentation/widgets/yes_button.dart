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
    var unlock = Provider.of<UnlockProvider>(context, listen: false);
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
          unlock.startUnlocking();
          await _unlockMachine(context);
        },
      ),
    );
  }

  Future<void> _unlockMachine(BuildContext context) async {
    var global = Provider.of<GlobalProvider>(context, listen: false);
    var unlock = Provider.of<UnlockProvider>(context, listen: false);
    // await Future.delayed(Duration(seconds: 5));
    // unlock.stopUnlocking();
    try {
      var result = kDebugMode
          ? true
          : await sl<ConnectBoxWifiUsecase>().call(NoParams());
      print("Result er: " + result.toString());
      if (result) {
        fetchedMachine = await sl<UnlockUseCase>()
            .call(UnlockParams(machine: this.widget.machine));

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
