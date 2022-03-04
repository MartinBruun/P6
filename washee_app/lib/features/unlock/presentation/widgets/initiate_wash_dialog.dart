import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/usecases/usecase.dart';
import 'package:washee/features/unlock/domain/usecases/unlock.dart';
import 'package:washee/features/unlock/presentation/provider/unlock_provider.dart';

import '../../../../core/presentation/themes/colors.dart';
import '../../../../core/presentation/themes/dimens.dart';
import '../../../../core/presentation/themes/themes.dart';
import '../../../../core/widgets/common_used_widgets.dart';
import '../../../../injection_container.dart';

class InitiateWashDialog extends StatefulWidget {
  InitiateWashDialog({Key? key}) : super(key: key);

  @override
  State<InitiateWashDialog> createState() => _InitiateWashDialogState();
}

class _InitiateWashDialogState extends State<InitiateWashDialog> {
  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback(
      (_) async {
        var unlockProvider =
            Provider.of<UnlockProvider>(context, listen: false);
        unlockProvider.isUnlocking = true;
        var status = await sl<UnlockUseCase>().call(NoParams());
        if (status) {
          unlockProvider.isUnlocking = false;
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var unlockProvider = Provider.of<UnlockProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: unlockProvider.isUnlocking
            ? CircularProgressIndicator()
            : Container(
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
                      padding: EdgeInsets.only(top: 45.h, bottom: 24.h),
                      child: Container(
                        width: 600.w,
                        height: 110.h,
                        child: Text(
                          "Welcome to Washee",
                          style: textStyle.copyWith(
                            fontSize: textSize_40,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
