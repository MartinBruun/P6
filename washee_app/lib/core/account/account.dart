import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final int id;
  final String name;
  final double balance;

  Account({required this.id, required this.name, required this.balance});

  @override
  List<Object?> get props => [id, name, balance];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'balance': balance,
  };

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['account_id'],
      name: json['name'],
      balance: json['balance'],
    );
  }
}