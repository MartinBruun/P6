import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpConnector extends Mock implements Dio {}

void main() {
  group("WebConnector authorize",() {
    test(
      """
        Should return the response authorizing the user
        When called with a valid users username and password
        Given the backend processes the request correctly
      """,
      () async {
      // arrange

      // act

      // assert
    }, skip: true,
    tags: ["unittest","core","externalities","web_connector","authorize"]);
  });
  group("WebConnector retrieve",() {
    test(
      """
        
      """,
      () async {
      // arrange

      // act

      // assert
    }, skip: true,
    tags: ["unittest","core","externalities","web_connector","retrieve"]);
  });
  group("WebConnector update",() {
    test(
      """
        
      """,
      () async {
      // arrange

      // act

      // assert
    }, skip: true,
    tags: ["unittest","core","externalities","web_connector","update"]);
  });
  group("WebConnector create",() {
    test(
      """
        
      """,
      () async {
      // arrange

      // act

      // assert
    }, skip: true,
    tags: ["unittest","core","externalities","web_connector","create"]);
  });
  group("WebConnector delete",() {
    test(
      """
        
      """,
      () async {
      // arrange

      // act

      // assert
    }, skip: true,
    tags: ["unittest","core","externalities","web_connector","delete"]);
  });
}