# Weather Watch

Weather Watch is a Flutter application that displays current weather information using the OpenWeatherMap API. Users must create an `.env` file to store their API key in order to run the application.

## Features

- Fetches and displays current weather data based on user location
- Displays temperature in both Celsius and Fahrenheit
- Refreshes weather data on user request
- Uses state management with BLoC and Cubit

## Getting Started

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- An API key from OpenWeatherMap: [Get API key](https://home.openweathermap.org/users/sign_up)

### Setup

1. **Clone the repository:**

   ```bash
   git clone https://github.com/your-repo/weather_watch.git
   cd weather_watch
   ```

2. **Create an `.env` file in the root of your project:**

   ```plaintext
   WEATHER_API_KEY=your_openweathermap_api_key
   ```

3. **Install dependencies:**

   ```bash
   flutter pub get
   ```

4. **Run the app:**

   ```bash
   flutter run
   ```

### Project Structure

The project follows a clean architecture structure:

```plaintext
lib/
├── config/
│   └── theme.dart              // Application theme configuration
├── core/
│   ├── constants/              // Global constants used across the app
│   └── resources/              // Resources such as images and styles
├── weather/
│   ├── data/                   // Data layer: API services, data sources, and repositories
│   ├── domain/                 // Domain layer: Models and use cases
│   └── presentation/           // Presentation layer: UI, widgets, and BLoC/Cubit
├── main.dart                   // Entry point of the application
└── service_locator.dart        // Service locator for dependency injection
```

### Environment Variables

To avoid exposing your API key, store it in the `.env` file. This file should not be committed to version control. Add `.env` to your `.gitignore` file:

```plaintext
# .gitignore
.env
```

### State Management

The app uses BLoC and Cubit for state management:

- `WeatherBloc` manages fetching and updating weather data.
- `TemperatureUnitCubit` manages the state of the temperature unit toggle.

### Documentation

#### `WeatherApiService`

This service uses Retrofit to interact with the OpenWeatherMap API.

```dart
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
```

### Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your changes.

### License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

---

For further assistance, refer to the [Flutter documentation](https://flutter.dev/docs).