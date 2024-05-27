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
        backgroundColor: Colors.transparent,
        appBar: _apBar(),
        body: _buildBody(),
      ),
    );
  }

  AppBar _apBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
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
      actions: [
        const VerticalDivider(
          color: Colors.grey,
          thickness: 0.8,
          endIndent: 10,
          indent: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: IconButton(
              onPressed: () async {
                // await getLocation(context);
              },
              icon: const Icon(
                Icons.location_on_outlined,
                color: Colors.white,
              )),
        ),
      ],
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
            child: Text(
              state.message,
              style: const TextStyle(fontSize: 25, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          debugPrint('Autre call');
          return const Center(
            child: Text(
              'Error',
              style: TextStyle(color: Colors.white),
            ),
          );
        }
      }),
    );
  }
}
