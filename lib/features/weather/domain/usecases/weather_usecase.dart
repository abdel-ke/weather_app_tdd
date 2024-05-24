import 'package:dartz/dartz.dart';
import 'package:weather_app_tdd/core/errors/failures.dart';
import 'package:weather_app_tdd/features/weather/domain/entities/weather.dart';
import 'package:weather_app_tdd/features/weather/domain/repositories/weather_repository.dart';

class WeatherUsecase {
  final WeatherRepository _repository;

  WeatherUsecase(this._repository);

  Future<Either<Failure, City>> call(String cityName) {
    return _repository.getCity(cityName);
  }
}
