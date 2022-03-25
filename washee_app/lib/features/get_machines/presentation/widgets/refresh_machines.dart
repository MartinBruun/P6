import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/helpers/box_communicator.dart';

import '../../../../core/presentation/themes/dimens.dart';
import '../../../../core/presentation/themes/themes.dart';
import '../../../../core/providers/global_provider.dart';

class RefreshMachines extends StatefulWidget {
  @override
  State<RefreshMachines> createState() => _RefreshMachinesState();
}

class _RefreshMachinesState extends State<RefreshMachines> {
  bool _itWorked = false;
  bool _fetching = false;
  Dio dio = new Dio();
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
              _fetching
                  ? "Vi fetcher..."
                  : _itWorked
                      ? "Det virkede!"
                      : "Refresh maskiner",
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
                // global.isRefreshing = true;
                // global.updateMachines(
                //     await sl<GetMachinesUseCase>().call(NoParams()));
                var communicator = BoxCommunicatorImpl(dio: dio);
                setState(() {
                  _fetching = true;
                });
                var status = await communicator.dummyFetching();

                if (status != null) {
                  setState(() {
                    _fetching = false;
                    _itWorked = true;
                  });
                }
                // global.fetchedMachines = true;
                // global.isRefreshing = false;
              }),
        ],
      ),
    );
  }
}
