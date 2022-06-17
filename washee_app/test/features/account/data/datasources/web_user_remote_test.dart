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
        //arrange
        Map<String,dynamic> userJson = firstUserAsJsonFixture();
        String endpoint = "/api/1/users/" + userJson["id"].toString() + "/";
        WebConnector mockConnector = MockWebConnector();
        when(
          () => mockConnector.retrieve(endpoint, queryParameters: {}))
          .thenAnswer(
            (_) async => Response
              (requestOptions: RequestOptions(path: endpoint),
              statusCode: 200,
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
        //arrange
        List<Map<String,dynamic>> userJsons = [firstUserAsJsonFixture()];
        String endpoint = "/api/1/users/";
        Map<String,dynamic> noOptions = {};
        WebConnector mockConnector = MockWebConnector();
        when(
          () => mockConnector.retrieve(endpoint, queryParameters: {}))
          .thenAnswer(
            (_) async => Response
              (requestOptions: RequestOptions(path: endpoint),
              statusCode: 200,
              data: userJsons
            )
          );
        WebUserRemote testRemote = WebUserRemote(webConnector: mockConnector);
  
        // act
        List<Map<String,dynamic>> actualUserList = await testRemote.getUsers(noOptions);
  
        // assert
        expect(actualUserList, userJsons);
    },
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
      //arrange
        Map<String,dynamic> userJson = firstUserAsJsonFixture();
        String endpoint = "/api/1/users/" + userJson["id"].toString() + "/";
        String newName = "New Name!";
        Map<String,dynamic> valuesToUpdate = {
          "name": newName
        };
        Map<String,dynamic> updatedUserJson = firstUserAsJsonFixture();
        updatedUserJson["name"] = newName;
        WebConnector mockConnector = MockWebConnector();
        when(
          () => mockConnector.update(endpoint, valuesToUpdate))
          .thenAnswer(
            (_) async => Response
              (requestOptions: RequestOptions(path: endpoint),
              statusCode: 200,
              data: updatedUserJson
            )
          );
        WebUserRemote testRemote = WebUserRemote(webConnector: mockConnector);

        // act
        Map<String,dynamic> actualUser = await testRemote.updateUser(userJson["id"], valuesToUpdate);

        // assert
        expect(actualUser, updatedUserJson);
    },
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
      //arrange
        Map<String,dynamic> userJsonToCreate = firstUserAsJsonFixture();
        userJsonToCreate.remove("id");
        Map<String,dynamic> userJsonCreated = firstUserAsJsonFixture();
        String endpoint = "/api/1/users/";
        WebConnector mockConnector = MockWebConnector();
        when(
          () => mockConnector.create(endpoint, userJsonToCreate))
          .thenAnswer(
            (_) async => Response
              (requestOptions: RequestOptions(path: endpoint),
              statusCode: 200,
              data: userJsonCreated
            )
          );
        WebUserRemote testRemote = WebUserRemote(webConnector: mockConnector);

        // act
        Map<String,dynamic> actualUser = await testRemote.postUser(userJsonToCreate);

        // assert
        expect(actualUser, userJsonCreated);
    },
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
      ///arrange
        Map<String,dynamic> userJson = firstUserAsJsonFixture();
        String endpoint = "/api/1/users/" + userJson["id"].toString() + "/";
        WebConnector mockConnector = MockWebConnector();
        when(
          () => mockConnector.delete(endpoint))
          .thenAnswer(
            (_) async => Response
              (requestOptions: RequestOptions(path: endpoint),
              statusCode: 200,
              data: userJson
            )
          );
        WebUserRemote testRemote = WebUserRemote(webConnector: mockConnector);

        // act
        Map<String,dynamic> actualUser = await testRemote.deleteUser(userJson["id"]);

        // assert
        expect(actualUser, userJson);
    },
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
        // arrange
        Map<String,dynamic> userJson = firstUserAsJsonFixture();
        String userJsonsPassword ="Valid Password";
        WebConnector mockConnector = MockWebConnector();
        when(
          () => mockConnector.authorize(userJson["username"], userJsonsPassword))
          .thenAnswer(
            (_) async => Response
              (requestOptions: RequestOptions(path: "/api-token-auth/"),
              statusCode: 200,
              data: userJson
            )
          );
        WebUserRemote testRemote = WebUserRemote(webConnector: mockConnector);

        // act
        Map<String,dynamic> actualUser = await testRemote.signIn(userJson["username"], userJsonsPassword);

        // assert
        expect(actualUser, userJson);
    },
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
        Map<String,dynamic> userJson = firstUserAsJsonFixture();
        WebConnector mockConnector = MockWebConnector();
        when(
          () => mockConnector.renewAuthorization())
          .thenAnswer(
            (_) async => Response
              (requestOptions: RequestOptions(path: "/api-token-auth/"),
              statusCode: 200,
              data: userJson
            )
          );
        WebUserRemote testRemote = WebUserRemote(webConnector: mockConnector);

        // act
        Map<String,dynamic> actualUser = await testRemote.autoSignIn();

        // assert
        expect(actualUser, userJson);
    },
    tags: ["unittest","account","datasources"]);
  });
}