

import 'package:washee/features/account/data/models/web_user_model.dart';
import 'package:washee/features/account/domain/entities/account_entity.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';

class WebAccountModel extends AccountEntity {
  final int id;
  final String name;
  final double balance;
  final List<UserEntity> owners;

  WebAccountModel({
    required this.id,
    required this.name,
    required this.balance,
    required this.owners
  }) : super(
    id: id,
    name: name,
    balance: balance,
    owners: owners
  );

  Map<String, dynamic> toJson(){
    Map<String,dynamic> accountJson = {
      "id": id,
      "name": name,
      "balance": balance,
      "owners": WebUserModel.listToJson(owners)
    };
    return accountJson;
  }

  factory WebAccountModel.fromJson(Map<String,dynamic> account){
    WebAccountModel accountModel = WebAccountModel(
      id: account["id"], 
      name: account["name"],
      balance: account["balance"],
      owners: WebUserModel.listFromJson(account["owners"])
    );
    return accountModel;
  }

  static List<AccountEntity> listFromJson(List<dynamic>? accountListJson){
    List<AccountEntity> accountList = [];
    if (accountListJson == null){
      return accountList;
    }
    for(Map<String,dynamic> accountJson in accountListJson){
      accountList.add(WebAccountModel.fromJson(accountJson));
    }
    return accountList;
  }

  static List<Map<String,dynamic>> listToJson(List<AccountEntity>? accountList){
    List<Map<String,dynamic>> accountListJson = [];
    if(accountList == null){
      return accountListJson;
    }
    for(AccountEntity account in accountList){
      WebAccountModel accountModel = WebAccountModel(
        id: account.id, 
        name: account.name, 
        balance: account.balance, 
        owners: account.owners
      );
      accountListJson.add(accountModel.toJson());
    }
    return accountListJson;
  }
}