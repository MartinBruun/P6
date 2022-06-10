import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:washee/features/account/data/models/web_account_model.dart';

import '../../../../fixtures/entities/account/accounts.dart';

void main() {
  group("WebAccountModel Serialization of toJson and fromJson",() {
    test(
      """
        Should convert a valid json input into an account web model and back again,
        Given the json is valid on the backend.
      """,
      () {
      // arrange
      Map<String,dynamic> accountAsJson = {
        "id": 1,
        "name": "Some Account",
        "balance": 100.0,
        "owners": []
      };
      WebAccountModel testWebAccountModel = WebAccountModel.fromJson(accountAsJson);

      // act
      final result = testWebAccountModel.toJson();

      // assert
      
      expect (result, accountAsJson);
    });
    test(
      """
        Should verify that it can use the first account fixture
      """,
      () {
      // arrange
      WebAccountModel testWebAccountModel = WebAccountModel.fromJson(firstAccountAsJsonFixture);

      // act
      final result = testWebAccountModel.toJson();

      // assert
      expect (result, firstAccountAsJsonFixture);
    });
    test(
      """
        Should verify that it can use the second account fixture
      """,
      () {
      // arrange
      WebAccountModel testWebAccountModel = WebAccountModel.fromJson(secondAccountAsJsonFixture);

      // act
      final result = testWebAccountModel.toJson();

      // assert
      expect (result, secondAccountAsJsonFixture);
    });
  });
}