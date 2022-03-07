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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var unlockProvider = Provider.of<UnlockProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
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
                    top: 45.h, bottom: 24.h, left: 10.w, right: 10.w),
                child: Container(
                  width: 760.w,
                  height: 200.h,
                  child: Text(
                    "Vil du låse maskinen op? Det vil koste dig ét klip",
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
                        color: Colors.green[600],
                        borderRadius: BorderRadius.circular(20.h),
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () async {
                            var status =
                                await sl<UnlockUseCase>().call(NoParams());
                          },
                          child: Text(
                            'Ja',
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Container(
                      height: 84.h,
                      width: 254.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.h),
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () async {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Nej',
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
        ),
      ),
    );
  }
}
