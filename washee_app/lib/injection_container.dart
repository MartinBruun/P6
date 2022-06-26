import 'dart:io' show Platform;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:washee/core/externalities/box/box_communicator.dart';
import 'package:washee/core/externalities/web/web_connector.dart';
import 'package:washee/core/standards/environments/environment.dart';
import 'package:washee/features/account/data/datasources/account_remote.dart';
import 'package:washee/features/account/data/datasources/user_remote.dart';
import 'package:washee/features/account/data/repositories/account_repository_impl.dart';
import 'package:washee/features/account/data/repositories/user_repository.dart';
import 'package:washee/features/account/domain/usecases/auto_sign_in.dart';
import 'package:washee/features/account/domain/usecases/sign_out.dart';
import 'package:washee/features/account/presentation/providers/account_language_provider.dart';
import 'package:washee/features/account/presentation/providers/account_current_user_provider.dart';
import 'package:washee/features/booking/data/datasources/book_remote.dart';
import 'package:washee/features/booking/data/repositories/book_repository_impl.dart';
import 'package:washee/features/booking/domain/usecases/delete_booking.dart';
import 'package:washee/features/booking/domain/usecases/has_current_booking.dart';
import 'package:washee/features/booking/domain/usecases/post_booking.dart';
import 'package:washee/features/location/data/repositories/get_machines_repo_impl.dart';
import 'package:washee/features/location/domain/repositories/get_machines_repository.dart';
import 'package:washee/features/location/domain/usecases/get_machines.dart';
import 'package:washee/features/account/domain/usecases/sign_in.dart';
import 'package:washee/features/location/data/datasources/unlock_remote.dart';
import 'package:washee/features/location/data/repositories/unlock_repo_impl.dart';
import 'package:washee/features/location/domain/repositories/unlock_repository.dart';
import 'package:washee/features/location/domain/usecases/connect_box_wifi.dart';
import 'package:washee/features/location/domain/usecases/disconnect_box_wifi.dart';
import 'package:washee/features/location/domain/usecases/get_wifi_permission.dart';
import 'package:washee/features/location/domain/usecases/unlock.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:washee/core/externalities/network/network_info.dart';
import 'package:washee/features/booking/domain/usecases/get_bookings.dart';

// sl is short for service locater
final GetIt sl = GetIt.instance;

Future<void> initAll() async {
  await initCore();
  await initCoreAndExternal();
  await initAccount();
  await initUnlock();
  await initGetMachines();
  
  await initBooking();
}

Future<void> initCore() async {
  sl.registerLazySingleton<Environment>(() => Environment());
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());
  sl.registerLazySingleton<IWebConnector>(() => WebConnector(httpConnection: sl(), secureStorage: sl(), environment: sl()));
}

Future<void> initAccount() async {
  // Data Sources
  sl.registerLazySingleton<IWebAccountRemote>(() => WebAccountRemote(webConnector: sl()));
  sl.registerLazySingleton<IWebUserRemote>(() => WebUserRemote(webConnector: sl()));

  // Repositories
  sl.registerLazySingleton<IUserRepository>(() => UserRepository(userRemote: sl()));
  sl.registerLazySingleton<IAccountRepository>(() => AccountRepository(accountRemote: sl()));

  // Usecases
  sl.registerLazySingleton<AutoSignInUsecase>(() => AutoSignInUsecase(userRepository: sl()));
  sl.registerLazySingleton<SignInUseCase>(() => SignInUseCase(userRepository: sl()));
  sl.registerLazySingleton<SignOutUsecase>(() => SignOutUsecase(userRepository: sl()));

  // Providers
  sl.registerLazySingleton<AccountCurrentUserProvider>(() => AccountCurrentUserProvider(autoSignInUsecase: sl(), signInUsecase: sl(), signOutUsecase: sl()));
  sl.registerLazySingleton<AccountLanguageProvider>(() => AccountLanguageProvider());
}


// EVERYTHING BELOW HERE IS OLD and should be moved to the top structure
Future<void> initCoreAndExternal() async {
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton<BoxCommunicator>(() => BoxCommunicatorImpl(dio: sl()));
}

Future<void> initBooking() async {
  // Usecases
  sl.registerLazySingleton(() => PostBookingUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetBookingsUseCase(repository: sl()));
  sl.registerLazySingleton(() => HasCurrentBookingUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteBookingUseCase(repository: sl()));

  // Repositories
  sl.registerLazySingleton<BookRepositoryImpl>(() => BookRepositoryImpl(networkInfo: sl(), remote: sl()));

  // Data Sources
  sl.registerLazySingleton<BookRemote>(() => BookRemoteImpl(networkInfo: sl(), connector: sl()));
}

Future<void> initUnlock() async {
  // Data sources
  sl.registerLazySingleton<UnlockRemote>(
      () => UnlockRemoteImpl(communicator: sl()));

  // Repositories
  sl.registerLazySingleton<UnlockRepository>(
      () => UnlockRepositoryImpl(remote: sl(), networkInfo: sl()));

  // Usecases
  sl.registerLazySingleton(() => UnlockUseCase(repository: sl()));
  if (Platform.isAndroid) {
    sl.registerLazySingleton(() => GetWifiPermissionUsecase(repository: sl()));
  }
  sl.registerLazySingleton(() => ConnectBoxWifiUsecase(repository: sl()));
  sl.registerLazySingleton(() => DisconnectBoxWifiUsecase(repository: sl()));
}

Future<void> initGetMachines() async {
  // Usecases
  sl.registerLazySingleton(() => GetMachinesUseCase(repository: sl()));

  // Repositories
  sl.registerLazySingleton<GetMachinesRepository>(
      () => GetMachinesRepositoryImpl(connector: sl(), networkInfo: sl()));
}