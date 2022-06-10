import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:washee/features/account/data/models/web_user_model.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';

import '../../../../fixtures/entities/account/users.dart';

void main() {
  group("WebUserModel Serialization of toJson and fromJson",() {
    test(
      """
        Should convert a valid json input into a user web model and back again,
        Given the json is valid on the backend.
      """,
      () {
      // arrange
      Map<String,dynamic> userAsJson = {
        "id": 1,
        "email": "test_user@test.com",
        "username": "Test User",
        "accounts": []
      };
      WebUserModel testWebAccountModel = WebUserModel.fromJson(userAsJson);

      // act
      final result = testWebAccountModel.toJson();

      // assert
      expect (result, userAsJson);
    });
    test(
      """
        Should verify that it can use the first account fixture
      """,
      () {
      // arrange
      WebUserModel testWebUserModel = WebUserModel.fromJson(firstUserAsJsonFixture);

      // act
      final result = testWebUserModel.toJson();

      // assert
      expect (result, firstUserAsJsonFixture);
    });
    test(
      """
        Should verify that it can use the second account fixture
      """,
      () {
      // arrange
      WebUserModel testWebUserModel = WebUserModel.fromJson(secondUserAsJsonFixture);

      // act
      final result = testWebUserModel.toJson();

      // assert
      expect (result, secondUserAsJsonFixture);
    });
  });
}