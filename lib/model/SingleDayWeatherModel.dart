import 'ApiModels.dart';

class SingleDayWeather {
  DateTime forecastTime, sunRise, sunSet;

  SingleDayWeather(
      {this.forecastTime,
      this.sunRise,
      this.sunSet,
      this.dayTemp,
      this.airPressure,
      this.airHumidity,
      this.windSpeed,
      this.windDegree,
      this.feelsLikeTemp,
      this.cloudPercentage,
      this.snowPercentage,
      this.weatherInformation});

  Temperature dayTemp, feelsLikeTemp;
  double airPressure,
      airHumidity,
      windSpeed,
      windDegree,
      cloudPercentage,
      snowPercentage;
  List<Weather> weatherInformation;

  static SingleDayWeather fromJson(Map<String, dynamic> singleDayWeather) {
    List<Weather> weatherList = List();
    if (singleDayWeather[JsonKeys.WEATHER_KEY] != null) {
      List<dynamic> weatherInfo = singleDayWeather[JsonKeys.WEATHER_KEY];
      for (int i = 0; i < weatherInfo.length; i++) {
        weatherList.add(Weather.fromJson(weatherInfo[i]));
      }
    }
    return SingleDayWeather(
      forecastTime: DateTime.fromMillisecondsSinceEpoch(
          singleDayWeather[JsonKeys.TIMESTAMP_KEY] ?? DateTime.now()),
      sunRise: DateTime.fromMillisecondsSinceEpoch(
          singleDayWeather[JsonKeys.SUN_RISE_KEY] ??
              DateTime.now().millisecondsSinceEpoch),
      sunSet: DateTime.fromMillisecondsSinceEpoch(
          singleDayWeather[JsonKeys.SUN_SET_KEY] ??
              DateTime.now().millisecondsSinceEpoch),
      dayTemp: Temperature.fromJson(singleDayWeather[JsonKeys.TEMPERATURE_KEY]),
      feelsLikeTemp: Temperature.fromJson(
          singleDayWeather[JsonKeys.FEELS_LIKE_KEY] ??
              singleDayWeather[JsonKeys.TEMPERATURE_KEY]),
      airHumidity:
          double.tryParse(singleDayWeather[JsonKeys.HUMIDITY_KEY].toString()) ??
              0.0,
      airPressure:
          double.tryParse(singleDayWeather[JsonKeys.PRESSURE_KEY].toString()) ??
              0.0,
      cloudPercentage:
          double.tryParse(singleDayWeather[JsonKeys.CLOUD_KEY].toString()) ??
              0.0,
      windSpeed: double.tryParse(
              singleDayWeather[JsonKeys.WIND_SPEED_KEY].toString()) ??
          0.0,
      windDegree: double.tryParse(
              singleDayWeather[JsonKeys.WIND_DEGREE_KEY].toString()) ??
          0.0,
      snowPercentage:
          double.tryParse(singleDayWeather[JsonKeys.SNOW_KEY].toString()) ??
              0.0,
      weatherInformation: weatherList,
    );
  }
}

class JsonKeys {
  static const String SUN_RISE_KEY = "sunrise";
  static const String SUN_SET_KEY = "sunset";
  static const String FEELS_LIKE_KEY = "feels_like";
  static const String TIMESTAMP_KEY = "dt";
  static const String TEMPERATURE_KEY = "temp";
  static const String PRESSURE_KEY = "pressure";
  static const String HUMIDITY_KEY = "humidity";
  static const String WEATHER_KEY = "weather";
  static const String WIND_SPEED_KEY = "speed";
  static const String WIND_DEGREE_KEY = "deg";
  static const String CLOUD_KEY = "clouds";
  static const String SNOW_KEY = "snow";
  static const String RAIN_POSSIBILITY = "rain";
}
