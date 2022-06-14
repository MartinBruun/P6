import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/features/account/data/repositories/user_repository.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';
import 'package:washee/features/account/domain/usecases/sign_in.dart';

import '../../../../fixtures/entities/account/users.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group("SignInUsecase base (requirements)",() {
    test(
      """
        Should sign in the user and return it logged in
        When called with a valid users username and password
        Given the repository have a valid, authorized user registered
      """,
      () async {
      UserEntity signedInUser = firstUserFixture();
      UserRepository mockRepo = MockUserRepository();
      when(
        () => mockRepo.autoSignIn())
        .thenAnswer((_) async => signedInUser);
      SignInUseCase testUsecase = SignInUseCase(userRepository: mockRepo);

      // act
      UserEntity actualUser = await testUsecase.call(SignInParams(email: signedInUser.email, password: "validPassword"));

      // assert
      expect(actualUser, signedInUser);
    }, skip: true,
    tags: ["unittest","account","usecases"]);
  });
  group("SignInUsecase security (requirements)",() {
    test(
      """
        Should XXX
        When YYY
        Given ZZZ
      """,
      () async {
      // arrange

      // act

      // assert
    }, skip: true,
    tags: ["unittest","account","usecases"]);
  });
}