

import 'package:washee/features/booking/domain/entities/booking_entity.dart';

import '../account/accounts.dart';
import '../location/first_machine.dart';
import '../location/first_service.dart';

BookingEntity firstBookingFixture = BookingEntity(
  id: 1,
  machine: firstMachineFixture(),
  service: firstServiceFixture(),
  account: firstAccountFixture(),
);

BookingEntity secondBookingFixture = BookingEntity(
  id: 2,
  machine: secondMachineFixture(),
  service: secondServiceFixture(),
  account: secondAccountFixture(),
);