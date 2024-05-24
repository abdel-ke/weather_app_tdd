import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_tdd/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app_tdd/features/weather/presentation/pages/home_screen.dart';
import 'injection_container.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => WeatherBloc(weatherUsecase: di.sl())),
        ],
        child: const MaterialApp(
          home: Scaffold(body: SafeArea(child: HomeScreen())),
        ));
  }
}
