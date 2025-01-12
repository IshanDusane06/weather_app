import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/consts/enum/weather_status.dart';
import 'package:weather_app/pages/home_page/view/home_page.dart';
import 'package:weather_app/pages/weather_details_page/view/detailed_weather_page.dart';

GlobalKey<NavigatorState> _parentKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

class Routes {
  static final appRoutes = Provider(
    (ref) => GoRouter(
      initialLocation: HomePage.id,
      routes: [
        GoRoute(
          path: HomePage.id,
          builder: (context, state) {
            return HomePage();
          },
          routes: [
            GoRoute(
              path: DetailedWeatherScreen.id,
              builder: (context, state) {
                return DetailedWeatherScreen(
                  cityName: (state.extra! as Map)['cityName'] as String,
                  lat: (state.extra! as Map)['lat'] as double,
                  long: (state.extra! as Map)['long'] as double,
                );
              },
            )
          ],
        )
      ],
    ),
  );
}
