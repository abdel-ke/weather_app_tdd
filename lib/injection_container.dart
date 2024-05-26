import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_tdd/core/network/network_info.dart';
import 'package:weather_app_tdd/features/weather/data/datasources/weather_local_datasource.dart';
import 'package:weather_app_tdd/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:weather_app_tdd/features/weather/data/repositories/weather_repository.dart';
import 'package:weather_app_tdd/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app_tdd/features/weather/domain/usecases/weather_usecase.dart';
import 'package:weather_app_tdd/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //! features - posts
  // Bloc
  sl.registerFactory(() => WeatherBloc(weatherUsecase: sl()));

  // Usecases
  sl.registerLazySingleton(() => WeatherUsecase(sl()));

  // Repositories
  sl.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(
      localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()));

  // Datasources
  sl.registerLazySingleton(
      () => WeatherLocalDatasourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => WeatherRemoteDatasourceImpl(client: sl()));

  //! Core
  // Netwprl info
  sl.registerLazySingleton(() => NetworkInfoImpl(sl()));

  //! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
 