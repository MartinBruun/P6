import 'dart:io' show Platform;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:washee/core/helpers/authorizer.dart';
import 'package:washee/core/helpers/web_communicator.dart';
import 'package:washee/core/helpers/box_communicator.dart';
import 'package:washee/features/booking/data/datasources/book_remote.dart';
import 'package:washee/features/booking/data/repositories/book_repository_impl.dart';
import 'package:washee/features/booking/domain/usecases/delete_booking.dart';
import 'package:washee/features/booking/domain/usecases/has_current_booking.dart';
import 'package:washee/features/booking/domain/usecases/post_booking.dart';
import 'package:washee/features/get_machines/data/repositories/get_machines_repo_impl.dart';
import 'package:washee/features/get_machines/domain/repositories/get_machines_repository.dart';
import 'package:washee/features/get_machines/domain/usecases/get_machines.dart';
import 'package:washee/features/sign_in/data/repositories/sign_in_repo_impl.dart';
import 'package:washee/features/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:washee/features/sign_in/domain/usecases/sign_in.dart';
import 'package:washee/features/sign_in/domain/usecases/update_account.dart';
import 'package:washee/features/unlock/data/datasources/unlock_remote.dart';
import 'package:washee/features/unlock/data/repositories/unlock_repo_impl.dart';
import 'package:washee/features/unlock/domain/repositories/unlock_repository.dart';
import 'package:washee/features/unlock/domain/usecases/connect_box_wifi.dart';
import 'package:washee/features/unlock/domain/usecases/disconnect_box_wifi.dart';
import 'package:washee/features/unlock/domain/usecases/get_wifi_permission.dart';
import 'package:washee/features/unlock/domain/usecases/unlock.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'core/network/network_info.dart';
import 'features/booking/domain/repositories/book_repository.dart';
import 'features/booking/domain/usecases/get_bookings.dart';

// sl is short for service locater
final GetIt sl = GetIt.instance;

void initAll() {
  initCoreAndExternal();
  initUnlock();
  initGetMachines();
  initSignIn();
  initBooking();
}

initCoreAndExternal() {
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());

  sl.registerLazySingleton<BoxCommunicator>(
      () => BoxCommunicatorImpl(dio: sl()));
  sl.registerLazySingleton(() => Dio());

  sl.registerLazySingleton(() => FlutterSecureStorage());
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
  String os = Platform.operatingSystem;
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

void initSignIn() {
  // Usecases
  sl.registerLazySingleton(() => SignInUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateAccountUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<SignInRepository>(
      () => SignInRepositoryImpl(authorizer: sl(), communicator: sl()));
}
