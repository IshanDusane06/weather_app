import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/consts/cities_data/cities.data.dart';
import 'package:weather_app/pages/home_page/controller/city_list.controler.dart';
import 'package:weather_app/pages/home_page/view/home_page.dart';
import 'package:weather_app/pages/weather_details_page/view/detailed_weather_page.dart';

class CitiesNamesSuggestion extends ConsumerWidget {
  const CitiesNamesSuggestion({
    required this.cities,
    super.key,
  });
  final List<String> cities;
  final data = DataForCities.lagLongData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemCount: cities.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            context.push('${HomePage.id}/${DetailedWeatherScreen.id}', extra: {
              'cityName': cities[index],
              'lat': data[cities[index]]!['latitude'],
              'long': data[cities[index]]!['longitude'],
            });
            await ref
                .read(cityListController.notifier)
                .updateCityInHive(cities[index]);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              cities[index],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          thickness: 1,
        );
      },
    );
  }
}
