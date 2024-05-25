import 'package:flutter/material.dart';
import 'package:weather_app_tdd/features/weather/domain/entities/weather.dart';
import 'package:weather_app_tdd/features/weather/presentation/pages/search_city_page.dart';

class LoadedCitiesPage extends StatelessWidget {
  final List<City> city;
  final BuildContext contexto;
  const LoadedCitiesPage({super.key,required this.contexto, required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loaded Cities'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchCityPage()));
          },
        ),
      ),
      body: ListView.builder(
      itemCount: city.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(city[index].name),
        );
      },
    )
    );
  }
}
