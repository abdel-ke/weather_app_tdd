import 'package:dartz/dartz.dart';
import 'package:weather_app_tdd/core/errors/failures.dart';
import 'package:weather_app_tdd/features/weather/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, City>> getCity(String cityName);
}
