import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_tdd/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app_tdd/features/weather/presentation/pages/loaded_cities_page.dart';
import 'package:weather_app_tdd/features/weather/presentation/pages/search_city_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // i want when i switch to the loaded weather page, i can back to the search city page

    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      debugPrint('state: $state');
      if (state is WeatherInitial) {
        return const SearchCityPage();
      } else if (state is LoadedWeather) {
        return LoadedCitiesPage(contexto: context, city: state.city);
      } else {
        return const Center(child: Text('Error'));
      }
    });
  }
}
