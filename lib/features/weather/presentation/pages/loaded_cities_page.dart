import 'package:flutter/material.dart';
import 'package:weather_app_tdd/features/weather/domain/entities/weather.dart';

class LoadedCitiesPage extends StatelessWidget {
  final List<City> city;
  const LoadedCitiesPage({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _apBar(),
      body: ListView.builder(
        itemCount: city.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(city[index].name),
            subtitle: Text(city[index].country),
            onTap: () {
              debugPrint(
                  'city[index].name: ${city[index].name} ${city[index].country}');
            },
          );
        },
      ),
    );
  }

  AppBar _apBar() {
    return AppBar(
      title: const Text('Weather deApp'),
    );
  }
}
