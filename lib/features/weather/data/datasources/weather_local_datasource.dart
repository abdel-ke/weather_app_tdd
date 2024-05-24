import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_tdd/core/errors/exceptions.dart';
import 'package:weather_app_tdd/features/weather/data/models/city_model.dart';

abstract class WeatherLocalDatasource {
  Future<CityModel> getCachedCity();
  Future<Unit> cacheCity(CityModel cityModel);
}

const CACHED_CITY = "CACHED_CITY";

class WeatherLocalDatasourceImpl extends WeatherLocalDatasource {
  final SharedPreferences sharedPreferences;

  WeatherLocalDatasourceImpl({required this.sharedPreferences});
  
  @override
  Future<Unit> cacheCity(CityModel cityModel) {
    String cityModelToJson = json.encode(cityModel.toJson());
    sharedPreferences.setString(CACHED_CITY, cityModelToJson);
    return Future.value(unit);
  }

  @override
  Future<CityModel> getCachedCity() {
    final jsonString = sharedPreferences.getString(CACHED_CITY);
    if (jsonString != null) {
      Map<String, dynamic> decodeJsonData = json.decode(jsonString);
      CityModel jsonToCityModel = CityModel.fromJson(decodeJsonData);
      return Future.value(jsonToCityModel);
    } else {
      throw EmptyCacheException();
    }
  }
}
