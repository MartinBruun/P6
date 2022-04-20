import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/washee_box/machine_model.dart';
import 'package:washee/features/unlock/presentation/provider/unlock_provider.dart';
import 'package:washee/features/unlock/presentation/widgets/no_button.dart';
import 'package:washee/features/unlock/presentation/widgets/yes_button.dart';

import '../../../../core/presentation/themes/colors.dart';
import '../../../../core/presentation/themes/dimens.dart';
import '../../../../core/presentation/themes/themes.dart';
import '../../../../core/widgets/common_used_widgets.dart';

class InitiateWashDialog extends StatefulWidget {
  final MachineModel machine;
  InitiateWashDialog({required this.machine});

  @override
  State<InitiateWashDialog> createState() => _InitiateWashDialogState();
}

class _InitiateWashDialogState extends State<InitiateWashDialog> {
  late MachineModel? fetchedMachine;

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
    var unlock = Provider.of<UnlockProvider>(context, listen: true);
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
          unlock.isUnlocking
              ? Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Låser op...",
                          style: textStyle.copyWith(
                              fontSize: textSize_20, color: Colors.white),
                        ),
                        CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ],
                    )
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    YesButton(
                      machine: widget.machine,
                    ),
                    NoButton(),
                  ],
                ),
        ],
      ),
    );
  }
}
