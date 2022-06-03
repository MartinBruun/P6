import 'package:equatable/equatable.dart';
import 'package:washee/features/location/domain/entities/machine_entity.dart';

// ignore: must_be_immutable
class LocationEntity extends Equatable {
  final int id;
  final String name;
  final List<MachineEntity> machines = [];

  LocationEntity({
    required this.id,
    required this.name,
    machines
  });

  @override
  List<Object?> get props => [id, name, machines];
}
