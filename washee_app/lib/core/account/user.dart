import 'package:equatable/equatable.dart';
import 'package:washee/core/account/account.dart';

class User extends Equatable {
  final int id;
  final String email;
  final String userName;
  final List<String> accounts; // This should be made into an Account model instead. Maybe auto-fetching when a URL is passed?

  User({required this.id, required this.email, required this.userName, this.accounts: const []});

  @override
  List<Object?> get props => [email, userName, accounts];

  Map<String, dynamic> toJson() => {
    'id': id.toString(),
    'email': email,
    'username': userName,
    'accounts': List<String>.of(accounts)
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      email: json["email"],
      userName: json['username'],
      accounts: List<String>.from(json["accounts"].map((url) => url))
    );
  }
}