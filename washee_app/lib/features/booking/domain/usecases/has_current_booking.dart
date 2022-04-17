import 'package:equatable/equatable.dart';
import 'package:washee/core/usecases/usecase.dart';

import '../repositories/book_repository.dart';

class HasCurrentBookingUseCase implements UseCase<bool, HasCurrentBookingParams> {
  final BookRepository repository;

  HasCurrentBookingUseCase({required this.repository});

  @override
  Future<bool> call(HasCurrentBookingParams params) async {
    return await repository.hasCurrentBooking(
      accountID: params.accountID,
      machineID: params.machineID
    );
  }
}

class HasCurrentBookingParams extends Equatable {
  final int accountID;
  final int machineID;

  HasCurrentBookingParams(
      {required this.accountID, required this.machineID});

  @override
  List<Object?> get props =>
      [accountID, machineID];
}
