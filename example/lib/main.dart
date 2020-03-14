import 'package:flutter/material.dart';
import 'package:open_weather/WeatherForecastPlugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WeatherForecastPlugin.getWeatherForecast(
            forecastLength: 5,
            locationLongitude: -73.935242,
            locationLatitude: 40.730610,
            apiKey: "334d0f37fb15abbfb03131c10763ce05")
        .then((value) {
      print('Success');
    });
  }

  @override
  Widget build(BuildContext context) {
    getWeather();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(),
      ),
    );
  }

  void getWeather() async {
    var response = await WeatherForecastPlugin.getWeatherForecast(
        forecastLength: 5,
        locationLatitude: 30.1,
        locationLongitude: 31.3,
        apiKey: "334d0f37fb15abbfb03131c10763ce05");

    print(response.toString());
  }
}
