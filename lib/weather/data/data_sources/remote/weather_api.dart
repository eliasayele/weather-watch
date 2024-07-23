import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather_watch/core/constants/constants.dart';
import 'package:weather_watch/weather/data/models/weather_model.dart';
part 'weather_api.g.dart';

/// This interface defines the Weather API service using Retrofit.
/// Retrofit helps in generating HTTP client code for making API calls.
@RestApi(baseUrl: weatherApiUrl)
abstract class WeatherApiService {
  /// Factory constructor for creating a new instance of [WeatherApiService].
  /// The [Dio] instance is passed as a parameter to configure the HTTP client.
  factory WeatherApiService(Dio dio) = _WeatherApiService;

  /// Fetches weather data from the API based on the provided latitude, longitude, and API key.
  ///
  /// [getWeather] method performs a GET request to the `/weather` endpoint.
  ///
  /// Parameters:
  /// - [lat]: Latitude of the location for which weather data is required.
  /// - [lon]: Longitude of the location for which weather data is required.
  /// - [apiKey]: API key for authenticating the request.
  ///
  /// Returns a [Future] that completes with an [HttpResponse] containing a [WeatherModel] object.
  @GET("/weather")
  Future<HttpResponse<WeatherModel>> getWeather(
    @Query("lat") double lat,
    @Query("lon") double lon,
    @Query("appid") String apiKey,
  );
}
