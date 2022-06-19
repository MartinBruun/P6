import 'package:washee/features/account/data/models/web_account_model.dart';
import 'package:washee/features/account/domain/entities/account_entity.dart';

// REMOVE THIS AFTER MIGRATING EVERYWHERE ELSE TO THE NEW STRUCTURE!
// This method breaks the architechture by being an Entity, Model, Provider and Repository all in one!

class ActiveUser {
  bool _loggedIn = false;
  int? _id;
  String? _email;
  String? _username;
  AccountEntity? _activeAccount;
  List<AccountEntity> _accounts = [];

  bool get loggedIn => _loggedIn;
  int? get id => _id;
  String? get email => _email;
  String? get username => _username;
  //get accounts => _accounts;
  AccountEntity? get activeAccount => _activeAccount;

  factory ActiveUser() {
    return _singleton;
  }

  static ActiveUser _singleton = ActiveUser._internal();

  ActiveUser._internal();

  void initUser(int id, String email, String username, List<dynamic> accounts) {
    _id = id;
    _email = email;
    _username = username;
    _accounts =
        List<AccountEntity>.from(accounts.map((model) => WebAccountModel.fromJson(model)));
    _activeAccount = _accounts[0];
    _loggedIn = true;
  }

  void logOut() {
    _id = null;
    _email = null;
    _username = null;
    _activeAccount = null;
    _accounts = [];
    _loggedIn = false;
  }

  void upDateAccount(AccountEntity account) {
    this._activeAccount = account;
  }

  Map<String, dynamic> toJson() => {
        'id': _id,
        'email': _email,
        'username': _username,
        'accounts': List<AccountEntity>.of(_accounts)
      };

  factory ActiveUser.fromJson(Map<String, dynamic> json) {
    _singleton._id = int.parse(json["id"]);
    _singleton._email = json["email"];
    _singleton._username = json['username'];
    _singleton._accounts = List<AccountEntity>.from(
        json["accounts"].map((model) => WebAccountModel.fromJson(model)));
    return _singleton;
  }
}
