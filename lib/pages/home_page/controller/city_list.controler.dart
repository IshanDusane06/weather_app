import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/consts/cities_data/cities.data.dart';
import 'package:weather_app/consts/enum/convertToCF.dart';
import 'package:weather_app/pages/home_page/model/persistent_data.model.dart';
import 'package:weather_app/pages/weather_details_page/controller/detailed_weather_data.controller.dart';
import 'package:weather_app/router/router.dart';
import 'package:weather_app/services/persistent_data/persistent_data.dart';

final cityListController =
    StateNotifierProvider<CityListController, List<String>?>(
  (ref) => CityListController(
    providerRef: ref,
  ),
);

final hiveDataProvider = StateProvider<PersistentDataModel?>((ref) => null);

class CityListController extends StateController<List<String>?> {
  CityListController({
    required this.providerRef,
  }) : super(null);
  StateNotifierProviderRef providerRef;
  final PersistentDataService _persistentDataService = PersistentDataService();

  void getFilteredCityList(String searchQuery) {
    List<String> citiesData = DataForCities.countryList;
    if (searchQuery.isEmpty) {
      state = [];
    } else {
      state = citiesData
          .where(
              (city) => city.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
  }

  Future updateCityInHive(String cityName) async {
    try {
      final data = await _persistentDataService.getData();
      // final List<String> updatedData = [];
      if (data != null && data.recentlySearchedCities != null) {
        int indexOfAlreadyPresentCity = data.recentlySearchedCities!.indexWhere(
          (element) => element == cityName,
        );
        if (indexOfAlreadyPresentCity != -1) {
          data.recentlySearchedCities?.removeAt(indexOfAlreadyPresentCity);
          data.recentlySearchedCities?.insert(0, cityName);
        } else if (data.recentlySearchedCities!.length == 3) {
          data.recentlySearchedCities?.removeLast();
          data.recentlySearchedCities?.insert(0, cityName);
        } else {
          data.recentlySearchedCities!.add(cityName);
        }
        _persistentDataService.putData(
            data.copyWith(recentlySearchedCities: data.recentlySearchedCities));
      } else {
        _persistentDataService.putData(
          PersistentDataModel(
            recentlySearchedCities: [cityName],
            isCelsius:
                providerRef.read(celsiusOrFahrenheit) == ConvertTo.celsius,
          ),
        );
      }
      await getHiveData();
    } on FlutterError catch (e) {
      ScaffoldMessenger.of(providerRef
              .read(Routes.appRoutes)
              .configuration
              .navigatorKey
              .currentContext!)
          .showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(providerRef
              .read(Routes.appRoutes)
              .configuration
              .navigatorKey
              .currentContext!)
          .showSnackBar(
        const SnackBar(
            content: Text('Something went wrong'), backgroundColor: Colors.red),
      );
    }
  }

  Future getHiveData() async {
    try {
      final data = await _persistentDataService.getData();
      providerRef.read(hiveDataProvider.notifier).update((state) => data);
    } on FlutterError catch (e) {
      ScaffoldMessenger.of(providerRef
              .read(Routes.appRoutes)
              .configuration
              .navigatorKey
              .currentContext!)
          .showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      ScaffoldMessenger.of(providerRef
              .read(Routes.appRoutes)
              .configuration
              .navigatorKey
              .currentContext!)
          .showSnackBar(
        const SnackBar(
            content: Text('Something went wrong'), backgroundColor: Colors.red),
      );
    }
  }

  Future updateTemperatureFormat(bool isCelsius) async {
    try {
      final data = await _persistentDataService.getData();
      if (data != null) {
        _persistentDataService.putData(data.copyWith(isCelsius: isCelsius));
      } else {
        _persistentDataService.putData(
          PersistentDataModel(
            isCelsius:
                providerRef.read(celsiusOrFahrenheit) == ConvertTo.celsius,
          ),
        );
      }
    } on FlutterError catch (e) {
      ScaffoldMessenger.of(providerRef
              .read(Routes.appRoutes)
              .configuration
              .navigatorKey
              .currentContext!)
          .showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    } catch (e) {
      ScaffoldMessenger.of(providerRef
              .read(Routes.appRoutes)
              .configuration
              .navigatorKey
              .currentContext!)
          .showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
