import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/features/account/data/repositories/user_repository.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';
import 'package:washee/features/account/domain/usecases/sign_out.dart';

import '../../../../fixtures/entities/account/users.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group("SignOutUsecase base (requirements)",() {
    test(
      """
        Should sign the user out and set the user as an logged out anonymous user
      """,
      () async {
        // arrange
        UserEntity userLoggingOut = firstUserFixture();
        userLoggingOut.loggedIn = true;
        UserRepository mockRepo = MockUserRepository();
         when(
          () => mockRepo.signOut(userLoggingOut))
          .thenAnswer((_) async => userLoggingOut);
        SignOutUsecase testUsecase = SignOutUsecase(userRepository: mockRepo);

        // act
        UserEntity actualUser = await testUsecase.call(SignOutParams(userLoggingOut: userLoggingOut));

        // assert
        expect(actualUser.loggedIn, false);
    },
    tags: ["unittest","account","usecases"]);
  });
}