import 'package:dartz/dartz.dart';
import 'package:weather_app_tdd/core/errors/exceptions.dart';
import 'package:weather_app_tdd/core/errors/failures.dart';
import 'package:weather_app_tdd/core/network/network_info.dart';
import 'package:weather_app_tdd/features/weather/data/datasources/weather_local_datasource.dart';
import 'package:weather_app_tdd/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:weather_app_tdd/features/weather/data/models/city_model.dart';
import 'package:weather_app_tdd/features/weather/domain/entities/weather.dart';
import 'package:weather_app_tdd/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDatasourceImpl remoteDataSource;
  final WeatherLocalDatasourceImpl localDataSource;
  final NetworkInfoImpl networkInfo;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<City>>> getCity(String cityName) async {
    if (await networkInfo.isConnected) {
      try {
        final city = await remoteDataSource.getCity(cityName);
        localDataSource.cacheCity(city);
        return Right(city);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final List<CityModel> cachedCity = await localDataSource.getCachedCity();
        return Right(cachedCity);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
}
