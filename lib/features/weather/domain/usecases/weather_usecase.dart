import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_tdd/core/errors/failures.dart';
import 'package:weather_app_tdd/features/weather/domain/entities/weather.dart';
import 'package:weather_app_tdd/features/weather/domain/repositories/weather_repository.dart';

class WeatherUsecase {
  final WeatherRepository _repository;

  WeatherUsecase(this._repository);

  Future<Either<Failure, List<City>>> call(String cityName) {
    debugPrint('WeatherUsecase call');
    final result = _repository.getCity(cityName);
    debugPrint('result: $result');
    return result;
  }
}
