import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/helpers/date_helper.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';
import 'package:washee/core/usecases/usecase.dart';
import 'package:washee/features/booking/domain/usecases/delete_booking.dart';
import 'package:washee/features/booking/presentation/provider/booking_provider.dart';
import 'package:washee/features/sign_in/domain/usecases/update_account.dart';
import 'package:washee/features/user_info/presentation/widgets/booking_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/injection_container.dart';
import '../../data/models/booking_model.dart';

class ListOfBookingsView extends StatelessWidget {
  final List<BookingModel> bookings;

  ListOfBookingsView({required this.bookings});
  var currentTime = DateHelper().currentTime();
  bool _validateShowBooking(BookingModel bookingToShow, DateTime current) {
    if (bookingToShow.endTime!.day == current.day) {
      if (bookingToShow.endTime!.hour > current.hour) {
        return true;
      }
      return false;
    } else if (bookingToShow.endTime!.day > current.day) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _validateShowBooking(bookings[index], currentTime)
            ? Row(
                children: [
                  BookingInfo(
                      bookingInfo: (bookings[index]
                                  .machineResource
                                  .contains("/api/1/machines/1/")
                              ? "Vask"
                              : "Tørring") +
                          " " +
                          bookings[index].startTime!.year.toString() +
                          "/" +
                          bookings[index].startTime!.month.toString() +
                          "/" +
                          bookings[index].startTime!.day.toString() +
                          " " +
                          bookings[index]
                              .startTime!
                              .hour
                              .toString()
                              .padLeft(2, "0") +
                          ":" +
                          bookings[index]
                              .startTime!
                              .minute
                              .toString()
                              .padLeft(2, "0") +
                          "-" +
                          bookings[index]
                              .endTime!
                              .hour
                              .toString()
                              .padLeft(2, "0") +
                          ":" +
                          bookings[index]
                              .endTime!
                              .minute
                              .toString()
                              .padLeft(2, "0")),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: ElevatedButton(
                      onPressed: () async {
                        await sl<DeleteBookingUseCase>().call(
                            DeleteBookingParams(
                                bookingID: bookings[index].bookingID!));
                        await sl<UpdateAccountUseCase>().call(NoParams());

                        var booking = Provider.of<BookingProvider>(context,
                            listen: false);

                        booking.refreshBookings();
                      },
                      child: Text(
                        "slet",
                        style: textStyle.copyWith(
                            fontSize: textSize_20, color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red)),
                    ),
                  )
                ],
              )
            : SizedBox.shrink();
      },
      itemCount: bookings.length,
    );
  }
}
