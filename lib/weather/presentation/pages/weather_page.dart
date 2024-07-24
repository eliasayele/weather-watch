import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_watch/core/constants/constants.dart';
import 'package:weather_watch/core/constants/dimensions.dart';
import 'package:weather_watch/service_locator.dart';
import 'package:weather_watch/weather/presentation/blocs/blocs.dart';
import 'package:weather_watch/weather/presentation/widgets/refresh_button.dart';
import 'package:weather_watch/weather/presentation/widgets/responsive_image.dart';
import 'package:weather_watch/weather/presentation/widgets/temperature_toggle.dart';
import 'package:weather_watch/weather/presentation/widgets/weather_display.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late final WeatherBloc _weatherBloc;
  late final TemperatureUnitCubit _tempCubit;

  @override
  void initState() {
    super.initState();
    _weatherBloc = sl<WeatherBloc>();
    _tempCubit = sl<TemperatureUnitCubit>();
    _weatherBloc.add(FetchWeather(lat: latitude, lon: longitude));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.pagePadding).copyWith(bottom: 80),
                child: BlocBuilder<TemperatureUnitCubit, bool>(
                  bloc: _tempCubit,
                  builder: (context, isCelsius) {
                    return BlocBuilder<WeatherBloc, WeatherState>(
                      bloc: _weatherBloc,
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ResponsiveImage(),
                            const SizedBox(height: Dimensions.verticalSpacing),
                            Center(
                              child: Text('THIS IS MY WEATHER APP', style: Theme.of(context).textTheme.headlineMedium),
                            ),
                            const SizedBox(height: Dimensions.verticalSpacing),
                            WeatherDisplay(state: state, isCelsius: isCelsius),
                            TemperatureToggle(tempCubit: _tempCubit),
                            const SizedBox(height: 20)
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.pagePadding),
                child: RefreshButton(onPressed: () => _weatherBloc.add(FetchWeather(lat: latitude, lon: longitude))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
