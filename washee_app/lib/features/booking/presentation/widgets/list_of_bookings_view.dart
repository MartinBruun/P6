import 'package:flutter/material.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';
import 'package:washee/features/user_info/presentation/widgets/booking_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/booking_model.dart';

class ListOfBookingsView extends StatelessWidget {
  final List<BookingModel> bookings;

  ListOfBookingsView({required this.bookings});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => Row(
        children: [
          BookingInfo(
            bookingInfo: bookings[index].startTime.toString(),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: ElevatedButton(
              onPressed: null,
              child: Text(
                "slet",
                style: textStyle.copyWith(
                    fontSize: textSize_20, color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
            ),
          )
        ],
      ),
      itemCount: bookings.length,
    );
  }
}
