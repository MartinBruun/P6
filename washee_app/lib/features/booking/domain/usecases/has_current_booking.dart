import 'package:equatable/equatable.dart';
import 'package:washee/core/usecases/usecase.dart';

import '../repositories/book_repository.dart';

class HasCurrentBookingUseCase implements UseCase<bool, HasCurrentBookingParams> {
  final BookRepository repository;

  HasCurrentBookingUseCase({required this.repository});

  @override
  Future<bool> call(HasCurrentBookingParams params) async {
    return await repository.hasCurrentBooking(
      accountResource: params.accountResource,
      machineResource: params.machineResource
    );
  }
}

class HasCurrentBookingParams extends Equatable {
  final String accountResource;
  final String machineResource;

  HasCurrentBookingParams(
      {required this.accountResource, required this.machineResource});

  @override
  List<Object?> get props =>
      [accountResource, machineResource];
}
