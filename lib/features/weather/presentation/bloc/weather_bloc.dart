import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app_tdd/features/weather/domain/entities/weather.dart';
import 'package:weather_app_tdd/features/weather/domain/usecases/weather_usecase.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherUsecase weatherUsecase;

  WeatherBloc({required this.weatherUsecase}) : super(WeatherInitialState()) {
    on<WeatherEvent>((event, emit) async {
      if (event is GetCityEvent) {
        final failureOrCity = await weatherUsecase(event.city);
        debugPrint('failureOrCity.runtimeType: ${failureOrCity.runtimeType}');
        emit(
          failureOrCity.fold(
            (failure) {
              debugPrint('failure.runtimeType: ${failure.runtimeType}');
              return const ErrorWeatherState(message: 'error alkhawa dyali');
            },
            (city) {
              debugPrint('city.runtimeType: ${city.runtimeType}');
              return LoadedWeatherState(city: city);
            },
          ),
        );
      } else if (event is LoadInitialWeatherEvent) {
        debugPrint('LoadInitialWeatherEvent call');
        emit(WeatherInitialState());
      }
    });
  }
}
