import 'package:equatable/equatable.dart';

class Payment extends Equatable {
  final String name;
  final DateTime timeOfTransaction;
  final double amount;
  final int paymentID;

  Payment(
      {required this.name,
      required this.timeOfTransaction,
      required this.amount,
      required this.paymentID});

  @override
  List<Object?> get props => [name, timeOfTransaction, amount, paymentID];
}
