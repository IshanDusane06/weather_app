import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/consts/enum/weather_status.dart';
import 'package:weather_app/pages/weather_details_page/widgets/get_icon_for_day.dart';

class ForecastTile extends StatelessWidget {
  const ForecastTile({
    required this.date,
    required this.min,
    required this.high,
    required this.weatherStatus,
    super.key,
  });

  final DateTime date;
  final String min;
  final String high;
  final WeatherStatus weatherStatus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            (!date.isAfter(DateTime.now()) && !date.isBefore(DateTime.now()))
                ? 'Today'
                : DateFormat('EEEE').format(date),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          Text(
            '$min° / $high°',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          GetIcon(
            weatherStatus: weatherStatus,
          ),
        ],
      ),
    );
  }
}
