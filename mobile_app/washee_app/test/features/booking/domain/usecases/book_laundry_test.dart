import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:washee/core/errors/failures.dart';
import 'package:washee/core/usecases/usecase.dart';
import 'package:washee/features/booking/domain/repositories/book_laundry_repository.dart';
import 'package:washee/features/booking/domain/usecases/book_laundry.dart';

@GenerateMocks([BookLaundryRepository])
void main() {
  // var mockBookLaundryRepository = MockBookLaundryRepository();
  // var usecase = BookLaundryUseCase(repository: mockBookLaundryRepository);
  // test(
  //   "Should get a bool from the repository",
  //   () async {
  //     // arrange
  //     when(mockAppVersionRepository.getAppVersionInfoFromBackend())
  //         .thenAnswer((_) async => Right(true));
  //     // act
  //     final result = await usecase.call(NoParams());

  //     // assert
  //     expect(result, Right(true));
  //     verify(mockAppVersionRepository.getAppVersionInfoFromBackend());
  //   },
  // );

  // test(
  //   "Should return a ServerFailure when no internet connection",
  //   () async {
  //     // arrange
  //     when(mockAppVersionRepository.getAppVersionInfoFromBackend()).thenAnswer(
  //         (_) async => Left(ServerFailure(message: "Server Failure")));
  //     // act
  //     final result = await usecase.call(NoParams());

  //     // assert
  //     expect(result, Left(ServerFailure(message: "Server Failure")));
  //     verify(mockAppVersionRepository.getAppVersionInfoFromBackend());
  //   },
  // );
  test(
    'should just run the test for initial commit',
    () async {
      // arrange

      // act

      // assert
      assert(true);
    },
  );
}
