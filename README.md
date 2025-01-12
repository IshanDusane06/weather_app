# weather_app
<img width="400" alt="Screenshot 2025-01-12 at 6 36 12 PM" src="https://github.com/user-attachments/assets/e19c6311-2fa8-45b1-af28-98dc1bf853e5" />
<img width="400" alt="Screenshot 2025-01-12 at 6 35 45 PM" src="https://github.com/user-attachments/assets/36a8157f-1ce9-4d18-a1e3-ae5e9e904e56" />
<img width="400" alt="Screenshot 2025-01-12 at 6 35 06 PM" src="https://github.com/user-attachments/assets/fc8479c6-3928-4ebb-a685-62037257049b" />

# Supported Features
- [x] Current Weather
- [x] Current days weather in 3 hours gap
- [x] 5-day Forecast 
- [x] option to chose between celsius and fahrenheit with a simple toggle
- [x] search with names of cities
- [x] store the last three search in local DB using hive
- [x] store the user perfered scale(°C/°F) to persist data using hive

# Packages Used
 1. [riverpod](https://pub.dev/packages/riverpod) for state management
 2. [go_router](https://pub.dev/packages/go_router) for routing
 3. [hive](https://pub.dev/packages/hive_flutter) for local data
 4. [dio](https://pub.dev/packages/dio) for network calls
 5. [json_serializable](https://pub.dev/packages/json_serializable) for serialization

# Get Your api key
1. [Sign Up](https://home.openweathermap.org/users/sign_up) and create your account
2. Get the api key after sign up

# How to run app
1. Clone repository
2. ```cd weather_app```
3. Run command: ```flutter run --dart-define=API_KEY=<YOUR_API_KEY>```

