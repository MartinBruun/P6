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

// TODO: The test code here needs a proper refactoring to make it more readable

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
      Response actual = await testWebConector.authorize(mockUsername, mockPassword);

      // assert
      expect(actual.statusCode, 200);
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
      when(() => mockSecureStorage.read(key: "username")).thenAnswer((_) async => mockUsername); // INSTEAD of reading "username" it should be injected by environment
      when(() => mockSecureStorage.read(key: "password")).thenAnswer((_) async => mockPassword);
      when(() => mockSecureStorage.write(key: "username", value: mockUsername)).thenAnswer((_) async => null);
      when(() => mockSecureStorage.write(key: "password", value: mockPassword)).thenAnswer((_) async => null);
      when(() => mockSecureStorage.write(key: "token", value: mockToken)).thenAnswer((_) async => null);

      IWebConnector testWebConector = WebConnector(httpConnection: mockDio, secureStorage: mockSecureStorage, environment: mockEnvironment);
      expect(testWebConector.authorizeURL, expectedEndpoint);

      // act
      await testWebConector.renewAuthorization();

      // assert
      expect(mockDio.options.headers["authorization"], "TOKEN $mockToken");
    },
    tags: ["unittest","core","externalities"]);
  });
  group("WebConnector retrieve",() {
    test(
      """
        Should retrieve the information which it tries to get
        Given the user is authorized and the backend responds properly
      """,
      () async {
      // arrange
      String mockedDomain = "http://someUrl.com";
      String endpoint = "/some-data/1/";
      String expectedEndpoint = mockedDomain + endpoint;
      String validToken = "SomeToken";
      Map<String,dynamic> expectedResponse = {"data": "some data"};

      final mockDio = Dio(BaseOptions());
      final dioAdapter = DioAdapter(dio: mockDio);
      dioAdapter.onGet(
        expectedEndpoint,
        (server) => server.reply(
          200,
          expectedResponse,
        ),
      );

      Environment mockEnvironment = MockEnvironment();
      BaseConfig testConfig = MockConfig();
      when(() => mockEnvironment.config).thenAnswer((_) => testConfig);
      when(() => testConfig.webApiHost).thenAnswer((_) => mockedDomain);

      FlutterSecureStorage mockSecureStorage = MockSecureStorage();
      when(() => mockSecureStorage.read(key: "token")).thenAnswer((_) async => validToken);

      IWebConnector testWebConector = WebConnector(httpConnection: mockDio, secureStorage: mockSecureStorage, environment: mockEnvironment);

      // act
      Response result = await testWebConector.retrieve(endpoint, queryParameters: {});

      // assert
      expect(result.data["data"], expectedResponse["data"]);
    },
    tags: ["unittest","core","externalities"]);
  });
  group("WebConnector update",() {
    test(
      """
        Should update the information which it sends and return the newly updated resource
        Given the user is authorized and the backend responds properly
      """,
      () async {
      // arrange
      String mockedDomain = "http://someUrl.com";
      String endpoint = "/some-data/1/";
      String expectedEndpoint = mockedDomain + endpoint;
      String validToken = "SomeToken";
      Map<String,dynamic> dataToUpdate = {"data": "some data"};
      Map<String,dynamic> expectedResponse = {"data": "some data"};

      final mockDio = Dio(BaseOptions());
      final dioAdapter = DioAdapter(dio: mockDio);
      dioAdapter.onPatch(
        expectedEndpoint,
        (server) => server.reply(
          200,
          expectedResponse,
        ),
        data: dataToUpdate
      );

      Environment mockEnvironment = MockEnvironment();
      BaseConfig testConfig = MockConfig();
      when(() => mockEnvironment.config).thenAnswer((_) => testConfig);
      when(() => testConfig.webApiHost).thenAnswer((_) => mockedDomain);

      FlutterSecureStorage mockSecureStorage = MockSecureStorage();
      when(() => mockSecureStorage.read(key: "token")).thenAnswer((_) async => validToken);

      IWebConnector testWebConector = WebConnector(httpConnection: mockDio, secureStorage: mockSecureStorage, environment: mockEnvironment);

      // act
      Response result = await testWebConector.update(endpoint,dataToUpdate);

      // assert
      expect(result.data["data"], expectedResponse["data"]);
    },
    tags: ["unittest","core","externalities"]);
  });
  group("WebConnector create",() {
    test(
      """
        Should create the resource which it sends and return the newly created resource
        Given the user is authorized and the backend responds properly
      """,
      () async {
      // arrange
      String mockedDomain = "http://someUrl.com";
      String endpoint = "/some-data/";
      String expectedEndpoint = mockedDomain + endpoint;
      String validToken = "SomeToken";
      Map<String,dynamic> dataToCreate = {"data": "some data"};
      Map<String,dynamic> expectedResponse = {"data": "some data"};

      final mockDio = Dio(BaseOptions());
      final dioAdapter = DioAdapter(dio: mockDio);
      dioAdapter.onPost(
        expectedEndpoint,
        (server) => server.reply(
          200,
          expectedResponse,
        ),
        data: dataToCreate
      );

      Environment mockEnvironment = MockEnvironment();
      BaseConfig testConfig = MockConfig();
      when(() => mockEnvironment.config).thenAnswer((_) => testConfig);
      when(() => testConfig.webApiHost).thenAnswer((_) => mockedDomain);

      FlutterSecureStorage mockSecureStorage = MockSecureStorage();
      when(() => mockSecureStorage.read(key: "token")).thenAnswer((_) async => validToken);

      IWebConnector testWebConector = WebConnector(httpConnection: mockDio, secureStorage: mockSecureStorage, environment: mockEnvironment);

      // act
      Response result = await testWebConector.create(endpoint,dataToCreate);

      // assert
      expect(result.data["data"], expectedResponse["data"]);
    },
    tags: ["unittest","core","externalities"]);
  });
  group("WebConnector delete",() {
    test(
      """
        Should delete the resource which it sends and return the deleted resource
        Given the user is authorized and the backend responds properly
      """,
      () async {
      // arrange
      String mockedDomain = "http://someUrl.com";
      String endpoint = "/some-data/1/";
      String expectedEndpoint = mockedDomain + endpoint;
      String validToken = "SomeToken";
      Map<String,dynamic> expectedResponse = {"data": "some data"};

      final mockDio = Dio(BaseOptions());
      final dioAdapter = DioAdapter(dio: mockDio);
      dioAdapter.onDelete(
        expectedEndpoint,
        (server) => server.reply(
          200,
          expectedResponse,
        ),
      );

      Environment mockEnvironment = MockEnvironment();
      BaseConfig testConfig = MockConfig();
      when(() => mockEnvironment.config).thenAnswer((_) => testConfig);
      when(() => testConfig.webApiHost).thenAnswer((_) => mockedDomain);

      FlutterSecureStorage mockSecureStorage = MockSecureStorage();
      when(() => mockSecureStorage.read(key: "token")).thenAnswer((_) async => validToken);

      IWebConnector testWebConector = WebConnector(httpConnection: mockDio, secureStorage: mockSecureStorage, environment: mockEnvironment);

      // act
      Response result = await testWebConector.delete(endpoint);

      // assert
      expect(result.data["data"], expectedResponse["data"]);
    },
    tags: ["unittest","core","externalities"]);
  });
}