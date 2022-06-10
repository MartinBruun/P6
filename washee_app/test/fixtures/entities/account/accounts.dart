import 'package:washee/features/account/domain/entities/account_entity.dart';

AccountEntity firstAccountFixture(){
  return AccountEntity(
    id: 1,
    name: "First Account",
    balance: 100.0,
    owners: []
  );
}  

Map<String,dynamic> firstAccountAsJsonFixture(){
  return {
    "id": 1,
    "name": "First Account",
    "balance": 100.0,
    "owners": []
  };
} 

AccountEntity secondAccountFixture(){
  return AccountEntity(
    id: 2,
    name: "Second Account",
    balance: 100.0,
    owners: []
  );
} 

Map<String,dynamic> secondAccountAsJsonFixture(){
  return {
    "id": 2,
    "name": "Second Account",
    "balance": 100.0,
    "owners": []
  };
} 