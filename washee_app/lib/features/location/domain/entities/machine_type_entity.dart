import 'package:equatable/equatable.dart';
import 'package:washee/features/location/domain/entities/service_entity.dart';

// ignore: must_be_immutable
class MachineTypeEntity extends Equatable {
  final int id;
  final String name;
  final List<ServiceEntity> services = [];

  MachineTypeEntity({
    required this.id,
    required this.name,
    services
  });

  @override
  List<Object?> get props => [id, name, services];
}
