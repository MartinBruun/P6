import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/presentation/themes/dimens.dart';
import '../../../../core/presentation/themes/themes.dart';
import '../provider/calendar_provider.dart';

class CalendarView extends StatelessWidget {
  CalendarView({
    required this.date,
  }) : super();

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarProvider>(
      builder: (context, data, _) => Padding(
        padding: EdgeInsets.only(
          top: 30.h,
        ),
        child: Column(
          children: [
            Text(
              data.dateHelper.monthName(date.month),
              style: textStyle.copyWith(
                fontSize: textSize_32,
                color: Colors.white,
              ),
            ),
            Container(
              height: 800.h,
              child: GridView.builder(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.only(top: 10.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7),
                itemBuilder: (context, index) => Container(
                  width: 100.w,
                  height: 100.h,
                  child: Center(child: Text("${data.numberOfFields[index]}")),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(
                      20.h,
                    ),
                    border: Border.all(color: Colors.white, width: 2.h),
                  ),
                ),
                itemCount: data.dateHelper.getDaysInMonth(date) == 31
                    ? data.numberOfFields.length
                    : data.numberOfFields.length - 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
