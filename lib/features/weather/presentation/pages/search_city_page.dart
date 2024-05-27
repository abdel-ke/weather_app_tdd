import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_tdd/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app_tdd/features/weather/presentation/pages/loaded_cities_page.dart';

class SearchCityPage extends StatefulWidget {
  const SearchCityPage({super.key});

  @override
  State<SearchCityPage> createState() => _SearchCityPageState();
}

class _SearchCityPageState extends State<SearchCityPage> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is ErrorWeatherState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('error alkhawa dyali'),
            ),
          );
        }
      },
      builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  controller: myController,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<WeatherBloc>(context).add(
                    GetWeatherForCity(myController.text),
                  );
                },
                child: const Text('Search for a city'),
              ),
            ],
          ),
        );
      },
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              controller: myController,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                debugPrint('before call');
                final failureOrCity =
                    await BlocProvider.of<WeatherBloc>(context)
                        .weatherUsecase
                        .call(myController.text);
                debugPrint('after call');

                failureOrCity.fold((failureLoad) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('error alkhawa dyali'),
                    ),
                  );
                }, (city) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoadedCitiesPage(
                        city: city,
                      ),
                    ),
                  );
                });
              } catch (e) {
                debugPrint('after call with error $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text(
                      'error alkhawa dyali',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        // backgroundColor: Colors.redAccent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            },
            child: const Text('Search for a city'),
          ),
        ],
      ),
    );
  }
}
