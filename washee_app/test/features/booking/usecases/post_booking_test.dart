import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:washee/core/account/account.dart';
import 'package:washee/core/account/user.dart';
import 'package:washee/features/booking/data/models/booking_entity.dart';
import 'package:washee/features/booking/domain/usecases/post_booking.dart';
import 'package:washee/injection_container.dart';

// List<DateTime> mockTimeSlots = [
//   DateTime(2022, 01, 01, 2, 0),
//   DateTime(2022, 01, 01, 2, 30),
//   DateTime(2022, 01, 01, 3, 0),
//   DateTime(2022, 01, 01, 3, 30),
//   DateTime(2022, 01, 01, 4, 0),
//   DateTime(2022, 01, 01, 4, 30),
// ];

// DateTime? getLeastTimeSlot() {
//   return mockTimeSlots
//       .reduce((current, next) => current.compareTo(next) > 0 ? next : current);
// }

// ActiveUser user = ActiveUser();
// String machineResource = sl<WebCommunicator>().machinesURL+"/${widget.machineType.toString()}/";
// String serviceResource = sl<WebCommunicator>().servicesURL+"/${widget.machineType.toString()}/";
// String accountResource = sl<WebCommunicator>().accountsURL+"/${user.activeAccount!.id.toString()}/";
// if (kDebugMode){
//   machineResource = "http://localhost:8000/api/1/machines/${widget.machineType.toString()}/";
//   serviceResource = "http://localhost:8000/api/1/services/${widget.machineType.toString()}/";
//   accountResource = "http://localhost:8000/api/1/accounts/${user.activeAccount!.id.toString()}/";
// }

// var result = await sl<PostBookingUsecase>().call(PostBookingParams(
//                     startTime: calendar.getLeastTimeSlot()!,
//                     machineResource: machineResource,
//                     serviceResource: serviceResource,
//                     accountResource: accountResource));
//                 await sl<UpdateAccountUseCase>().call(NoParams());
//                 await _simulateDelay();
//                 if (result != null) {
//                   calendar.clearTimeSlots();

void main() {

  // late 
  test(
    'should post a valid booking to dio endpoint',
    () async {
      // arrange
      // create a user
      var user = ActiveUser();
      user.initUser(1, "test@test.test", "test", [
        {'account_id': 1, 'name': "test_account", 'balance': 20.0}
      ]);
      // create a booking
      // booking = Booking()
      var booking1_start_time = DateTime(2022, 01, 01, 2, 0);
      var booking = Booking(
          bookingID: 12,
          startTime: booking1_start_time,
          machineResource: "https://mocked_machineResource/1",
          serviceResource: "https://mocked_serviceResource/1",
          accountResource: "https://mocked_accountResource/1");
      
      // // act
      // post booking
      final result = await sl<PostBookingUsecase>().call(PostBookingParams(
                    startTime: booking.startTime!,
                    machineResource: booking.machineResource,
                    serviceResource: booking.serviceResource,
                    accountResource: booking.accountResource));

      // // assert
      //assert that the booking is posted to dio correct endpoint, with token
      expect(result, "risengrød");
    },
  );
}
