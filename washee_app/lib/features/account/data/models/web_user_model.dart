import 'package:washee/features/account/data/models/web_account_model.dart';
import 'package:washee/features/account/domain/entities/account_entity.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';

class WebUserModel extends UserEntity{
  final int id;
  final String email;
  final String username;
  AccountEntity? activeAccount;
  late List<AccountEntity> accounts;
  late bool loggedIn;

  WebUserModel({
    required this.id,
    required this.email,
    required this.username,
    this.activeAccount,
    required this.accounts,
    required this.loggedIn
  }) : super(
    id: id,
    email: email,
    username: username,
    activeAccount: activeAccount,
    accounts: accounts,
    loggedIn: loggedIn 
  );

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "email": email,
      "username": username,
      "accounts": WebAccountModel.listToJson(accounts)
    };
  }

  factory WebUserModel.fromJson(Map<String,dynamic> account){
    WebUserModel userModel = WebUserModel(
      id: account["id"], 
      email: account["email"], 
      username: account["username"], 
      accounts: [],
      loggedIn: false
    );
    userModel.accounts = WebAccountModel.listFromJson(account["accounts"]);

    return userModel;
  }

  static List<UserEntity> listFromJson(List<dynamic>? userListJson, {AccountEntity? accountAlreadySerialized: null}){
    List<WebUserModel> userList = [];
    if(userListJson == null){
      return userList;
    }
    for(Map<String,dynamic> userJson in userListJson){
      userList.add(WebUserModel.fromJson(userJson));
    }
    return userList;
  }

  static List<Map<String,dynamic>> listToJson(List<UserEntity>? userList){
    List<Map<String,dynamic>> userListJson = [];
    if(userList == null){
      return userListJson;
    }
    for(UserEntity user in userList){
      WebUserModel userModel = WebUserModel(
        id: user.id, 
        email: user.email, 
        username: user.username, 
        accounts: user.accounts, 
        loggedIn: user.loggedIn
      );
      userListJson.add(userModel.toJson());
    }
    return userListJson;
  }
}