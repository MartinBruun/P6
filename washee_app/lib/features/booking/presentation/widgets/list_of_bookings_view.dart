import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';
import 'package:washee/features/booking/domain/usecases/delete_booking.dart';
import 'package:washee/features/booking/presentation/provider/booking_provider.dart';
import 'package:washee/features/user_info/presentation/widgets/booking_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/injection_container.dart';
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
              onPressed: () async {
                await sl<DeleteBookingUseCase>().call(await DeleteBookingParams(
                    bookingID: bookings[index].bookingID!));

                var booking =
                    Provider.of<BookingProvider>(context, listen: false);

                booking.refreshBookings();
              },
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
