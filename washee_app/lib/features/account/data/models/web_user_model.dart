import 'package:washee/features/account/data/models/web_account_model.dart';
import 'package:washee/features/account/domain/entities/account_entity.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';

// ignore: must_be_immutable
class WebUserModel extends UserEntity{
  final int id;
  final String email;
  final String username;
  AccountEntity? activeAccount;
  late List<AccountEntity> accounts;
  bool loggedIn;

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

  factory WebUserModel.fromEntity(UserEntity userEntity){
    return WebUserModel(
      id: userEntity.id, 
      email: userEntity.email, 
      username: userEntity.username, 
      accounts: userEntity.accounts,
      loggedIn: userEntity.loggedIn
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "email": email,
      "username": username,
      "accounts": WebAccountModel.listToJson(accounts)
    };
  }

  factory WebUserModel.fromJson(Map<String,dynamic> userJson){
    WebUserModel userModel = WebUserModel(
      id: userJson["id"], 
      email: userJson["email"], 
      username: userJson["username"], 
      accounts: WebAccountModel.listFromJson(userJson["accounts"]),
      loggedIn: false
    );
    return userModel;
  }

  static List<UserEntity> listFromJson(List<dynamic>? userListJson){   
    List<UserEntity> userList = [];
    if(userListJson == null){
      return userList;
    }
    for(Map<String,dynamic> userJson in userListJson){
      WebUserModel userModel = WebUserModel.fromJson(userJson);
      // Flutter is incredibly stupid...
      // It is necessary to make this conversion, otherwise the function will return List<WebUserModel> instead of List<AccountEntity>
      // EVEN THOUGH the List has been specified as being ONLY UserEntity AND NOT WebUserModel
      UserEntity userEntity = UserEntity(id: userModel.id, email: userModel.email, username: userModel.username, accounts: userModel.accounts, loggedIn: userModel.loggedIn);
      userList.add(userEntity);
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