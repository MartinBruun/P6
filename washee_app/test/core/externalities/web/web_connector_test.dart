import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/core/externalities/web/web_connector.dart';
import 'package:washee/core/standards/environments/environment.dart';

class MockHttpConnector extends Mock implements Dio {}
class MockEnvironment extends Mock implements Environment {}
class MockSecureStorage extends Mock implements FlutterSecureStorage {}
class MockResponse extends Mock implements Response {}

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
      Dio mockDio = MockHttpConnector();
      Response mockAuthorizedResponse = MockResponse();
      String mockToken = "Mocked token";
      mockAuthorizedResponse.data = {"token": mockToken};
      when(
        () => mockDio.post(expectedEndpoint, data:{"username": mockUsername, "password": mockPassword}))
        .thenAnswer((_) async => mockAuthorizedResponse);
      Environment mockEnvironment = MockEnvironment();
      when(
        () => mockEnvironment.config.webApiHost)
        .thenAnswer((invocation) => mockedDomain);
      FlutterSecureStorage secureStorage = FlutterSecureStorage();
      IWebConnector testWebConector = WebConnector(httpConnection: mockDio, secureStorage: secureStorage, environment: mockEnvironment);
      expect(testWebConector.authorizeURL, expectedEndpoint);

      // act
      await testWebConector.authorize(mockUsername, mockPassword);

      // assert
      expect(mockDio.options.headers["authorization"], "TOKEN $mockToken");
    }, skip: true,
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
      Dio mockedDio = MockHttpConnector();
      FlutterSecureStorage mockedSecureStorage = MockSecureStorage();
      Environment mockedEnvironment = MockEnvironment();
      IWebConnector testWebConnector = WebConnector(httpConnection: mockedDio, secureStorage: mockedSecureStorage, environment: mockedEnvironment);

      when(() => mockedSecureStorage.read(key: "username")).thenAnswer((_) async => "ValidUsername");
      when(() => mockedSecureStorage.read(key: "password")).thenAnswer((_) async => "ValidPassword");
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