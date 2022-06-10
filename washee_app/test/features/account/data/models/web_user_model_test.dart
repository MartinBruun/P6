import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:washee/features/account/data/models/web_user_model.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';

import '../../../../fixtures/entities/account/accounts.dart';
import '../../../../fixtures/entities/account/users.dart';

void main() {
  group("WebUserModel fromEntity",() {
    test(
      """
        Should convert an UserEntity into a WebUserModel
      """,
      () {
      // arrange
      UserEntity userEntity = firstUserFixture();

      // act
      WebUserModel actual = WebUserModel.fromEntity(userEntity);

      // assert
      expect (actual.props, userEntity.props);
    });
  });
  group("WebUserModel fromJson",() {
    test(
      """
        Should convert a valid json input into an user web model,
      """,
      () {
      // arrange
      Map<String,dynamic> userAsJson = firstUserAsJsonFixture();

      WebUserModel expectedUser = WebUserModel.fromEntity(firstUserFixture());

      // act
      WebUserModel actual = WebUserModel.fromJson(userAsJson);

      // assert
      expect (actual, expectedUser);
    });
    test(
      """
        Should be able to deserialize a user with an account
      """,
      () {
      // arrange
      Map<String,dynamic> testUser = firstUserAsJsonFixture();
      testUser["accounts"] = [firstAccountAsJsonFixture()];

      WebUserModel expectedUser = WebUserModel.fromEntity(firstUserFixture());
      expectedUser.accounts.add(firstAccountFixture());

      // act
      WebUserModel actual = WebUserModel.fromJson(testUser);

      // assert
      expect (actual, expectedUser);
    });
  test(
      """
        Should be able to deserialize a User that has two accounts
      """,
      () {
      // arrange
      Map<String,dynamic> testUser = firstUserAsJsonFixture();
      testUser["accounts"] = [firstAccountAsJsonFixture(), secondAccountAsJsonFixture()];
      
      WebUserModel expectedUser = WebUserModel.fromEntity(firstUserFixture());
      expectedUser.accounts.add(firstAccountFixture());
      expectedUser.accounts.add(secondAccountFixture());

      // act
      WebUserModel actual = WebUserModel.fromJson(testUser);

      // assert
      expect (actual, expectedUser);
    });
  });
  group("WebUserModel toJson",() {
    test(
      """
        Should convert an User web model into its corresponding json
      """,
      () {
      // arrange
      WebUserModel testUser = WebUserModel.fromEntity(firstUserFixture());
      
      Map<String,dynamic> expectedJson = firstUserAsJsonFixture();

      // act
      Map<String,dynamic> actual = testUser.toJson();

      // assert
      expect (actual, expectedJson);
    });
    test(
      """
        Should be able to serialize a user with a account
      """,
      () {
      // arrange
      WebUserModel testUser = WebUserModel.fromEntity(firstUserFixture());
      testUser.accounts.add(firstAccountFixture());
      
      Map<String,dynamic> expectedJson = firstUserAsJsonFixture();
      expectedJson["accounts"] = [firstAccountAsJsonFixture()];

      // act
      Map<String,dynamic> actual = testUser.toJson();

      // assert
      expect (actual, expectedJson);
    });
  test(
      """
        Should be able to serialize a user which have multiple accounts
      """,
      () {
      // arrange
      WebUserModel testUser = WebUserModel.fromEntity(firstUserFixture());
      testUser.accounts.add(firstAccountFixture());
      testUser.accounts.add(secondAccountFixture());
      
      Map<String,dynamic> expectedJson = firstUserAsJsonFixture();
      expectedJson["accounts"] = [firstAccountAsJsonFixture(), secondAccountAsJsonFixture()];

      // act
      Map<String,dynamic> actual = testUser.toJson();

      // assert
      expect (actual, expectedJson);
    });
  });
}