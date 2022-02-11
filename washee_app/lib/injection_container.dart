import 'package:connectivity/connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:washee/features/booking/data/datasources/book_laundry_remote.dart';
import 'package:washee/features/booking/data/repositories/book_laundry_repository_impl.dart';
import 'package:washee/features/booking/domain/usecases/book_laundry.dart';

import 'core/network/network_info.dart';
import 'features/booking/domain/repositories/book_laundry_repository.dart';

final GetIt sl = GetIt.instance;

void initAll() {}

void initBookingLaundry() {
  // Usecases
  sl.registerLazySingleton(() => BookLaundryUseCase(repository: sl()));

  // Repositories
  sl.registerLazySingleton<BookLaundryRepository>(
    () => BookLaundryRepositoryImpl(networkInfo: sl(), remote: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<BookLaundryRemote>(
    () => BookLaundryRemoteImpl(client: sl()),
  );

  // Core & External
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
}
