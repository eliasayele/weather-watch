import 'package:flutter/material.dart';
import 'package:weather_watch/weather/presentation/blocs/blocs.dart';

class WeatherDisplay extends StatelessWidget {
  final WeatherState state;
  final bool isCelsius;

  const WeatherDisplay(
      {super.key, required this.state, required this.isCelsius});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    if (state is WeatherInitial) {
      return const Center(child: Text('Please wait...'));
    } else if (state is WeatherLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is WeatherLoaded) {
      final weatherState = state as WeatherLoaded;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Temperature', style: textTheme.titleLarge),
          Text(
            '${_convertTemperature(weatherState.weather.temperature ?? 0.0).toStringAsFixed(1)} ${isCelsius ? 'degrees' : 'fahrenheit'}',
            style: textTheme.bodyLarge,
          ),
          Text('Location', style: textTheme.titleLarge),
          Text(weatherState.weather.locationName ?? 'Unknown',
              style: textTheme.bodyLarge),
        ],
      );
    } else if (state is WeatherError) {
      return const Text('Failed to load weather');
    }
    return Container();
  }

  double _convertTemperature(double celsius) {
    return isCelsius ? celsius : (celsius * 9 / 5) + 32;
  }
}
