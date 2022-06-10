import 'package:washee/features/account/domain/entities/account_entity.dart';

import 'users.dart';

AccountEntity firstAccountFixture = AccountEntity(
  id: 1,
  name: "First Account",
  balance: 100.0,
  owners: [firstUserFixture]
);

Map<String,dynamic> firstAccountAsJsonFixture = {
  "id": 1,
  "name": "First Account",
  "balance": 100.0,
  "owners": [firstUserAsJsonFixture]
};

AccountEntity secondAccountFixture = AccountEntity(
  id: 2,
  name: "Second Account",
  balance: 100.0,
  owners: [secondUserFixture]
);

Map<String,dynamic> secondAccountAsJsonFixture = {
  "id": 2,
  "name": "Second Account",
  "balance": 100.0,
  "owners": [secondUserAsJsonFixture]
};