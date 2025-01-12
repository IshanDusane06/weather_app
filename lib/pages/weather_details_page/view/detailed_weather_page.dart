import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/consts/enum/convertToCF.dart';
import 'package:weather_app/consts/enum/weather_status.dart';
import 'package:weather_app/extentions/c2FExtentions.dart';
import 'package:weather_app/pages/home_page/controller/city_list.controler.dart';
import 'package:weather_app/pages/weather_details_page/controller/detailed_weather_data.controller.dart';
import 'package:weather_app/pages/weather_details_page/widgets/forecast_tile.dart';
import 'package:weather_app/pages/weather_details_page/widgets/get_background_for_day.dart';
import 'package:weather_app/pages/weather_details_page/widgets/timewise_data.dart';

class DetailedWeatherScreen extends ConsumerStatefulWidget {
  static const String id = 'detailed-weather-page';

  const DetailedWeatherScreen({
    required this.cityName,
    required this.lat,
    required this.long,
    super.key,
  });

  final String cityName;
  final double lat;
  final double long;

  @override
  ConsumerState<DetailedWeatherScreen> createState() =>
      _DetailedWeatherScreenState();
}

class _DetailedWeatherScreenState extends ConsumerState<DetailedWeatherScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(weatherDataController.notifier).getForecastWeatherData(
            lat: widget.lat,
            long: widget.long,
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = ref.watch(weatherDataController);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => await ref
            .read(weatherDataController.notifier)
            .getForecastWeatherData(
              lat: widget.lat,
              long: widget.long,
            ),
        child: SingleChildScrollView(
          child: Visibility(
            visible: weatherData != null,
            replacement: const Center(child: CircularProgressIndicator()),
            child: Container(
              // height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    GetBackgroundImage.getImageUrl(
                      weatherData?[0]
                              .weather?[0]
                              .description
                              ?.getWeatherStatus() ??
                          WeatherStatus.rainy,
                    ),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 5,
                            sigmaY: 5,
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(top: 40),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 20),
                                      child: GestureDetector(
                                        onTap: () => context.pop(),
                                        child: CircleAvatar(
                                          backgroundColor:
                                              Colors.black.withOpacity(0.3),
                                          radius: 25,
                                          child: const Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Icon(Icons.arrow_back_ios),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    const Text(
                                      'F',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Platform.isAndroid
                                        ? Switch(
                                            activeColor:
                                                Colors.black.withOpacity(0.3),
                                            value: ref.watch(
                                                    celsiusOrFahrenheit) ==
                                                ConvertTo.celsius,
                                            onChanged: (value) async {
                                              await ref
                                                  .read(cityListController
                                                      .notifier)
                                                  .updateTemperatureFormat(
                                                      value);
                                              ref
                                                  .read(celsiusOrFahrenheit
                                                      .notifier)
                                                  .update((state) => value
                                                      ? ConvertTo.celsius
                                                      : ConvertTo.toFahrenheit);
                                            },
                                          )
                                        : CupertinoSwitch(
                                            activeColor:
                                                Colors.black.withOpacity(0.6),
                                            value: ref.watch(
                                                    celsiusOrFahrenheit) ==
                                                ConvertTo.celsius,
                                            onChanged: (value) async {
                                              await ref
                                                  .read(cityListController
                                                      .notifier)
                                                  .updateTemperatureFormat(
                                                      value);
                                              ref
                                                  .read(celsiusOrFahrenheit
                                                      .notifier)
                                                  .update((state) => value
                                                      ? ConvertTo.celsius
                                                      : ConvertTo.toFahrenheit);
                                            },
                                          ),
                                    const Text(
                                      '°C',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    )
                                  ],
                                ),
                                Text(
                                  widget.cityName,
                                  style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${weatherData?[0].main?.temp?.convertTo(ref.watch(celsiusOrFahrenheit)).split('.')[0] ?? '- -'}°',
                                  //  ' 30°',
                                  style: const TextStyle(
                                    fontSize: 80,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  weatherData?[0].weather?[0].description ?? '',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'H:${weatherData?[0].main?.tempMin?.convertTo(ref.watch(celsiusOrFahrenheit)).split('.')[0] ?? '--'}°  L:${weatherData?[0].main?.tempMax?.convertTo(ref.watch(celsiusOrFahrenheit)).split('.')[0] ?? '--'}°',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10)),
                      height: 180,
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              // Icon(Icons.calendar_month),
                              // SizedBox(
                              //   width: 10,
                              // ),
                              Text(
                                'Today\'s weather',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.white.withOpacity(0.2),
                          ),
                          Expanded(
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return TimeWiseDataTile(
                                  date: DateTime.parse(
                                      weatherData?[index].dtTxt ??
                                          DateTime.now().toString()),
                                  temp: weatherData?[index]
                                          .main
                                          ?.temp
                                          ?.toDouble()
                                          .convertTo(
                                              ref.watch(celsiusOrFahrenheit))
                                          .split('.')[0] ??
                                      '-',
                                  weatherStatus: weatherData?[index]
                                          .weather?[0]
                                          .description
                                          ?.getWeatherStatus() ??
                                      WeatherStatus.sunny,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(
                                  color: Colors.white.withOpacity(0.4),
                                  thickness: 1,
                                );
                              },
                              itemCount: weatherData?.length ?? 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10)),
                      height: 300,
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '5-Day Forecast',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.white.withOpacity(0.2),
                          ),
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                final fiveDaysData =
                                    ref.read(fiveDaysForecastData);
                                return ForecastTile(
                                  date: DateTime.parse(
                                      fiveDaysData?[index].dtTxt ??
                                          DateTime.now().toString()),
                                  high: fiveDaysData?[index]
                                          .main
                                          ?.tempMax
                                          ?.toDouble()
                                          .convertTo(
                                              ref.watch(celsiusOrFahrenheit))
                                          .split('.')[0] ??
                                      '0',
                                  min: fiveDaysData?[index]
                                          .main
                                          ?.tempMin
                                          ?.toDouble()
                                          .convertTo(
                                              ref.watch(celsiusOrFahrenheit))
                                          .split('.')[0] ??
                                      '0',
                                  weatherStatus: fiveDaysData?[index]
                                          .weather?[0]
                                          .description
                                          ?.getWeatherStatus() ??
                                      WeatherStatus.sunny,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(
                                  color: Colors.white.withOpacity(0.4),
                                  thickness: 1,
                                );
                              },
                              itemCount:
                                  ref.read(fiveDaysForecastData)?.length ?? 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
