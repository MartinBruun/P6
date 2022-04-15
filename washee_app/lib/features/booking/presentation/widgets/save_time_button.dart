import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/errors/booking_error_prompt.dart';
import 'package:washee/core/errors/error_handler.dart';
import 'package:washee/features/booking/presentation/provider/calendar_provider.dart';
import 'package:washee/injection_container.dart';
import 'package:washee/features/booking/domain/usecases/post_booking.dart';

import '../../../../core/presentation/themes/colors.dart';
import '../../../../core/presentation/themes/dimens.dart';

class SaveTimeButton extends StatefulWidget {
  final int machineType;

  SaveTimeButton({required this.machineType});
  @override
  State<SaveTimeButton> createState() => _SaveTimeButtonState();
}

class _SaveTimeButtonState extends State<SaveTimeButton> {
  bool _isBookingTimeSlot = false;
  @override
  Widget build(BuildContext context) {
    var calendar = Provider.of<CalendarProvider>(context, listen: false);
    return Container(
      height: 84.h,
      width: 293.69.w,
      decoration: BoxDecoration(
        color: AppColors.main,
        borderRadius: BorderRadius.circular(20.w),
      ),
      child: Center(
        child: InkWell(
          onTap: () async {
            if (calendar.addedTimeSlots.isNotEmpty) {
              var valid = calendar.isBookedTimeValid();

              if (valid) {
                print("VALID BOOKING! Posting to the backend");
                setState(() {
                  _isBookingTimeSlot = true;
                });
                var result = await sl<PostBookingUsecase>().call(PostBookingParams(
                    startTime: calendar.getLeastTimeSlot()!,
                    machineResource:
                        "http://localhost:8000/api/1/machines/${widget.machineType}/",
                    serviceResource:
                        "http://locahost:8000/api/1/services/${widget.machineType}/",
                    accountResource:
                        "http://localhost:8000/api/1/accounts/1/"));
                await Future.delayed(Duration(seconds: 3));
                if (result != null) {
                  calendar.clearTimeSlots();

                  setState(() {
                    _isBookingTimeSlot = false;
                  });
                  Navigator.of(context).popUntil((route) => route.isFirst);
                } else {
                  setState(() {
                    _isBookingTimeSlot = false;
                  });
                  ErrorHandler.errorHandlerView(
                      context: context,
                      prompt: BookingErrorPrompt(
                          message:
                              "Ups! Det ser ud til, at du ikke har forbindelse til internettet"));
                }
              } else {
                // Show dialog to the user with propriate error message
                print("INVALID BOOKING! Aborting");
                ErrorHandler.errorHandlerView(
                    context: context,
                    prompt: BookingErrorPrompt(
                        message:
                            "Ugyldig booking! Enten har du ikke valgt 2.5 time eller også er tiderne ikke sammenhængende"));
              }
            } else {
              print("INVALID BOOKING! Aborting");
              ErrorHandler.errorHandlerView(
                  context: context,
                  prompt: BookingErrorPrompt(
                      message:
                          "Ugyldig booking! Du skal vælge 6 sammenhængende tidsrum"));
            }
          },
          child: _isBookingTimeSlot
              ? CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                )
              : Text(
                  'Book',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: textSize_32),
                ),
        ),
      ),
    );
  }
}
