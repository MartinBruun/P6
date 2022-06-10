import 'package:equatable/equatable.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';

// ignore: must_be_immutable
class AccountEntity extends Equatable {
  final int id;
  final String name;
  final double balance;
  final List<UserEntity> owners = [];

  AccountEntity({
    required this.id,
    required this.name,
    required this.balance,
    owners
  });

  @override
  List<Object?> get props => [id, name, balance,owners];
}
