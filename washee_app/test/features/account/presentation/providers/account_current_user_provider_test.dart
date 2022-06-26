import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';
import 'package:washee/features/account/domain/usecases/auto_sign_in.dart';
import 'package:washee/features/account/domain/usecases/sign_in.dart';
import 'package:washee/features/account/domain/usecases/sign_out.dart';
import 'package:washee/features/account/presentation/providers/account_current_user_provider.dart';

import '../../../../fixtures/entities/account/users.dart';

class MockAutoSignInUsecase extends Mock implements AutoSignInUsecase {}
class MockSignInUsecase extends Mock implements SignInUseCase {}
class MockSignOutUsecase extends Mock implements SignOutUsecase {}

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
      var providerUnderTest = AccountCurrentUserProvider(
        autoSignInUsecase: mockAutoSignInUsecase, 
        signInUsecase: MockSignInUsecase(), 
        signOutUsecase: MockSignOutUsecase());
      providerUnderTest.currentUser = UserEntity.anonymousUser();

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
      SignInUseCase mockSignInUsecase = MockSignInUsecase();
      String email = newUser.email;
      String password = "valid password";
      when(
        () => mockSignInUsecase.call(SignInParams(email: email, password:password)))
        .thenAnswer((_) async => newUser);
      var providerUnderTest = AccountCurrentUserProvider(
        autoSignInUsecase: MockAutoSignInUsecase(), 
        signInUsecase: mockSignInUsecase,
        signOutUsecase: MockSignOutUsecase());

      // act
      await providerUnderTest.signIn(username: email, password: password);

      // assert
      verify(() => mockSignInUsecase.call(SignInParams(email: email, password:password))).called(1);
      expect(providerUnderTest.currentUser, newUser);
      expect(providerUnderTest.currentUser.loggedIn, true);
    },
    tags: ["unittest","account","providers"]);
  });
  group("AccountCurrentUserProvider signOut",() {
    test(
      """
        Should make the current user an anonymous user and log the person out
        Given the usecase correctly signs in the new user
      """,
      () async {
      // arrange
      UserEntity currentUser = firstUserFixture();
      UserEntity loggedOutUser = UserEntity.anonymousUser();
      SignOutUsecase mockSignOutUsecase = MockSignOutUsecase();
      when(
        () => mockSignOutUsecase.call(SignOutParams(userLoggingOut: currentUser)))
        .thenAnswer((_) async => loggedOutUser);
      var providerUnderTest = AccountCurrentUserProvider(
        autoSignInUsecase: MockAutoSignInUsecase(), 
        signInUsecase: MockSignInUsecase(),
        signOutUsecase: mockSignOutUsecase);
      providerUnderTest.currentUser = currentUser;

      // act
      await providerUnderTest.signOut();

      // assert
      verify(() => mockSignOutUsecase.call(SignOutParams(userLoggingOut: currentUser))).called(1);
      expect(providerUnderTest.currentUser, loggedOutUser);
      expect(providerUnderTest.currentUser.loggedIn, false);
    },
    tags: ["unittest","account","providers"]);
  });
}