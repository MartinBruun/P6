import 'package:washee/features/booking/data/models/booking_model.dart';
import 'package:washee/core/account/account.dart';

/*
  This contains the fixtures for all the models in the washee_app application.

  All models are related in a similar fashion. The first booking contains the first machine and the first service,
  etc. whereas the second booking contains the second machine etc.

  Tests are made to make sure each model has some functioning default values, but it is up to each test
  to overwrite the different values of the models before acting upon them as necessitated by each test.
*/

Account firstAccount = Account(

);

BookingModel firstBooking = BookingModel(
  startTime: startTime, 
  machineResource: machineResource, 
  serviceResource: serviceResource, 
  accountResource: accountResource
);