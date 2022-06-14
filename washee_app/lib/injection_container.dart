import 'dart:io' show Platform;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:washee/core/externalities/web/authorizer.dart';
import 'package:washee/core/externalities/web/web_communicator.dart';
import 'package:washee/core/externalities/box/box_communicator.dart';
import 'package:washee/core/externalities/web/web_connector.dart';
import 'package:washee/features/account/data/datasources/account_remote.dart';
import 'package:washee/features/account/data/datasources/user_remote.dart';
import 'package:washee/features/account/data/repositories/account_repository_impl.dart';
import 'package:washee/features/account/data/repositories/user_repository.dart';
import 'package:washee/features/booking/data/datasources/book_remote.dart';
import 'package:washee/features/booking/data/repositories/book_repository_impl.dart';
import 'package:washee/features/booking/domain/usecases/delete_booking.dart';
import 'package:washee/features/booking/domain/usecases/has_current_booking.dart';
import 'package:washee/features/booking/domain/usecases/post_booking.dart';
import 'package:washee/features/location/data/repositories/get_machines_repo_impl.dart';
import 'package:washee/features/location/domain/repositories/get_machines_repository.dart';
import 'package:washee/features/location/domain/usecases/get_machines.dart';
import 'package:washee/features/account/domain/usecases/sign_in.dart';
import 'package:washee/features/account/domain/usecases/update_account.dart';
import 'package:washee/features/location/data/datasources/unlock_remote.dart';
import 'package:washee/features/location/data/repositories/unlock_repo_impl.dart';
import 'package:washee/features/location/domain/repositories/unlock_repository.dart';
import 'package:washee/features/location/domain/usecases/connect_box_wifi.dart';
import 'package:washee/features/location/domain/usecases/disconnect_box_wifi.dart';
import 'package:washee/features/location/domain/usecases/get_wifi_permission.dart';
import 'package:washee/features/location/domain/usecases/unlock.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'core/externalities/network/network_info.dart';
import 'features/booking/domain/repositories/book_repository.dart';
import 'features/booking/domain/usecases/get_bookings.dart';

// sl is short for service locater
final GetIt sl = GetIt.instance;

void initAll() {
  initCore();
  initCoreAndExternal();
  initAccount();
  initUnlock();
  initGetMachines();
  
  initBooking();
}

initCore(){
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());
  sl.registerLazySingleton<WebConnector>(() => WebConnector(httpCon: sl(), secStorage: sl()));
}

// OLD should be moved to initCore
initCoreAndExternal() {
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());

  sl.registerLazySingleton<BoxCommunicator>(
      () => BoxCommunicatorImpl(dio: sl()));
  

  sl.registerLazySingleton<Authorizer>(() => AuthorizerImpl(dio: sl()));

  sl.registerLazySingleton<WebCommunicator>(
      () => WebCommunicatorImpl(dio: sl(), authorizer: sl()));
}

void initBooking() {
  // Usecases
  sl.registerLazySingleton(() => PostBookingUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetBookingsUseCase(repository: sl()));
  sl.registerLazySingleton(() => HasCurrentBookingUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteBookingUseCase(repository: sl()));

  // Repositories
  sl.registerLazySingleton<BookRepository>(
    () => BookRepositoryImpl(networkInfo: sl(), remote: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<BookRemote>(
    () => BookRemoteImpl(networkInfo: sl(), communicator: sl()),
  );
}

void initUnlock() {
  // Usecases
  sl.registerLazySingleton(() => UnlockUseCase(repository: sl()));
  if (Platform.isAndroid) {
    sl.registerLazySingleton(() => GetWifiPermissionUsecase(repository: sl()));
  }
  sl.registerLazySingleton(() => ConnectBoxWifiUsecase(repository: sl()));
  sl.registerLazySingleton(() => DisconnectBoxWifiUsecase(repository: sl()));

  // Repositories
  sl.registerLazySingleton<UnlockRepository>(
      () => UnlockRepositoryImpl(remote: sl(), networkInfo: sl()));

  // Data sources
  sl.registerLazySingleton<UnlockRemote>(
      () => UnlockRemoteImpl(communicator: sl()));
}

void initGetMachines() {
  // Usecases
  sl.registerLazySingleton(() => GetMachinesUseCase(repository: sl()));

  // Repositories
  sl.registerLazySingleton<GetMachinesRepository>(
      () => GetMachinesRepositoryImpl(communicator: sl(), networkInfo: sl()));
}

void initAccount() {
  // Usecases
  sl.registerLazySingleton<SignInUseCase>(() => SignInUseCase(userRepository: sl()));
  sl.registerLazySingleton<UpdateAccountUseCase>(() => UpdateAccountUseCase(userRepository: sl(), accountRepository: sl()));

  // Repositories
  sl.registerLazySingleton<IUserRepository>(
      () => UserRepository(webRemote: sl()));
  sl.registerLazySingleton<IAccountRepository>(
      () => AccountRepository(accountRemote: sl()));

  // Data Sources
  sl.registerLazySingleton<WebAccountRemote>(() => WebAccountRemote(webConnector: sl()));
  sl.registerLazySingleton<WebUserRemote>(() => WebUserRemote(webConnector: sl()));
}
