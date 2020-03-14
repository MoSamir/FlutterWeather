import 'ApiModels.dart';
import 'SingleDayWeatherModel.dart';

class WeatherForecastModel {
  List<SingleDayWeather> forecast = List();
  City forecastLocation;
  int forecastLength = 0;
  WeatherForecastModel(
      {this.forecast, this.forecastLength, this.forecastLocation});

  static WeatherForecastModel fromJson(Map<String, dynamic> responseJson) {
    List<SingleDayWeather> forecastList = List();
    List<dynamic> forecastJsonList = List();
    if (responseJson[JsonKeys.RESPONSE_WEATHER_LIST_KEY] != null) {
      forecastJsonList = responseJson[JsonKeys.RESPONSE_WEATHER_LIST_KEY];
      for (int i = 0; i < forecastJsonList.length; i++) {
        SingleDayWeather singleDayWeather =
            SingleDayWeather.fromJson(forecastJsonList[i]);
        forecastList.add(singleDayWeather);
      }
    }
    return WeatherForecastModel(
      forecast: forecastList,
      forecastLength: responseJson[JsonKeys.RESPONSE_DAYS_LENGTH_KEY],
      forecastLocation: City.fromJson(responseJson[JsonKeys.RESPONSE_CITY_KEY]),
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}

class JsonKeys {
  static const String RESPONSE_CITY_KEY = "city";
  static const String RESPONSE_DAYS_LENGTH_KEY = "cnt";
  static const String RESPONSE_WEATHER_LIST_KEY = "list";
}
