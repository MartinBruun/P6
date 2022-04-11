import 'package:equatable/equatable.dart';
import 'package:washee/core/account/account.dart';

class User extends Equatable {
  final int id;
  final String email;
  final String userName;
  final List<Account> accounts;

  User({required this.id, required this.email, required this.userName, this.accounts: const []});

  @override
  List<Object?> get props => [email, userName, accounts];

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'username': userName,
    'accounts': List<Account>.of(accounts)
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: int.parse(json["id"]),
      email: json["email"],
      userName: json['username'],
      accounts: List<Account>.from(json["accounts"].map((model) => Account.fromJson(model)))
    );
  }
}