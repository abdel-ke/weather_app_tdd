import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_tdd/features/weather/presentation/bloc/weather_bloc.dart';

class SearchCityPage extends StatefulWidget {
  const SearchCityPage({super.key});

  @override
  State<SearchCityPage> createState() => _SearchCityPageState();
}

class _SearchCityPageState extends State<SearchCityPage> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                onPressed: () {
                  BlocProvider.of<WeatherBloc>(context)
                      .add(GetCity(city: myController.text));
                },
                child: const Text('Search for a city'),
              ),
            ],
          ),
        ),
    );
  }
}