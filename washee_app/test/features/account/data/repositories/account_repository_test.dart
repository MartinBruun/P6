import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/features/account/data/datasources/account_remote.dart';
import 'package:washee/features/account/data/models/web_account_model.dart';
import 'package:washee/features/account/data/repositories/account_repository_impl.dart';
import 'package:washee/features/account/domain/entities/account_entity.dart';

import '../../../../fixtures/entities/account/accounts.dart';

class MockAccountRemote extends Mock implements WebAccountRemote {}

void main() {
  group("AccountRepository getAccount",() {
    test(
      """
        Should return the account matching the id being used as a parameter
        Given the remote can access an account with said id
      """,
      () async {
      // arrange
      WebAccountModel expectedEntity = WebAccountModel.fromEntity(firstAccountFixture());
      WebAccountRemote mockRemote = MockAccountRemote();
      when(() => 
        mockRemote.getAccount(expectedEntity.id))
        .thenAnswer((_) async => expectedEntity.toJson());
      AccountRepository testAccountRepository = AccountRepository(accRemote: mockRemote);

      // act
      AccountEntity result = await testAccountRepository.getAccount(expectedEntity.id);

      // assert
      expect(result,expectedEntity);
    },
    tags: ["unittest","account","repositories"]);
  });
  group("AccountRepository getAccounts",() {
    test(
      """
        Should return all accounts which the remote have access to
        When called with no specified options
      """,
      () async {
      // arrange

      // act

      // assert
    }, skip:true,
    tags: ["unittest","account","repositories"]);
  });
  group("AccountRepository updateAccount",() {
    test(
      """
        Should return the updated account with a new balance,
        When called with the account being updated and the new balance it should be set to,
        Given the account exists
      """,
      () async {
      // arrange

      // act

      // assert
    }, skip:true,
    tags: ["unittest","account","repositories"]);
  });
  group("AccountRepository postAccount",() {
    test(
      """
        Should create the account on the backend and return the newly created account,
        When called with an unsaved account,
        Given the remote properly sends the data to the backend
      """,
      () async {
      // arrange

      // act

      // assert
    }, skip:true,
    tags: ["unittest","account","repositories"]);
  });
  group("AccountRepository deleteAccount",() {
    test(
      """
        Should return the just deleted account from the backend,
        When called with a previously saved account,
        Given the remote correctly sends the data to the backend
      """,
      () async {
      // arrange

      // act

      // assert
    }, skip:true,
    tags: ["unittest","account","repositories"]);
  });
}