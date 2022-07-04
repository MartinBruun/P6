import 'package:equatable/equatable.dart';
import 'package:washee/core/standards/base_usecase/usecase.dart';
import 'package:washee/features/booking/data/repositories/book_repository_impl.dart';

class DeleteBookingUseCase implements UseCase<bool, DeleteBookingParams> {
  final BookRepository repository;

  DeleteBookingUseCase({required this.repository});

  @override
  Future<bool> call(DeleteBookingParams params) async {
    return await repository.deleteBooking(
      bookingID: params.bookingID
    );
  }
}

class DeleteBookingParams extends Equatable {
  final int bookingID;

  DeleteBookingParams(
      {required this.bookingID});

  @override
  List<Object?> get props =>
      [bookingID];
}
