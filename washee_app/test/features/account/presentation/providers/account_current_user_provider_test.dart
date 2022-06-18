import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';
import 'package:washee/features/account/domain/usecases/auto_sign_in.dart';
import 'package:washee/features/account/domain/usecases/sign_in.dart';
import 'package:washee/features/account/presentation/provider/account_current_user_provider.dart';

import '../../../../fixtures/entities/account/users.dart';

class MockAutoSignInUsecase extends Mock implements AutoSignInUsecase {}
class MockSignInUsecase extends Mock implements SignInUseCase {}

void main() {
  group("AccountCurrentUserProvider autoSignIn",() {
    test(
      """
        Should update the registered current user
        Given the usecase correctly signs in the new user
      """,
      () async {
      // arrange
      UserEntity newUser = firstUserFixture();
      AutoSignInUsecase mockAutoSignInUsecase = MockAutoSignInUsecase();
      when(
        () => mockAutoSignInUsecase.call(AutoSignInParams()))
        .thenAnswer((_) async => newUser);
      SignInUseCase mockSignInUsecase = MockSignInUsecase();
      var providerUnderTest = AccountCurrentUserProvider(autoSignInUsecase: mockAutoSignInUsecase, signInUsecase: mockSignInUsecase);

      // act
      await providerUnderTest.autoSignIn();

      // assert
      verify(() => mockAutoSignInUsecase.call(AutoSignInParams())).called(1);
      expect(providerUnderTest.currentUser, newUser);
      expect(providerUnderTest.currentUser.loggedIn, true);
    },
    tags: ["unittest","account","providers"]);
  });
  group("AccountCurrentUserProvider signIn",() {
    test(
      """
        Should update the registered current user
        Given the usecase correctly signs in the new user
      """,
      () async {
      // arrange
      UserEntity newUser = firstUserFixture();
      AutoSignInUsecase mockAutoSignInUsecase = MockAutoSignInUsecase();
      SignInUseCase mockSignInUsecase = MockSignInUsecase();
      String email = newUser.email;
      String password = "valid password";
      when(
        () => mockSignInUsecase.call(SignInParams(email: email, password:password)))
        .thenAnswer((_) async => newUser);
      var providerUnderTest = AccountCurrentUserProvider(autoSignInUsecase: mockAutoSignInUsecase, signInUsecase: mockSignInUsecase);

      // act
      await providerUnderTest.signIn(username: email, password: password);

      // assert
      verify(() => mockSignInUsecase.call(SignInParams(email: email, password:password))).called(1);
      expect(providerUnderTest.currentUser, newUser);
      expect(providerUnderTest.currentUser.loggedIn, true);
    },
    tags: ["unittest","account","providers"]);
  });
}