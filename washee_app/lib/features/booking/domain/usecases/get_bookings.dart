import 'package:equatable/equatable.dart';
import 'package:washee/core/usecases/usecase.dart';

import '../../data/models/booking_model.dart';
import '../repositories/book_repository.dart';

class GetBookingsUseCase implements UseCase<List<BookingModel>, GetBookingsParams> {
  final BookRepository repository;

  GetBookingsUseCase({required this.repository});

  @override
  Future<List<BookingModel>> call(GetBookingsParams params) async {
    return await repository.getBookings(accountID: params.accountID, activated: params.activated);
  }
}

class GetBookingsParams extends Equatable {
  final int? accountID;
  final bool? activated;

  GetBookingsParams(
      {this.accountID, this.activated});

  @override
  List<Object?> get props =>
      [accountID, activated];
}
