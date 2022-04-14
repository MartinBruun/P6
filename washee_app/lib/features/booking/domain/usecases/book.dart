import 'package:washee/core/usecases/usecase.dart';

import 'package:washee/features/booking/data/models/booking_model.dart';
import '../repositories/book_repository.dart';

class BookUseCase implements UseCase<BookingModel, NoParams> {
  final BookRepository repository;

  BookUseCase({required this.repository});

  @override
  Future<BookingModel> call(NoParams params) async {
    return await repository.postBooking();
  }
}
