

import 'package:washee/features/account/domain/entities/user_entity.dart';

UserEntity firstUserFixture(){
  return UserEntity(
    id: 1,
    email: "first_user@test.com",
    username: "First User",
    loggedIn: true,
    accounts: []
  );
} 

Map<String,dynamic> firstUserAsJsonFixture() {
  return {
    "id": 1,
    "email": "first_user@test.com",
    "username": "First User",
    "accounts": []
  };
} 

UserEntity secondUserFixture(){
  return UserEntity(
    id: 2,
    email: "second_user@test.com",
    username: "Second User",
    loggedIn: true,
    accounts: []
  );
} 

Map<String,dynamic> secondUserAsJsonFixture(){
  return {
    "id": 2,
    "email": "second_user@test.com",
    "username": "Second User",
    "accounts": []
  };
} 