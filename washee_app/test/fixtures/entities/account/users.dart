

import 'package:washee/features/account/domain/entities/user_entity.dart';

import 'accounts.dart';

UserEntity firstUserFixture = UserEntity(
  id: 1,
  email: "first_user@test.com",
  username: "First User",
  accounts: [firstAccountFixture]
);

Map<String,dynamic> firstUserAsJsonFixture = {
  "id": 1,
  "email": "first_user@test.com",
  "username": "First User",
  "accounts": [firstAccountAsJsonFixture]
};

UserEntity secondUserFixture = UserEntity(
  id: 2,
  email: "some_user@test.com",
  username: "Second User",
  accounts: [secondAccountFixture]
);

Map<String,dynamic> secondUserAsJsonFixture = {
  "id": 2,
  "email": "second_user@test.com",
  "username": "Second User",
  "accounts": [secondAccountAsJsonFixture]
};