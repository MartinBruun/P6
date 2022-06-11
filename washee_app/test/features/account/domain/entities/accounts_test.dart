import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:washee/features/account/domain/entities/account_entity.dart';

import '../../../../fixtures/entities/account/accounts.dart';
import '../../../../fixtures/entities/account/users.dart';

void main() {
  group("AccountEntity Constructor",() {
    test(
      """
        Should have a valid set of fixtures that follow the id schema
      """,
      () async {
      // arrange

      // act
      AccountEntity firstAccount = firstAccountFixture();
      AccountEntity secondAccount = secondAccountFixture();

      // assert
      expect(firstAccount.id, 1);
      expect(secondAccount.id, 2);
    });
    test(
      """
        First Fixture should create a new entity, independent of changes done to a previous entity
      """,
      () async {
      // arrange
      AccountEntity firstAccount = firstAccountFixture();
      firstAccount.owners.add(firstUserFixture());

      // act
      AccountEntity firstAccountUsingSameFixture = firstAccountFixture();

      // assert
      expect(firstAccountUsingSameFixture.id, firstAccount.id);
      expect(firstAccount.owners, [firstUserFixture()]);
      expect(firstAccountUsingSameFixture.owners, []);
    });
    test(
      """
        Second Fixture should create a new entity, independent of changes done to a previous entity
      """,
      () async {
      // arrange
      AccountEntity secondAccount = secondAccountFixture();
      secondAccount.owners.add(firstUserFixture());

      // act
      AccountEntity secondAccountUsingSameFixture = secondAccountFixture();

      // assert
      expect(secondAccountUsingSameFixture.id, secondAccount.id);
      expect(secondAccount.owners, [firstUserFixture()]);
      expect(secondAccountUsingSameFixture.owners, []);
    });
  });
}