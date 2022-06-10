import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:washee/features/account/data/models/web_account_model.dart';
import 'package:washee/features/account/domain/entities/account_entity.dart';

import '../../../../fixtures/entities/account/accounts.dart';
import '../../../../fixtures/entities/account/users.dart';

void main() {
  group("WebAccountModel fromEntity",() {
    test(
      """
        Should convert an AccountEntity into a WebAccountModel
      """,
      () {
      // arrange
      AccountEntity accountEntity = firstAccountFixture();

      // act
      WebAccountModel actual = WebAccountModel.fromEntity(accountEntity);

      // assert
      expect (actual.props, accountEntity.props);
    });
  });
  group("WebAccountModel fromJson",() {
    test(
      """
        Should convert a valid json input into an account web model,
      """,
      () {
      // arrange
      Map<String,dynamic> accountAsJson = firstAccountAsJsonFixture();

      WebAccountModel expectedAccount = WebAccountModel.fromEntity(firstAccountFixture());

      // act
      WebAccountModel actual = WebAccountModel.fromJson(accountAsJson);

      // assert
      expect (actual, expectedAccount);
    });
    test(
      """
        Should be able to deserialize an account with a user
      """,
      () {
      // arrange
      Map<String,dynamic> testAccount = firstAccountAsJsonFixture();
      testAccount["owners"] = [firstUserAsJsonFixture()];

      AccountEntity expectedAccount = WebAccountModel.fromEntity(firstAccountFixture());
      expectedAccount.owners.add(firstUserFixture());

      // act
      WebAccountModel actual = WebAccountModel.fromJson(testAccount);

      // assert
      expect (actual, expectedAccount);
    });
  test(
      """
        Should be able to deserialize an account which is shared by another user
      """,
      () {
      // arrange
      Map<String,dynamic> testAccount = firstAccountAsJsonFixture();
      testAccount["owners"] = [firstUserAsJsonFixture(), secondUserAsJsonFixture()];
      
      AccountEntity expectedAccount = WebAccountModel.fromEntity(firstAccountFixture());
      expectedAccount.owners.add(firstUserFixture());
      expectedAccount.owners.add(secondUserFixture());

      // act
      WebAccountModel actual = WebAccountModel.fromJson(testAccount);

      // assert
      expect (actual, expectedAccount);
    });
  });
  group("WebAccountModel toJson",() {
    test(
      """
        Should convert an account web model into its corresponding json
      """,
      () {
      // arrange
      WebAccountModel testAccount = WebAccountModel.fromEntity(firstAccountFixture());
      
      Map<String,dynamic> expectedJson = firstAccountAsJsonFixture();

      // act
      Map<String,dynamic> actual = testAccount.toJson();

      // assert
      expect (actual, expectedJson);
    });
    test(
      """
        Should be able to serialize an account with a user
      """,
      () {
      // arrange
      WebAccountModel testAccount = WebAccountModel.fromEntity(firstAccountFixture());
      testAccount.owners.add(firstUserFixture());
      
      Map<String,dynamic> expectedJson = firstAccountAsJsonFixture();
      expectedJson["owners"] = [firstUserAsJsonFixture()];

      // act
      Map<String,dynamic> actual = testAccount.toJson();

      // assert
      expect (actual, expectedJson);
    });
  test(
      """
        Should be able to serialize an account which is shared by another user
      """,
      () {
      // arrange
      WebAccountModel testAccount = WebAccountModel.fromEntity(firstAccountFixture());
      testAccount.owners.add(firstUserFixture());
      testAccount.owners.add(secondUserFixture());
      
      Map<String,dynamic> expectedJson = firstAccountAsJsonFixture();
      expectedJson["owners"] = [firstUserAsJsonFixture(), secondUserAsJsonFixture()];

      // act
      Map<String,dynamic> actual = testAccount.toJson();

      // assert
      expect (actual, expectedJson);
    });
  });
}