import 'package:weather_watch/core/resources/data_state.dart';
import 'package:weather_watch/weather/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<DataState<Weather>> fetchWeather(double lat, double lon);
}
