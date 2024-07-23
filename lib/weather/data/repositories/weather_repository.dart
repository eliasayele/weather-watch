import 'package:weather_watch/core/resources/data_state.dart';
import 'package:weather_watch/weather/domain/entities/weather.dart';
import 'package:weather_watch/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  @override
  Future<DataState<Weather>> fetchWeather(double lat, double lon) {
    // TODO: implement fetchWeather
    throw UnimplementedError();
  }
}
