import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/core/externalities/web/web_connector.dart';
import 'package:washee/features/account/data/datasources/account_remote.dart';

import '../../../../fixtures/entities/account/accounts.dart';

class MockWebConnector extends Mock implements WebConnector {}

void main() {
  group("WebAccountRemote getAccount",() {
    test(
      """
        Should return the json of the account matching the id being used as a parameter
        Given the web connector can access an account with said id
      """,
      () async {
      // arrange
      Map<String,dynamic> accountJson = firstAccountAsJsonFixture();
      String endpoint = "/api/1/accounts/" + accountJson["id"].toString() + "/";
      WebConnector mockConnector = MockWebConnector();
      when(
        () => mockConnector.retrieve(endpoint))
        .thenAnswer(
          (_) async => Response
            (requestOptions: RequestOptions(path: endpoint),
            data: accountJson
          )
        );
      WebAccountRemote testRemote = WebAccountRemote(webConnector: mockConnector);

      // act
      Map<String,dynamic> actualAccount = await testRemote.getAccount(accountJson["id"]);

      // assert
      expect(actualAccount, accountJson);
    },
    tags: ["unittest","account","datasources"]);
  });
  group("WebAccountRemote getAccounts",() {
    test(
      """
        Should return all the json of the accounts which the remote have access to
        When called with no specified options
      """,
      () async {
      // arrange
      List<Map<String,dynamic>> accountJsons = [firstAccountAsJsonFixture()];
      String endpoint = "/api/1/accounts/";
      Map<String,dynamic> noOptions = {};
      WebConnector mockConnector = MockWebConnector();
      when(
        () => mockConnector.retrieve(endpoint))
        .thenAnswer(
          (_) async => Response
            (requestOptions: RequestOptions(path: endpoint),
            data: accountJsons
          )
        );
      WebAccountRemote testRemote = WebAccountRemote(webConnector: mockConnector);

      // act
      List<Map<String,dynamic>> actualAccounts = await testRemote.getAccounts(noOptions);

      // assert
      expect(actualAccounts, accountJsons);
    },
    tags: ["unittest","account","datasources"]);
  });
  group("WebAccountRemote updateAccount",() {
    test(
      """
        Should return the  updated account with a new balance,
        When called with the the json of account being updated and the new balance it should be set to,
        Given the account exists
      """,
      () async {
      // arrange
      Map<String,dynamic> accountJson = firstAccountAsJsonFixture();
      String endpoint = "/api/1/accounts/" + accountJson["id"].toString() + "/";
      String newName = "New Name!";
      Map<String,dynamic> valuesToUpdate = {
        "name": newName
      };
      Map<String,dynamic> newAccount = accountJson;
      newAccount["name"] = newName;
      WebConnector mockConnector = MockWebConnector();
      when(
        () => mockConnector.update(endpoint, valuesToUpdate))
        .thenAnswer(
          (_) async => Response
            (requestOptions: RequestOptions(path: endpoint),
            data: accountJson
          )
        );
      WebAccountRemote testRemote = WebAccountRemote(webConnector: mockConnector);

      // act
      Map<String,dynamic> actualAccount = await testRemote.updateAccount(accountJson["id"], valuesToUpdate);

      // assert
      expect(actualAccount, newAccount);
    },
    tags: ["unittest","account","datasources"]);
  });
  group("WebAccountRemote postAccount",() {
    test(
      """
        Should create the account on the backend, assign it an id, and return the newly created account,
        When called with the json of an unsaved account,
        Given the web connector properly sends the data to the backend
      """,
      () async {
      // arrange
      Map<String,dynamic> accountJsonToCreate = firstAccountAsJsonFixture();
      accountJsonToCreate.remove("id");
      Map<String,dynamic> expectedAccountJson = firstAccountAsJsonFixture();
      String endpoint = "/api/1/accounts/";
      WebConnector mockConnector = MockWebConnector();
      when(
        () => mockConnector.create(endpoint, accountJsonToCreate))
        .thenAnswer(
          (_) async => Response
            (requestOptions: RequestOptions(path: endpoint),
            data: expectedAccountJson
          )
        );
      WebAccountRemote testRemote = WebAccountRemote(webConnector: mockConnector);

      // act
      Map<String,dynamic> actualAccount = await testRemote.postAccount(accountJsonToCreate);

      // assert
      expect(actualAccount, expectedAccountJson);
    },
    tags: ["unittest","account","datasources"]);
  });
  group("WebAccountRemote deleteAccount",() {
    test(
      """
        Should return the json of the just deleted account from the backend,
        When called with the json of a previously saved account,
        Given the web connector correctly sends the data to the backend
      """,
      () async {
      // arrange
      Map<String,dynamic> accountJson = firstAccountAsJsonFixture();
      String endpoint = "/api/1/accounts/" + accountJson["id"].toString() + "/";
      WebConnector mockConnector = MockWebConnector();
      when(
        () => mockConnector.delete(endpoint))
        .thenAnswer(
          (_) async => Response
            (requestOptions: RequestOptions(path: endpoint),
            data: accountJson
          )
        );
      WebAccountRemote testRemote = WebAccountRemote(webConnector: mockConnector);

      // act
      Map<String,dynamic> actualAccount = await testRemote.deleteAccount(accountJson["id"]);

      // assert
      expect(actualAccount, accountJson);
    },
    tags: ["unittest","account","datasources"]);
  });
}