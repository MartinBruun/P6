import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';
import 'package:washee/core/providers/global_provider.dart';

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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: sl<GetBookingsUseCase>().call(NoParams()),
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
              if (snapshot.hasData) {
                var result = snapshot.data as List<BookingModel>;
                if (result.isNotEmpty) {
                  return ListOfBookingsView(bookings: result);
                }
              }
              return const Text("Du har ingen bookede tider");

            default:
              return const Text("Kunne ikke hente bookede tider fra serveren");
          }
        });
  }
}
