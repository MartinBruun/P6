import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:washee/core/helpers/box_communicator.dart';
import 'package:washee/features/booking/data/datasources/book_remote.dart';
import 'package:washee/features/booking/data/repositories/book_repository_impl.dart';
import 'package:washee/features/booking/domain/usecases/book.dart';
import 'package:washee/features/unlock/data/datasources/unlock_remote.dart';
import 'package:washee/features/unlock/data/repositories/unlock_repo_impl.dart';
import 'package:washee/features/unlock/domain/repositories/unlock_repository.dart';
import 'package:washee/features/unlock/domain/usecases/unlock.dart';

import 'core/network/network_info.dart';
import 'features/booking/domain/repositories/book_repository.dart';

final GetIt sl = GetIt.instance;

void initAll() {}

void initBooking() {
  // Usecases
  sl.registerLazySingleton(() => BookUseCase(repository: sl()));

  // Repositories
  sl.registerLazySingleton<BookRepository>(
    () => BookRepositoryImpl(networkInfo: sl(), remote: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<BookRemote>(
    () => BookLaundryRemoteImpl(client: sl()),
  );

  // Core & External
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
}

void initUnlock() {
  // Usecases
  sl.registerLazySingleton(() => UnlockUseCase(repository: sl()));

  // Repositories
  sl.registerLazySingleton<UnlockRepository>(
      () => UnlockRepositoryImpl(remote: sl(), networkInfo: sl()));

  // Data sources
  sl.registerLazySingleton<UnlockRemote>(
      () => UnlockRemoteImpl(communicator: sl()));

  // Core & External
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton<BoxCommunicator>(
      () => BoxCommunicatorImpl(dio: sl()));
  sl.registerLazySingleton(() => Dio());
}
