import 'package:flutter/material.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';

class BookingInfo extends StatelessWidget {
  final String bookingInfo;

  BookingInfo({
    required this.bookingInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            bookingInfo,
            style: textStyle.copyWith(
              fontSize: textSize_40,
              fontWeight: FontWeight.w500,
            ),
          ),
          Divider(
            color: Colors.white,
            thickness: 1.0,
          )
        ],
      ),
    );
  }
}
