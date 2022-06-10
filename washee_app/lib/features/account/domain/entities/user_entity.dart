import 'package:equatable/equatable.dart';
import 'package:washee/features/account/domain/entities/account_entity.dart';

// ignore: must_be_immutable
class UserEntity extends Equatable {
  final int id;
  final String email;
  final String username;
  AccountEntity? activeAccount;
  late List<AccountEntity> accounts = [];
  late bool loggedIn;

  UserEntity({
    required this.id,
    required this.email,
    required this.username,
    activeAccount,
    accounts,
    loggedIn: false
  });

  @override
  List<Object?> get props => [id, email, username, activeAccount, accounts, ];
}
