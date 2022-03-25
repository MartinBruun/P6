import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/presentation/themes/dimens.dart';
import '../../../../core/presentation/themes/themes.dart';
import '../../../../core/providers/global_provider.dart';

class RefreshMachines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 100.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Text(
              "Refresh maskiner",
              style: textStyle.copyWith(
                fontSize: textSize_36,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          IconButton(
              padding: EdgeInsets.only(right: 75.w, bottom: 45.h),
              icon: Icon(
                Icons.refresh,
                color: Colors.blue,
                size: iconSize_76,
              ),
              onPressed: () async {
                var global =
                    Provider.of<GlobalProvider>(context, listen: false);
                global.isRefreshing = true;
                // global.updateMachines(
                //     await sl<GetMachinesUseCase>().call(NoParams()));
                await Future.delayed(Duration(seconds: 3));
                global.fetchedMachines = true;
                global.isRefreshing = false;
              }),
        ],
      ),
    );
  }
}
