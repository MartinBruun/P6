import 'package:washee/features/location/domain/entities/service_entity.dart';

ServiceEntity firstServiceFixture(){
  return ServiceEntity(id: 1, name: "First Service", price_in_dk: 10, duration_in_sec: 100);
}

ServiceEntity secondServiceFixture(){
  return ServiceEntity(id: 2, name: "Second Service", price_in_dk: 10, duration_in_sec: 100);
}