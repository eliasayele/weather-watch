import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_watch/config/theme.dart';
import 'package:weather_watch/service_locator.dart';
import 'package:weather_watch/weather/presentation/blocs/blocs.dart';
import 'package:weather_watch/weather/presentation/pages/weather_page.dart';

void main() async {
  // Ensure that the dependencies are initialized
  await setUpServiceLocator();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Watch',
      theme: AppTheme.lightTheme,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherBloc>(
            create: (context) => sl<WeatherBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<TemperatureUnitCubit>(),
          )
        ],
        child: const WeatherPage(),
      ),
    );
  }
}
