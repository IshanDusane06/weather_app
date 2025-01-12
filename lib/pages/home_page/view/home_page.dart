import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/pages/home_page/controller/city_list.controler.dart';
import 'package:weather_app/pages/home_page/widgets/cities_names_suggestion.dart';

class HomePage extends ConsumerStatefulWidget {
  static const String id = '/home-page';
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(cityListController.notifier).getHiveData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Weather App',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Enter a City Name',
                ),
                onChanged: (value) {
                  ref
                      .read(cityListController.notifier)
                      .getFilteredCityList(value);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer(
                builder: (context, ref, child) {
                  final cities = ref.watch(cityListController);
                  final hiveData = ref.watch(hiveDataProvider);
                  if (cities != null && cities.isNotEmpty) {
                    return Expanded(
                      child: CitiesNamesSuggestion(
                        cities: cities,
                      ),
                    );
                  } else if (hiveData != null &&
                      hiveData.recentlySearchedCities!.isNotEmpty) {
                    return Expanded(
                      child: CitiesNamesSuggestion(
                        cities: hiveData.recentlySearchedCities!,
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
