import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/features/account/data/repositories/user_repository.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';
import 'package:washee/features/account/domain/usecases/auto_sign_in.dart';

import '../../../../fixtures/entities/account/users.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group("AutoSignInUsecase base (requirements)",() {
    test(
      """
        Should automatically sign in the user and return it logged in
        Given the repository have a valid, authorized user registered
      """,
      () async {
      // arrange
      UserEntity prevSignedInUser = firstUserFixture();
      prevSignedInUser.loggedIn = true;
      UserRepository mockRepo = MockUserRepository();
      when(
        () => mockRepo.autoSignIn())
        .thenAnswer((_) async => prevSignedInUser);
      AutoSignInUsecase testUsecase = AutoSignInUsecase(userRepository: mockRepo);

      // act
      UserEntity actualUser = await testUsecase.call(AutoSignInParams());

      // assert
      expect(actualUser, prevSignedInUser);
      expect(actualUser.loggedIn, true);
    },
    tags: ["unittest","account","usecases"]);
    test(
      """
        Should automatically register the user as an anonymous user
        Given the repository does not have a valid, authorized user registered
      """,
      () async {
      // arrange
      UserEntity anonymousUser = UserEntity.anonymousUser();
      anonymousUser.loggedIn = false;
      UserRepository mockRepo = MockUserRepository();
      when(
        () => mockRepo.autoSignIn())
        .thenAnswer((_) async => anonymousUser);
      AutoSignInUsecase testUsecase = AutoSignInUsecase(userRepository: mockRepo);

      // act
      UserEntity actualUser = await testUsecase.call(AutoSignInParams());

      // assert
      expect(actualUser.loggedIn, false);
      expect(actualUser, anonymousUser);
    },
    tags: ["unittest","account","usecases"]);
  });
  group("AutoSignInUsecase security (requirements)",() {
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