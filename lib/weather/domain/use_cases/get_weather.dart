import 'package:weather_watch/core/resources/data_state.dart';
import 'package:weather_watch/weather/domain/entities/weather.dart';
import 'package:weather_watch/weather/domain/repositories/weather_repository.dart';

class GetWeather {
  final WeatherRepository repository;

  GetWeather(this.repository);

  Future<DataState<Weather>> call(double lat, double lon) async {
    return await repository.fetchWeather(lat, lon);
  }
}
