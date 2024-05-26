part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class GetCityEvent extends WeatherEvent {
  final String city;

  const GetCityEvent({
    required this.city
  });

  @override
  List<Object> get props => [city];
}

class ErrorGetCityEvent extends WeatherEvent {
  final String errorMessage;

  const ErrorGetCityEvent({
    required this.errorMessage
  });

  @override
  List<Object> get props => [errorMessage];
}

class LoadInitialWeatherEvent extends WeatherEvent {}
