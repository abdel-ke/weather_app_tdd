part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class GetCity extends WeatherEvent {
  final String city;

  const GetCity({
    required this.city
  });

  @override
  List<Object> get props => [city];
}

class ErrorGetCity extends WeatherEvent {
  final String errorMessage;

  const ErrorGetCity({
    required this.errorMessage
  });

  @override
  List<Object> get props => [errorMessage];
}
