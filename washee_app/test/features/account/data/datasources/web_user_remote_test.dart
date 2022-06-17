import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/core/externalities/web/web_connector.dart';
import 'package:washee/features/account/data/datasources/user_remote.dart';

import '../../../../fixtures/entities/account/users.dart';

class MockWebConnector extends Mock implements WebConnector {}

void main() {
  group("WebUserRemote getUser",() {
    test(
      """
        Should return the json of the user matching the id being used as a parameter
        Given the web connector can access an account with said id
      """,
      () async {
      Map<String,dynamic> userJson = firstUserAsJsonFixture();
      String endpoint = "/api/1/users/" + userJson["id"].toString() + "/";
      WebConnector mockConnector = MockWebConnector();
      when(
        () => mockConnector.retrieve(endpoint))
        .thenAnswer(
          (_) async => Response
            (requestOptions: RequestOptions(path: endpoint),
            data: userJson
          )
        );
      WebUserRemote testRemote = WebUserRemote(webConnector: mockConnector);

      // act
      Map<String,dynamic> actualUser = await testRemote.getUser(userJson["id"]);

      // assert
      expect(actualUser, userJson);
    },
    tags: ["unittest","account","datasources"]);
  });
  group("WebUserRemote getUsers",() {
    test(
      """
        Should return all the json of the users which the remote have access to
        When called with no specified options
      """,
      () async {
      // arrange

      // act

      // assert
    },skip: true,
    tags: ["unittest","account","datasources"]);
  });
  group("WebUserRemote updateUser",() {
    test(
      """
        Should return the  updated user with a new balance,
        When called with the the json of user being updated and the new balance it should be set to,
        Given the user exists
      """,
      () async {
      // arrange

      // act

      // assert
    },skip: true,
    tags: ["unittest","account","datasources"]);
  });
  group("WebUserRemote postUser",() {
    test(
      """
        Should create the user on the backend and return the newly created user,
        When called with the json of an unsaved user,
        Given the web connector properly sends the data to the backend
      """,
      () async {
      // arrange

      // act

      // assert
    },skip: true,
    tags: ["unittest","account","datasources"]);
  });
  group("WebUserRemote deleteUser",() {
    test(
      """
        Should return the json of the just deleted user from the backend,
        When called with the json of a previously saved user,
        Given the web connector correctly sends the data to the backend
      """,
      () async {
      // arrange

      // act

      // assert
    },skip: true,
    tags: ["unittest","account","datasources"]);
  });
  group("WebUserRemote signIn",() {
    test(
      """
        Should return the json of the just signed in user
        When called with the users username and password
        Given the web connector correctly sends the data to the backend
      """,
      () async {
      
    },skip: true,
    tags: ["unittest","account","datasources"]);
  });
  group("WebUserRemote autoSignIn",() {
    test(
      """
        Should return the json of the just signed in user
        Given the web connector correctly sends the data to the backend
      """,
      () async {
      // arrange

      // act

      // assert
    },skip: true,
    tags: ["unittest","account","datasources"]);
  });
}