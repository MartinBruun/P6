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
    tags: ["unittest","core","externalities"]);
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
    tags: ["unittest","core","externalities"]);
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
    tags: ["unittest","core","externalities"]);
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
    tags: ["unittest","core","externalities"]);
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
    tags: ["unittest","core","externalities"]);
  });
}