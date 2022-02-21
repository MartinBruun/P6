import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:washee/features/booking/data/datasources/book_remote.dart';
import 'package:washee/features/booking/data/repositories/book_repository_impl.dart';
import 'package:washee/features/booking/domain/usecases/book.dart';

import 'core/network/network_info.dart';
import 'features/booking/domain/repositories/book_repository.dart';

final GetIt sl = GetIt.instance;

void initAll() {}

void initBookingLaundry() {
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
