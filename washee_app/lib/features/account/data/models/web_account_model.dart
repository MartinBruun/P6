

import 'package:washee/features/account/data/models/web_user_model.dart';
import 'package:washee/features/account/domain/entities/account_entity.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';

// ignore: must_be_immutable
class WebAccountModel extends AccountEntity {
  final int id;
  final String name;
  final double balance;
  late List<UserEntity> owners;

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

  factory WebAccountModel.fromEntity(AccountEntity accountEntity){
    return WebAccountModel(
      id: accountEntity.id, 
      name: accountEntity.name,
      balance: accountEntity.balance,
      owners: accountEntity.owners
    );
  }

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
      WebAccountModel accountModel = WebAccountModel.fromJson(accountJson);
      // Flutter is incredibly stupid...
      // It is necessary to make this conversion, otherwise the function will return List<WebAccountModel> instead of List<AccountEntity>
      // EVEN THOUGH the List has been specified as being ONLY AccountEntity AND NOT WebAccountModel
      AccountEntity accountEntity = AccountEntity(id: accountModel.id, name: accountModel.name, balance: accountModel.balance, owners: accountModel.owners);
      accountList.add(accountEntity);
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