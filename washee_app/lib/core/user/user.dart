import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userName;
  int washCoupon;
  int token;

  User({required this.userName, required this.washCoupon, required this.token});

  @override
  List<Object?> get props => [userName, washCoupon, token];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['userName'],
      washCoupon: int.parse(json['washCoupon']),
      token: int.parse(json['token']),
    );
  }
}
