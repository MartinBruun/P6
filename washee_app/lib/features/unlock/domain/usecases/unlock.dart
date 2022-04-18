import 'package:equatable/equatable.dart';
import 'package:washee/core/helpers/date_helper.dart';
import 'package:washee/core/helpers/web_communicator.dart';
import 'package:washee/core/usecases/usecase.dart';
import 'package:washee/core/washee_box/machine_model.dart';
import 'package:washee/features/unlock/domain/usecases/connect_box_wifi.dart';
import 'package:washee/features/unlock/domain/usecases/disconnect_box_wifi.dart';
import 'package:washee/injection_container.dart';

import 'package:washee/core/errors/exception_handler.dart';
import '../repositories/unlock_repository.dart';

class UnlockUseCase implements UseCase<MachineModel?, UnlockParams> {
  final UnlockRepository repository;

  UnlockUseCase({required this.repository});

  @override
  Future<MachineModel?> call(UnlockParams params) async {
    DateTime endTime = DateHelper.currentTime().add(Duration(hours: 2, minutes: 30));
    try {
      List<Map<String,dynamic>> currentBooking = await sl<WebCommunicator>().getCurrentBookings(
        machineID: int.parse(params.machine.machineID),
        startTimeLessThan: DateHelper.currentTime(),
        endTimeGreaterThan: DateHelper.currentTime()
      );
      if (currentBooking.isNotEmpty){
        endTime = DateTime.parse(currentBooking[0]["end_time"]);
        print("GOT ENDTIME: " + endTime.toString());
      }
      else{
        ExceptionHandler().handle("BIG ERROR! No Booking is active for this time! " + DateHelper.currentTime().toString(),log:true, show:true);
      }
    }
    catch (e){
      ExceptionHandler().handle("Could not get booking time, defaulting to 2 hours and 30 minutes",log:true, show:true);
    }
    Duration duration = endTime.difference(DateHelper.currentTime().toUtc().add(Duration(hours:2)));
    print("DURATION DIFFERENCE: " + duration.toString());

    await sl<ConnectBoxWifiUsecase>().call(NoParams());
    MachineModel? machine = await repository.unlock(params.machine, duration);
    sl<DisconnectBoxWifiUsecase>().call(NoParams());
    return machine;
  }
}

class UnlockParams extends Equatable {
  final MachineModel machine;

  UnlockParams({required this.machine});

  @override
  List<Object?> get props => [machine];
}
