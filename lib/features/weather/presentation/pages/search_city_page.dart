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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search city',
              ),
              controller: myController,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final failureOrCity = await BlocProvider.of<WeatherBloc>(context)
                  .weatherUsecase
                  .call(myController.text);

              debugPrint(
                  'failureOrCity.runtimeType: ${failureOrCity.runtimeType}');

              failureOrCity.fold((failureLoad) {
                debugPrint('error.runtimeType: ${failureLoad.runtimeType}');
                // show errorSnackBa
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('error alkhawa dyali'),
                  ),
                );
              }, (city) {
                debugPrint('city.runtimeType: ${city.runtimeType}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LoadedCitiesPage(
                      city: city,
                    ),
                  ),
                );
              });
            },
            child: const Text('Search for a city'),
          ),
        ],
      ),
    );
  }
}
