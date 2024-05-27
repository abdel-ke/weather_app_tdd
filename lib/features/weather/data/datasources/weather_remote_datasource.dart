import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:weather_app_tdd/core/errors/failures.dart';
import 'package:weather_app_tdd/features/weather/data/models/city_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDatasource {
  Future<List<CityModel>> getCity(String cityName);
}

class WeatherRemoteDatasourceImpl implements WeatherRemoteDatasource {
  final http.Client client;

  WeatherRemoteDatasourceImpl({required this.client});

  @override
  Future<List<CityModel>> getCity(String cityName) async {
    final String url =
        'https://geocoding-api.open-meteo.com/v1/search?name=$cityName&count=5&language=en&format=json';
    final response = await client.get(Uri.parse(url));
    debugPrint('response: ${response.statusCode}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJson = json.decode(response.body);
      debugPrint('response: ${decodeJson['results']}');
      if (decodeJson['results'] == null) {
        debugPrint('EmptyData');
        throw ServerFailure();
      } else {
        debugPrint('CityModel');
        final List<CityModel> cityList = [];
        for (var item in decodeJson['results']) {
          cityList.add(CityModel.fromJson(item));
        }
        return cityList;
      }
    }
    throw ServerFailure();
  }
}
