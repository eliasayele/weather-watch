import 'package:flutter/material.dart';
import 'package:weather_watch/core/constants/dimensions.dart';
import 'package:weather_watch/weather/presentation/blocs/blocs.dart';

class TemperatureToggle extends StatelessWidget {
  final TemperatureUnitCubit tempCubit;

  const TemperatureToggle({super.key, required this.tempCubit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.verticalSpacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Celsius/Fahrenheit',
              style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(width: Dimensions.horizontalSpacing),
          Switch(
            value: !tempCubit.isCelsius,
            onChanged: (value) => tempCubit.toggleUnit(),
          ),
        ],
      ),
    );
  }
}
