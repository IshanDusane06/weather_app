import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/consts/enum/convertToCF.dart';
import 'package:weather_app/mixin/dio_mixin.dart';
import 'package:weather_app/pages/home_page/controller/city_list.controler.dart';
import 'package:weather_app/pages/weather_details_page/model/weather_details.model.dart';
import 'package:weather_app/router/router.dart';
import 'package:weather_app/services/detailed_weather_data/detailed_weather_data.service.dart';

final weatherDataController =
    StateNotifierProvider<WeatherDataController, List<WeatherDataModel>?>(
  (ref) => WeatherDataController(
    providerRef: ref,
  ),
);

final fiveDaysForecastData =
    StateProvider<List<WeatherDataModel>?>((ref) => null);

final celsiusOrFahrenheit = StateProvider<ConvertTo>((ref) {
  if (ref.read(hiveDataProvider)?.isCelsius ?? true) {
    return ConvertTo.celsius;
  } else {
    return ConvertTo.toFahrenheit;
  }
});

class WeatherDataController extends StateController<List<WeatherDataModel>?> {
  WeatherDataController({
    required this.providerRef,
  }) : super(null);
  StateNotifierProviderRef providerRef;
  final WeatherDataService _weatherDataService = WeatherDataService();

  Future<WeatherDataModel?> getCurrentWeatherData({
    required double lat,
    required double long,
  }) async {
    try {
      Response response = await _weatherDataService.getCurrentWeatherData(
        lat: lat,
        long: long,
      );
      WeatherDataModel data = WeatherDataModel.fromJson(response.data);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future getForecastWeatherData({
    required double lat,
    required double long,
  }) async {
    try {
      WeatherDataModel? currentWeatherData =
          await getCurrentWeatherData(lat: lat, long: long);

      Response response = await _weatherDataService.getForecastWeatherData(
        lat: lat,
        long: long,
      );

      List<WeatherDataModel> forecastData = [];
      if (response.statusCode == 200) {
        forecastData = (response.data['list'] as List)
            .map((e) => WeatherDataModel.fromJson(e))
            .toList();
      }
      List<WeatherDataModel> fiveForecastDays = [];
      for (int i = 0; i < forecastData.length; i++) {
        DateTime? previousDate = i == 0
            ? null
            : DateTime.parse(
                forecastData[i - 1].dtTxt ?? DateTime.now().toString());
        DateTime currentDate =
            DateTime.parse(forecastData[i].dtTxt ?? DateTime.now().toString());
        if (i == 0) {
          fiveForecastDays.add(forecastData[i]);
        } else if (!(currentDate.day == previousDate?.day &&
            currentDate.month == previousDate?.month &&
            currentDate.year == previousDate?.year)) {
          fiveForecastDays.add(forecastData[i]);
        } else {
          continue;
        }

        if (fiveForecastDays.length == 5) {
          break;
        }
      }

      providerRef
          .read(fiveDaysForecastData.notifier)
          .update((state) => fiveForecastDays);

      state = [currentWeatherData!, ...forecastData];
    } catch (e) {
      ScaffoldMessenger.of(providerRef
              .read(Routes.appRoutes)
              .routerDelegate
              .navigatorKey
              .currentContext!)
          .showSnackBar(
        const SnackBar(
          content: Text('Something went wrong while fetching weather data'),
        ),
      );
    }
  }
}
