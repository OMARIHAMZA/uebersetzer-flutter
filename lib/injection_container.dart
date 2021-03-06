import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:uebersetzer/core/database/database_helper.dart';
import 'package:uebersetzer/core/network/network_info.dart';
import 'package:uebersetzer/features/favorites/data/datasources/favorites_local_data_source.dart';
import 'package:uebersetzer/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:uebersetzer/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:uebersetzer/features/favorites/domain/usecases/add_favorite_usecase.dart';
import 'package:uebersetzer/features/favorites/domain/usecases/get_favorites_usecase.dart';
import 'package:uebersetzer/features/favorites/domain/usecases/remove_favorite_usecase.dart';
import 'package:uebersetzer/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:uebersetzer/features/history/data/datasources/history_local_datasource.dart';
import 'package:uebersetzer/features/history/data/repositories/search_history_repository_impl.dart';
import 'package:uebersetzer/features/history/domain/repositories/search_history_repository.dart';
import 'package:uebersetzer/features/history/domain/usecases/add_search_record_usecase.dart';
import 'package:uebersetzer/features/history/domain/usecases/clear_search_history_usecase.dart';
import 'package:uebersetzer/features/history/domain/usecases/delete_search_record_usecase.dart';
import 'package:uebersetzer/features/history/domain/usecases/get_search_history_usecase.dart';
import 'package:uebersetzer/features/history/presentation/bloc/search_history_bloc.dart';
import 'package:uebersetzer/features/search/data/datasources/search_local_data_source.dart';
import 'package:uebersetzer/features/search/data/repositories/search_repository_impl.dart';
import 'package:uebersetzer/features/search/domain/repositories/search_repository.dart';
import 'package:uebersetzer/features/search/domain/use_cases/search_for_words_usecase.dart';
import 'package:uebersetzer/features/search/presentation/bloc/search_bloc.dart';

final sl = GetIt.instance;

void init() {
  /// Features
  ///
  /// 1 - Search
  ///
  searchFeature();

  /// 2 - Favorites
  ///
  favoritesFeature();

  /// 3 - Search History
  ///
  historyFeature();
}

void searchFeature() {
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

void favoritesFeature() {
  sl.registerFactory(() => FavoritesBloc(
      getFavorites: sl(), addFavorite: sl(), removeFavorite: sl()));

  // UseCases
  sl.registerLazySingleton(() => GetFavoritesUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddFavoriteUseCase(repository: sl()));
  sl.registerLazySingleton(() => RemoveFavoriteUseCase(repository: sl()));

  // Repositories
  sl.registerLazySingleton<FavoritesRepository>(
      () => FavoritesRepositoryImpl(localDataSource: sl()));

  // DataSources
  sl.registerLazySingleton<FavoritesLocalDataSource>(
      () => FavoritesLocalDataSourceImpl(databaseHelper: sl()));
}

void historyFeature() {
  // Features - History
  sl.registerFactory(
    () => SearchHistoryBloc(
        getSearchHistoryUseCase: sl(),
        addSearchRecordUseCase: sl(),
        deleteSearchRecordUseCase: sl(),
        clearSearchHistoryUseCase: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetSearchHistoryUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddSearchRecordUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteSearchRecordUseCase(repository: sl()));
  sl.registerLazySingleton(() => ClearSearchHistoryUseCase(repository: sl()));

  // Repositories
  sl.registerLazySingleton<SearchHistoryRepository>(
      () => SearchHistoryRepositoryImpl(localDataSource: sl()));

  // DataSources
  sl.registerLazySingleton<HistoryLocalDataSource>(
      () => HistoryLocalDataSourceImpl(databaseHelper: sl()));
}
