import 'package:flutter/material.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import '../../../../core/presentation/themes/themes.dart';
import '../../../user_info/presentation/widgets/user_text.dart';
import '../../data/models/booking_model.dart';

class ListOfBookingsView extends StatelessWidget {
  const ListOfBookingsView({Key? key, required this.bookings})
      : super(key: key);
  final List<BookingModel> bookings;

  @override
  Widget build(BuildContext context) {

    TextStyle smallText = textStyle.copyWith(
                  fontSize: textSize_40,
                  fontWeight: FontWeight.w600,
                  color: Colors.white);
                  
    return Container(
      child: Row(
        children: [
          UserText(bookings.toString(),smallText,8),
          ElevatedButton(
            onPressed: null,
            child: Text("delete"),
          )
        ],
      ),
    );
  }
}
