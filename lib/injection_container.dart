import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:uebersetzer/core/database/database_helper.dart';
import 'package:uebersetzer/core/network/network_info.dart';
import 'package:uebersetzer/features/search/data/datasources/search_local_data_source.dart';
import 'package:uebersetzer/features/search/data/repositories/search_repository_impl.dart';
import 'package:uebersetzer/features/search/domain/repositories/search_repository.dart';
import 'package:uebersetzer/features/search/domain/use_cases/search_for_words_usecase.dart';
import 'package:uebersetzer/features/search/presentation/bloc/search_bloc.dart';

final sl = GetIt.instance;

void init() {
  // Features - Search
  sl.registerFactory(() => SearchBloc(searchForWordsUseCase: sl()));

  // Use Cases
  sl.registerLazySingleton(() => SearchForWordsUseCase(searchRepository: sl()));

  //Repositories
  sl.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(localDataSource: sl(), databaseHelper: sl()));

  // Data Sources
  sl.registerLazySingleton<SearchLocalDataSource>(
      () => SearchLocalDataSourceImpl());
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelperImpl.instance);

  // Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(dataConnectionChecker: sl()));

  // External
  sl.registerLazySingleton(() => DataConnectionChecker());
}
