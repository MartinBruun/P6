import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/account/user.dart';
import 'package:washee/features/booking/presentation/provider/booking_provider.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../injection_container.dart';
import '../../data/models/booking_model.dart';
import '../../domain/usecases/get_bookings.dart';
import 'list_of_bookings_view.dart';

class MyAccountBookingList extends StatefulWidget {
  @override
  State<MyAccountBookingList> createState() => _MyAccountBookingListState();
}

class _MyAccountBookingListState extends State<MyAccountBookingList> {
  bool _startList = false;
  ActiveUser user = ActiveUser();

  @override
  void initState() {
    super.initState();
    setState(() {
      _startList = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var booking = Provider.of<BookingProvider>(context, listen: true);
    return _startList || booking.isRefreshing
        ? FutureBuilder(
            future: sl<GetBookingsUseCase>().call(GetBookingsParams(accountID: user.activeAccount!.id, activated:false)),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                  return const Text("Aktiv");

                case ConnectionState.none:
                  return const Text("Ingen forbindelse til server");

                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );

                case ConnectionState.done:
                  booking.stopRefreshBookings();
                  if (snapshot.hasData) {
                    var result = snapshot.data as List<BookingModel>;
                    if (result.isNotEmpty) {
                      return ListOfBookingsView(bookings: result);
                    }
                  }

                  return const Text("Du har ingen bookede tider");

                default:
                  booking.stopRefreshBookings();
                  return const Text(
                      "Kunne ikke hente bookede tider fra serveren");
              }
            })
        : SizedBox.shrink();
  }
}
