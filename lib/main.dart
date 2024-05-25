import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_tdd/core/network/network_info.dart';
import 'package:weather_app_tdd/features/weather/data/datasources/weather_local_datasource.dart';
import 'package:weather_app_tdd/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:weather_app_tdd/features/weather/data/repositories/weather_repository.dart';
// import 'package:weather_app_tdd/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app_tdd/features/weather/domain/usecases/weather_usecase.dart';
import 'package:weather_app_tdd/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app_tdd/features/weather/presentation/pages/home_screen.dart';
// import 'injection_container.dart' as di;
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // di.init();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  runApp(MainApp(
    sharedPreferences: sharedPreferences,
  ));
}

class MainApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  const MainApp({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (_) => WeatherBloc(weatherUsecase: di.sl())),
        BlocProvider(
          create: (_) => WeatherBloc(
            weatherUsecase: WeatherUsecase(
              WeatherRepositoryImpl(
                remoteDataSource:
                    WeatherRemoteDatasourceImpl(client: http.Client()),
                networkInfo: NetworkInfoImpl(InternetConnectionChecker()),
                localDataSource: WeatherLocalDatasourceImpl(
                    sharedPreferences: sharedPreferences),
              ),
            ),
          ),
        ),
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: HomeScreen(),
          ),
        ),
      ),
    );
  }
}
