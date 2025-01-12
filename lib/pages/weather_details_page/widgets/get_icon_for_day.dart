import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weather_app/consts/enum/weather_status.dart';

class GetIcon extends StatelessWidget {
  const GetIcon({required this.weatherStatus, super.key});

  final WeatherStatus weatherStatus;

  @override
  Widget build(BuildContext context) {
    switch (weatherStatus) {
      case WeatherStatus.sunny:
        return const Icon(
          Icons.sunny,
          color: Colors.amber,
        );
      case WeatherStatus.cloudy:
        return Image.asset(
          'assets/images/cloudy.png',
          height: 25,
        );
      case WeatherStatus.rainy:
        return Image.asset(
          'assets/images/rainy-day.png',
          height: 25,
        );
    }
    ;
  }
}
