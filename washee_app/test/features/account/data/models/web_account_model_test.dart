import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:washee/features/account/data/models/web_account_model.dart';

import '../../../../fixtures/entities/account/accounts.dart';

void main() {
  late WebAccountModel testWebAccountModel;

  group("toJson",() {
    test(
      """
        Should convert an AccountEntity to json that can be accepted by the backend
        When called with a complete AccountEntity
      """,
      () {
      // arrange
      testWebAccountModel = WebAccountModel();

      // act
      final result = testWebAccountModel.toJson(firstAccount);

      // assert
      expect (result, firstAccountAsJson);
    }, skip: true);
  });

  group("fromJson",() {
    test(
      """
        Should convert backend data to an AccountEntity
        When called with a complete entity json
      """,
      () {
      // arrange
      testWebAccountModel = WebAccountModel();

      // act
      final result = testWebAccountModel.fromJson(firstAccountAsJson);

      // assert
      expect (result, firstAccount);
    }, skip: true);
  });
}