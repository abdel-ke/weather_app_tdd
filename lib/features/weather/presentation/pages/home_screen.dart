import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_tdd/features/weather/presentation/bloc/weather_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      debugPrint('state: $state');
      if (state is WeatherInitial) {
        return const Center(child: Text('Search for a city'));
      } else if (state is LoadedWeather) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('City: ${state.city.name}'),
              Text('Temperature: ${state.city.country}'),
              Text('Weather: ${state.city.admin1}'),
            ],
          ),
        );
      } else {
        return const Center(child: Text('Error'));
      }
    });
  }
}