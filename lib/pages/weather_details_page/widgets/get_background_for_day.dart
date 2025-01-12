import 'package:weather_app/consts/enum/weather_status.dart';

class GetBackgroundImage {
  static String getImageUrl(WeatherStatus weatherStatus) {
    switch (weatherStatus) {
      case WeatherStatus.sunny:
        return 'assets/images/sunny.png';
      case WeatherStatus.cloudy:
        return 'assets/images/cloudyBg.png';
      case WeatherStatus.rainy:
        return 'assets/images/rainy.png';
    }
  }
}
