import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:washee/features/account/data/models/web_user_model.dart';

import '../../../../fixtures/entities/account/users.dart';

void main() {
  late WebUserModel testWebUserModel;

  group("toJson",() {
    test(
      """
        Should convert an AccountEntity to json that can be accepted by the backend
        When called with a complete AccountEntity
      """,
      () {
      // arrange
      testWebUserModel = WebUserModel();

      // act
      final result = testWebUserModel.toJson(thisUser);

      // assert
      expect (result, thisUserAsJson);
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
      testWebUserModel = WebUserModel();

      // act
      final result = testWebUserModel.fromJson(thisUserAsJson);

      // assert
      expect (result, thisUser);
    }, skip: true);
  });
}