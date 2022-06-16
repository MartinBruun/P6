import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:washee/core/externalities/web/web_connector.dart';
import 'package:washee/core/standards/environments/base_config.dart';
import 'package:washee/core/standards/environments/environment.dart';

import '../../../fixtures/entities/account/users.dart';

class MockEnvironment extends Mock implements Environment {}
class MockConfig extends Mock implements BaseConfig {}
class MockSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  group("WebConnector authorize",() {
    test(
      """
        Should authorize the user for all future subsequent calls to the backend
        When called with a valid users username and password
        Given the backend processes the request correctly
      """,
      () async {
      // arrange
      String mockedDomain = "http://someUrl.com";
      String expectedEndpoint = mockedDomain + "/api-token-auth/";
      String mockUsername = "SomeUsername";
      String mockPassword = "SomePassword";
      String mockToken = "SomeToken";
      Map<String,dynamic> mockResponse = firstUserAsJsonFixture();
      mockResponse["token"] = "SomeToken";

      final mockDio = Dio(BaseOptions());
      final dioAdapter = DioAdapter(dio: mockDio);
      dioAdapter.onPost(
        expectedEndpoint,
        (server) => server.reply(
          200,
          mockResponse,
        ),
        data: {
          "username": mockUsername,
          "password": mockPassword
        },
      );

      Environment mockEnvironment = MockEnvironment();
      BaseConfig testConfig = MockConfig();
      when(() => mockEnvironment.config).thenAnswer((_) => testConfig);
      when(() => testConfig.webApiHost).thenAnswer((_) => mockedDomain);

      FlutterSecureStorage mockSecureStorage = MockSecureStorage();
      when(() => mockSecureStorage.write(key: "username", value: mockUsername)).thenAnswer((_) async => null);
      when(() => mockSecureStorage.write(key: "password", value: mockPassword)).thenAnswer((_) async => null);
      when(() => mockSecureStorage.write(key: "token", value: mockToken)).thenAnswer((_) async => null);

      IWebConnector testWebConector = WebConnector(httpConnection: mockDio, secureStorage: mockSecureStorage, environment: mockEnvironment);
      expect(testWebConector.authorizeURL, expectedEndpoint);

      // act
      await testWebConector.authorize(mockUsername, mockPassword);

      // assert
      expect(mockDio.options.headers["authorization"], "TOKEN $mockToken");
    },
    tags: ["unittest","core","externalities"]);
  });
  group("WebConnector renewAuthorization",() {
    test(
      """
        Should renew the authorization
        Given the cached username and password exists on the backend
      """,
      () async {
      // arrange
      /*Dio mockedDio = MockHttpConnector();
      FlutterSecureStorage mockedSecureStorage = MockSecureStorage();
      Environment mockedEnvironment = MockEnvironment();
      IWebConnector testWebConnector = WebConnector(httpConnection: mockedDio, secureStorage: mockedSecureStorage, environment: mockedEnvironment);

      when(() => mockedSecureStorage.read(key: "username")).thenAnswer((_) async => "ValidUsername");
      when(() => mockedSecureStorage.read(key: "password")).thenAnswer((_) async => "ValidPassword");
      // act
*/
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