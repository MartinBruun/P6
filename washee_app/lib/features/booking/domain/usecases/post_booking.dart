import 'package:equatable/equatable.dart';
import 'package:washee/core/usecases/usecase.dart';

import 'package:washee/features/booking/data/models/booking_model.dart';
import '../repositories/book_repository.dart';

class PostBookingUsecase implements UseCase<BookingModel?, PostBookingParams> {
  final BookRepository repository;

  PostBookingUsecase({required this.repository});

  @override
  Future<BookingModel?> call(PostBookingParams params) async {
    return await repository.postBooking(
        startTime: params.startTime,
        machineResource: params.machineResource,
        serviceResource: params.serviceResource,
        accountResource: params.accountResource);
  }
}

class PostBookingParams extends Equatable {
  final DateTime startTime;
  final String machineResource;
  final String serviceResource;
  final String accountResource;

  PostBookingParams(
      {required this.startTime,
      required this.machineResource,
      required this.serviceResource,
      required this.accountResource});

  @override
  List<Object?> get props =>
      [startTime, machineResource, serviceResource, accountResource];
}
