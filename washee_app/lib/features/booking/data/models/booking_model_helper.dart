import 'package:washee/core/helpers/date_helper.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';

class BookingModelHelper{

  Map<String, dynamic> toJson(BookingModel model) => {
        'id': model.bookingID,
        'start_time': model.startTime.toString(),
        'end_time': model.endTime.toString(),
        'created': model.created.toString(),
        'last_updated': model.lastUpdated.toString(),
        'activated': model.activated.toString(),
        'machine': model.machineResource,
        'service': model.serviceResource,
        'account': model.accountResource
      };

  BookingModel usingJson(Map<String, dynamic> json){
    var danishTime = DateHelper().getLocation('Europe/Copenhagen');
    BookingModel booking = BookingModel(
      startTime: DateHelper().from(DateTime.parse(json['start_time']), danishTime),
      endTime: DateHelper().from(DateTime.parse(json['end_time']), danishTime),
      lastUpdated: DateHelper().from(DateTime.parse(json['last_updated']), danishTime),
      activated: json["activated"],
      machineResource: json['machine'],
      serviceResource: json['service'],
      created: DateHelper().from(DateTime.parse(json['created']), danishTime),
      accountResource: json['account'],
      bookingID: int.parse(json['id'].toString()),
    );
    return booking;

  }
}