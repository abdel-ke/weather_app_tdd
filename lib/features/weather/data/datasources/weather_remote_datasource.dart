import 'dart:convert';

import 'package:weather_app_tdd/core/errors/failures.dart';
import 'package:weather_app_tdd/features/weather/data/models/city_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDatasource {
  Future<CityModel> getCity(String cityName);
}


class WeatherRemoteDatasourceImpl extends WeatherRemoteDatasource {
  final http.Client client;

  WeatherRemoteDatasourceImpl({
    required this.client
  });

  Future<CityModel> getCity(String cityName) async {
    final String url = 'https://geocoding-api.open-meteo.com/v1/search?name=$cityName&count=5&language=en&format=json';
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final decode = jsonDecode(response.body);
      final CityModel city = CityModel.fromJson(decode);
      return city;
    }
    throw ServerFailure();
  }
}
