import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/features/account/data/repositories/user_repository.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group("SignOutUsecase base (requirements)",() {
    test(
      """
        Should sign the user out and set the user as an anonymous user
      """,
      () async {
      // arrange

      // act

      // assert
    }, skip: true,
    tags: ["unittest","account","usecases"]);
  });
  group("SignOutUsecase security (requirements)",() {
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