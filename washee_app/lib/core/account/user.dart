import 'package:washee/core/account/account.dart';

class User {
  bool _loggedIn = false; 
  int? _id;
  String? _email;
  String? _username;
  List<Account> _accounts = [];

  get loggedIn => _loggedIn;
  get id => _id;
  get email => _email;
  get username => _username;
  get accounts => _accounts;

  factory User() {
    return _singleton;
  }

  static User _singleton = User._internal();

  User._internal();

  void initUser(int id, String email, String username, List<Account> accounts) {
    _id = id;
    _email = email;
    _username = username;
    _accounts = accounts;
    _loggedIn = true;
  }

  void logOut() {
    _id = null;
    _email = null;
    _username = null;
    _accounts = [];
    _loggedIn = false;
  }

  Map<String, dynamic> toJson() => {
    'id': _id,
    'email': _email,
    'username': _username,
    'accounts': List<Account>.of(_accounts)
  };

  factory User.fromJson(Map<String, dynamic> json) {
      _singleton._id = int.parse(json["id"]);
      _singleton._email = json["email"];
      _singleton._username = json['username'];
      _singleton._accounts = List<Account>.from(json["accounts"].map((model) => Account.fromJson(model)));
      return _singleton;
  }
}