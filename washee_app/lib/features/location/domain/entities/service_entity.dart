import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ServiceEntity extends Equatable {
  final int id;
  final String name;
  final int price_in_dk;
  final int duration_in_sec;

  ServiceEntity({
    required this.id,
    required this.name,
    required this.price_in_dk,
    required this.duration_in_sec
  });

  @override
  List<Object?> get props => [id, name, price_in_dk, duration_in_sec];
}
