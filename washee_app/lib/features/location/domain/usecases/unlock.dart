import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:washee/core/externalities/web/web_connector.dart';
import 'package:washee/core/standards/time/date_helper.dart';
import 'package:washee/core/standards/base_usecase/usecase.dart';
import 'package:washee/features/location/data/models/box_machine_model.dart';
import 'package:washee/features/location/data/repositories/unlock_repo.dart';
import 'package:washee/features/location/domain/usecases/disconnect_box_wifi.dart';
import 'package:washee/injection_container.dart';

class UnlockUseCase implements UseCase<MachineModel?, UnlockParams> {
  final UnlockRepository repository;

  UnlockUseCase({required this.repository});

  @override
  Future<MachineModel?> call(UnlockParams params) async {
    Duration duration = Duration(hours: 2, minutes: 30);
    if(params.machine.endTime != null){
      duration = params.machine.endTime!.difference(DateHelper().currentTime());
    }

    MachineModel? machine = await repository.unlock(params.machine, duration);

    await sl<DisconnectBoxWifiUsecase>().call(NoParams());

    if (machine != null){
      // Bad practice, should be severely reorganized, when we have a proper understanding of the domain structure
      // There is no strict seperation of Machine and Booking, giving these problems
      Future.delayed(Duration(seconds: 3), () async {
        Response response = await sl<WebConnector>().retrieve("api/1/bookings", queryParameters: {
            "machineID": int.parse(params.machine.machineID.toString()),
            "startTimeLessThan": DateHelper().currentTime(),
            "endTimeGreaterThan": DateHelper().currentTime()
      });
      List<Map<String,dynamic>> currentBooking = response.data;
        sl<WebConnector>().update("api/1/bookings/" + currentBooking[0]["id"].toString(), { "activated": true });
      });
    }
    
    return machine;
  }
}

class UnlockParams extends Equatable {
  final MachineModel machine;

  UnlockParams({required this.machine});

  @override
  List<Object?> get props => [machine];
}
