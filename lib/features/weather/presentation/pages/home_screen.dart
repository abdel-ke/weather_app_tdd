import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_tdd/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app_tdd/features/weather/presentation/pages/loaded_cities_page.dart';
import 'package:weather_app_tdd/features/weather/presentation/pages/search_city_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background/galaxy.jpg"),
              fit: BoxFit.cover)),
      child: Scaffold(
        appBar: _apBar(),
        body: _buildBody(),
      ),
    );
  }

  AppBar _apBar() {
    return AppBar(
      title: TextField(
        textInputAction: TextInputAction.done,
        onTap: () {},
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.white),
            hintText: 'Search...',
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
        debugPrint('BlocBuilder call');
        if (state is WeatherInitialState) {
          debugPrint('LoadInitialWeather call');
          return const SearchCityPage();
        } else if (state is LoadedWeatherState) {
          debugPrint('LoadedWeather call');
          return LoadedCitiesPage(city: state.city);
        } else if (state is ErrorWeatherState) {
          debugPrint('ErrorWeatherState call');
          return Center(
            child: Text(state.message),
          );
        } else {
          debugPrint('Autre call');
          return const Center(child: Text('Error'));
        }
      }),
    );
  }
}
