import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/features/account/data/datasources/user_remote.dart';
import 'package:washee/features/account/data/models/web_user_model.dart';
import 'package:washee/features/account/data/repositories/user_repository.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';

import '../../../../fixtures/entities/account/users.dart';

class MockUserRemote extends Mock implements IWebUserRemote {}

void main() {
  group("UserRepository getUser",() {
    test(
      """
        Should return the User matching the id being used as a parameter
        Given the remote can access an User with said id
      """,
      () async {
      // arrange
      WebUserModel expectedEntity = WebUserModel.fromEntity(firstUserFixture());
      IWebUserRemote mockRemote = MockUserRemote();
      when(() => 
        mockRemote.getUser(expectedEntity.id))
        .thenAnswer((_) async => expectedEntity.toJson());
      UserRepository testUserRepository = UserRepository(userRemote: mockRemote);

      // act
      UserEntity result = await testUserRepository.getUser(expectedEntity.id);

      // assert
      expect(result,expectedEntity);
    },
    tags: ["unittest","account","repositories"]);
  });
  group("UserRepository getUsers",() {
    test(
      """
        Should return all Users which the remote have access to
        When called with no specified options
      """,
      () async {
      // arrange
      List<WebUserModel> expectedEntities = [WebUserModel.fromEntity(firstUserFixture())];
      IWebUserRemote mockRemote = MockUserRemote();
      Map<String,dynamic> noOptions = {};
      when(() => 
        mockRemote.getUsers(noOptions))
        .thenAnswer((_) async => [expectedEntities[0].toJson()]);
      UserRepository testUserRepository = UserRepository(userRemote: mockRemote);

      // act
      List<UserEntity> result = await testUserRepository.getUsers(noOptions);

      // assert
      expect(result,expectedEntities);
    },
    tags: ["unittest","account","repositories"]);
  });
  group("UserRepository updateUser",() {
    test(
      """
        Should return the updated User with a new balance,
        When called with the User being updated and the new balance it should be set to,
        Given the User exists
      """,
      () async {
      // arrange
      WebUserModel initialEntity = WebUserModel.fromEntity(firstUserFixture());
      String newNameValue = "New Name!";
      Map<String,dynamic> valuesToUpdate = {
        "name": newNameValue
      };
      Map<String,dynamic> updatedEntityAsJson = initialEntity.toJson();
      updatedEntityAsJson["name"] = newNameValue;
      IWebUserRemote mockRemote = MockUserRemote();
      when(() => 
        mockRemote.updateUser(initialEntity.id, valuesToUpdate))
        .thenAnswer((_) async => updatedEntityAsJson);
      UserRepository testUserRepository = UserRepository(userRemote: mockRemote);

      // act
      UserEntity result = await testUserRepository.updateUser(initialEntity, valuesToUpdate);

      // assert
      expect(result,WebUserModel.fromJson(updatedEntityAsJson));
    },
    tags: ["unittest","account","repositories"]);
  });
  group("UserRepository postUser",() {
    test(
      """
        Should create the User on the backend and return the newly created User,
        When called with an unsaved User,
        Given the remote properly sends the data to the backend
      """,
      () async {
      // arrange
      WebUserModel entityToCreate = WebUserModel.fromEntity(firstUserFixture());
      Map<String,dynamic> entityAsJson = entityToCreate.toJson();
      IWebUserRemote mockRemote = MockUserRemote();
      when(() => 
        mockRemote.postUser(entityAsJson))
        .thenAnswer((_) async => entityAsJson);
      UserRepository testUserRepository = UserRepository(userRemote: mockRemote);

      // act
      UserEntity result = await testUserRepository.postUser(entityToCreate);

      // assert
      expect(result,entityToCreate);
    },
    tags: ["unittest","account","repositories"]);
  });
  group("UserRepository deleteUser",() {
    test(
      """
        Should return the just deleted User from the backend,
        When called with a previously saved User,
        Given the remote correctly sends the data to the backend
      """,
      () async {
      // arrange
      WebUserModel entityToDelete = WebUserModel.fromEntity(firstUserFixture());
      IWebUserRemote mockRemote = MockUserRemote();
      when(() => 
        mockRemote.deleteUser(entityToDelete.id))
        .thenAnswer((_) async => entityToDelete.toJson());
      UserRepository testUserRepository = UserRepository(userRemote: mockRemote);

      // act
      UserEntity result = await testUserRepository.deleteUser(entityToDelete);

      // assert
      expect(result,entityToDelete);
    },
    tags: ["unittest","account","repositories"]);
  });
  group("UserRepository signIn",() {
    test(
      """
        Should return the signed in User 
        When called with the users username and password
        Given the remote correctly sends the data to the backend
      """,
      () async {
      // arrange
      WebUserModel expectedEntity = WebUserModel.fromEntity(firstUserFixture());
      String usersPassword ="ValidPassword";
      IWebUserRemote mockRemote = MockUserRemote();
      when(() => 
        mockRemote.signIn(expectedEntity.id.toString(), usersPassword))
        .thenAnswer((_) async => expectedEntity.toJson());
      UserRepository testUserRepository = UserRepository(userRemote: mockRemote);

      // act
      UserEntity result = await testUserRepository.signIn(expectedEntity.id.toString(), usersPassword);

      // assert
      expect(result,expectedEntity);
    },
    tags: ["unittest","account","repositories"]);
  });
  group("UserRepository autoSignIn",() {
    test(
      """
        Should return the signed in User 
        When called with the users username and password
        Given the remote correctly sends the data to the backend
      """,
      () async {
      // arrange
      WebUserModel expectedEntity = WebUserModel.fromEntity(firstUserFixture());
      IWebUserRemote mockRemote = MockUserRemote();
      when(() => 
        mockRemote.autoSignIn())
        .thenAnswer((_) async => expectedEntity.toJson());
      UserRepository testUserRepository = UserRepository(userRemote: mockRemote);

      // act
      UserEntity result = await testUserRepository.autoSignIn();

      // assert
      expect(result,expectedEntity);
    },
    tags: ["unittest","account","repositories"]);
  });
}