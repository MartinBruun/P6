import 'package:washee/features/account/domain/entities/account_entity.dart';

AccountEntity firstAccount = AccountEntity(
  id: 1,
  name: "First Account",
  balance: 100
);

Map<String,dynamic> firstAccountAsJson = {
  "id": 1,
  "name": "First Account",
  "balance": 100
};

AccountEntity secondAccount = AccountEntity(
  id: 2,
  name: "Second Account",
  balance: 100
);

Map<String,dynamic> secondAccountAsJson = {
  "id": 2,
  "name": "Second Account",
  "balance": 100
};