import 'package:washee/core/usecases/usecase.dart';

import '../../data/models/booking_model.dart';
import '../repositories/book_repository.dart';

class GetBookingsUseCase implements UseCase<List<BookingModel>, NoParams> {
  final BookRepository repository;

  GetBookingsUseCase({required this.repository});

  @override
  Future<List<BookingModel>> call(NoParams params) async {
    return await repository.getBookings();
  }
}
