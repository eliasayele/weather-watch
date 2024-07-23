import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather_watch/core/constants/constants.dart';
import 'package:weather_watch/weather/data/models/weather_model.dart';
part 'weather_api.g.dart';

@RestApi(baseUrl: weatherApiUrl)
abstract class WeatherApiService {
  factory WeatherApiService(Dio dio) = _WeatherApiService;

  @GET("/weather")
  Future<HttpResponse<WeatherModel>> getWeather(
    @Query("lat") double lat,
    @Query("lon") double lon,
    @Query("appid") String apiKey,
  );
}
