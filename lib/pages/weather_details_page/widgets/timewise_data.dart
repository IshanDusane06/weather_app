import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/consts/enum/weather_status.dart';
import 'package:weather_app/pages/weather_details_page/widgets/get_icon_for_day.dart';

class TimeWiseDataTile extends StatelessWidget {
  const TimeWiseDataTile({
    required this.date,
    required this.temp,
    required this.weatherStatus,
    super.key,
  });

  final DateTime date;
  final String temp;
  final WeatherStatus weatherStatus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('hh:mm a').format(date),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          GetIcon(
            weatherStatus: weatherStatus,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            '$temp°',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
