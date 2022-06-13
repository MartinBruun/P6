import 'dart:core';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group("UserRepository getUser",() {
    test(
      """
        Should return the User matching the id being used as a parameter
        Given the remote can access an User with said id
      """,
      () async {
      // arrange

      // act

      // assert
    }, skip:true,
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

      // act

      // assert
    }, skip:true,
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

      // act

      // assert
    }, skip:true,
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

      // act

      // assert
    }, skip:true,
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

      // act

      // assert
    }, skip:true,
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

      // act

      // assert
    }, skip:true,
    tags: ["unittest","account","repositories"]);
  });
}