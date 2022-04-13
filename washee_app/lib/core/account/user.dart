import 'package:washee/core/account/account.dart';

class ActiveUser {
  bool _loggedIn = false; 
  int? _id;
  String? _email;
  String? _username;
  Account? _account;
  List<Account> _accounts = [];

  bool get loggedIn => _loggedIn;
  int? get id => _id;
  String? get email => _email;
  String? get username => _username;
  //get accounts => _accounts;
  Account? get account => _account;

  factory ActiveUser() {
    return _singleton;
  }

  static ActiveUser _singleton = ActiveUser._internal();

  ActiveUser._internal();

  void initUser(int id, String email, String username, Account account) {
    _id = id;
    _email = email;
    _username = username;
    _account = account;
    _loggedIn = true;
  }

  void logOut() {
    _id = null;
    _email = null;
    _username = null;
    _account = null;
    _loggedIn = false;
  }

  Map<String, dynamic> toJson() => {
    'id': _id,
    'email': _email,
    'username': _username,
    'accounts': List<Account>.of(_accounts)
  };

  factory ActiveUser.fromJson(Map<String, dynamic> json) {
      _singleton._id = int.parse(json["id"]);
      _singleton._email = json["email"];
      _singleton._username = json['username'];
      _singleton._accounts = List<Account>.from(json["accounts"].map((model) => Account.fromJson(model)));
      return _singleton;
  }
}