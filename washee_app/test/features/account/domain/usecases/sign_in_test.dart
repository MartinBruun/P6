import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/features/account/data/repositories/user_repository.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group("SignInUsecase base (requirements)",() {
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
    tags: ["unittest","account","usecases","sign_in","base"]);
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
    tags: ["unittest","account","usecases","sign_in","security"]);
  });
}