import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_tdd/core/errors/exceptions.dart';
import 'package:weather_app_tdd/features/weather/data/models/city_model.dart';

abstract class WeatherLocalDatasource {
  Future<List<CityModel>> getCachedCity();
  Future<Unit> cacheCity(List<CityModel> cityModels);
}

const CACHED_CITY = "CACHED_CITY";

class WeatherLocalDatasourceImpl implements WeatherLocalDatasource {
  final SharedPreferences sharedPreferences;

  WeatherLocalDatasourceImpl({required this.sharedPreferences});
  
  @override
  Future<Unit> cacheCity(List<CityModel> cityModels) {
    // String cityModelToJson = json.encode(cityModel.toJson());
    List cityModelsToJson = cityModels.map<Map<String, dynamic>>((cityModel) => cityModel.toJson()).toList();
    sharedPreferences.setString(CACHED_CITY, json.encode(cityModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<CityModel>> getCachedCity() {
    final jsonString = sharedPreferences.getString(CACHED_CITY);
    if (jsonString != null) {
      // Map<String, dynamic> decodeJsonData = json.decode(jsonString);
      // CityModel jsonToCityModel = CityModel.fromJson(decodeJsonData);
      List decodeJsonData = json.decode(jsonString);
      List<CityModel> jsonToCityModels = decodeJsonData
          .map<CityModel>((jsonPostModel) => CityModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToCityModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
