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
  // UseCases
  sl.registerLazySingleton(() => WeatherUsecase(sl()));

  // datasources
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => WeatherRemoteDatasourceImpl(client: sl()));
  sl.registerLazySingleton(
      () => WeatherLocalDatasourceImpl(sharedPreferences: sl()));



  // bloc
  sl.registerFactory(() => WeatherBloc(weatherUsecase: sl()));

  // ! Core
  sl.registerLazySingleton(() => NetworkInfoImpl(sl()));

  // external
    // repositories
  sl.registerLazySingleton(() => WeatherRepository);
  sl.registerLazySingleton(() => WeatherRepositoryImpl(
      remoteDataSource: sl(), networkInfo: sl(), localDataSource: sl()));
}
