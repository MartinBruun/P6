

import 'package:washee/features/booking/domain/entities/booking_entity.dart';

import '../account/accounts.dart';
import '../location/first_machine.dart';
import '../location/first_service.dart';

BookingEntity firstBooking = BookingEntity(
  id: 1,
  machine: firstMachine,
  service: firstService,
  account: firstAccount,
);

BookingEntity secondBooking = BookingEntity(
  id: 2,
  machine: secondMachine,
  service: secondService,
  account: secondAccount,
);