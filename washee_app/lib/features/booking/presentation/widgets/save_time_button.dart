import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/account/user.dart';
import 'package:washee/core/errors/booking_error_prompt.dart';
import 'package:washee/core/errors/error_handler.dart';
import 'package:washee/core/helpers/web_communicator.dart';
import 'package:washee/core/usecases/usecase.dart';
import 'package:washee/features/booking/presentation/provider/calendar_provider.dart';
import 'package:washee/features/booking/presentation/widgets/booking_success_dialog.dart';
import 'package:washee/features/sign_in/domain/usecases/update_account.dart';
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
  Future _simulateDelay() async {
    Future.delayed(Duration(seconds: 2));
  }

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
            calendar.sortAddedTimeSlots();
            if (calendar.addedTimeSlots.isNotEmpty) {
              var valid = calendar.isBookedTimeValid();

              if (valid) {
                setState(() {
                  _isBookingTimeSlot = true;
                });
                ActiveUser user = ActiveUser();
                String machineResource = sl<WebCommunicator>().machinesURL+"/${widget.machineType.toString()}/";
                String serviceResource = sl<WebCommunicator>().servicesURL+"/${widget.machineType.toString()}/";
                String accountResource = sl<WebCommunicator>().accountsURL+"/${user.activeAccount!.id.toString()}/";
                if (kDebugMode){
                  machineResource = "http://localhost:8000/api/1/machines/${widget.machineType.toString()}/";
                  serviceResource = "http://localhost:8000/api/1/services/${widget.machineType.toString()}/";
                  accountResource = "http://localhost:8000/api/1/accounts/${user.activeAccount!.id.toString()}/";
                }
                
                var result = await sl<PostBookingUsecase>().call(PostBookingParams(
                    startTime: calendar.getLeastTimeSlot()!,
                    machineResource: machineResource,
                    serviceResource: serviceResource,
                    accountResource: accountResource));
                await sl<UpdateAccountUseCase>().call(NoParams());
                await _simulateDelay();
                if (result != null) {
                  calendar.clearTimeSlots();

                  setState(() {
                    _isBookingTimeSlot = false;
                  });

                  Navigator.of(context).popUntil((route) => route.isFirst);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return BookingSuccessDialog();
                      });
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
                ErrorHandler.errorHandlerView(
                    context: context,
                    prompt: BookingErrorPrompt(
                        message:
                            "Ugyldig booking! Enten har du ikke valgt 2.5 time eller også er tiderne ikke sammenhængende"));
              }
            } else {
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
