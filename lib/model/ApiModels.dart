library openweatherapi;

class TemperatureDegree {
  double kelvin, celsius, fahrenheit;
  TemperatureDegree({this.kelvin, this.celsius, this.fahrenheit});
  static TemperatureDegree fromCelsius(celsiusTemp) {
    if (celsiusTemp == null)
      celsiusTemp = 0.0;
    else
      celsiusTemp = double.tryParse(celsiusTemp.toString()) ?? 0.0;

    return TemperatureDegree(
        celsius: celsiusTemp,
        fahrenheit: (9 / 5 * celsiusTemp) + 32,
        kelvin: celsiusTemp + 273.0);
  }
}

class Temperature {
  TemperatureDegree morningTemp,
      dayTemp,
      nightTemp,
      eveningTemp,
      maxTemp,
      minTemp;

  Temperature(
      {this.morningTemp,
      this.dayTemp,
      this.nightTemp,
      this.eveningTemp,
      this.maxTemp,
      this.minTemp});

  static Temperature fromJson(Map<String, dynamic> temperatureJson) {
    return Temperature(
      dayTemp:
          TemperatureDegree.fromCelsius(temperatureJson[JsonKeys.DAY_TEMP_KEY]),
      nightTemp: TemperatureDegree.fromCelsius(
          temperatureJson[JsonKeys.NIGHT_TEMP_KEY]),
      morningTemp: TemperatureDegree.fromCelsius(
          temperatureJson[JsonKeys.MORNING_TEMP_KEY]),
      eveningTemp: TemperatureDegree.fromCelsius(
          temperatureJson[JsonKeys.EVENING_TEMP_KEY]),
      maxTemp:
          TemperatureDegree.fromCelsius(temperatureJson[JsonKeys.MAX_TEMP_KEY]),
      minTemp:
          TemperatureDegree.fromCelsius(temperatureJson[JsonKeys.MIN_TEMP_KEY]),
    );
  }
}

class Weather {
  int weatherId;
  String weatherMainTitle, weatherDescription, weatherIconPath;

  static Weather fromJson(Map<String, dynamic> weatherJson) {
    return Weather(
      weatherDescription: weatherJson[JsonKeys.WEATHER_DESCRIPTION_KEY],
      weatherId: weatherJson[JsonKeys.WEATHER_ID_KEY],
      weatherMainTitle: weatherJson[JsonKeys.WEATHER_MAIN_KEY],
      weatherIconPath:
          'http://openweathermap.org/img/wn/${weatherJson[JsonKeys.WEATHER_ICON_KEY]}@2x.png',
    );
  }

  Weather(
      {this.weatherId,
      this.weatherMainTitle,
      this.weatherDescription,
      this.weatherIconPath});
}

class City {
  int locationGeoId, locationPopulation;

  City(
      {this.locationGeoId,
      this.locationPopulation,
      this.locationName,
      this.locationCountryCode,
      this.locationCoordinates,
      this.locationIsoCode,
      this.locationType});

  Coordinates locationCoordinates;

  String locationName, locationCountryCode, locationIsoCode, locationType;
  static City fromJson(Map<String, dynamic> locationJson) {
    print('City Information => $locationJson');
    return City(
      locationCountryCode: locationJson[JsonKeys.CITY_COUNTRY_CODE_KEY] ?? '',
      locationGeoId: locationJson[JsonKeys.CITY_GOE_NAME_ID_KEY] ?? 0,
      locationIsoCode: locationJson[JsonKeys.CITY_COUNTRY_ISO_CODE_KEY] ?? '',
      locationName: locationJson[JsonKeys.CITY_NAME_KEY] ?? '',
      locationPopulation: locationJson[JsonKeys.CITY_POPULATION_KEY] ?? 0,
      locationType: locationJson[JsonKeys.CITY_TYPE_KEY] ?? '',
      locationCoordinates:
          Coordinates.fromJson(locationJson[JsonKeys.CITY_COORDINATES_KEY]),
    );
  }
}

class Coordinates {
  double locationLatitude, locationLongitude;
  Coordinates({this.locationLongitude, this.locationLatitude});

  static fromJson(coordinatesJson) {
    return Coordinates(
      locationLatitude: coordinatesJson[JsonKeys.CITY_LATITUDE_KEY] ?? 0.0,
      locationLongitude: coordinatesJson[JsonKeys.CITY_LONGITUDE_KEY] ?? 0.0,
    );
  }
}

class ErrorViewModel {
  String errorMessage;
  int statuesCode;
  ErrorViewModel({this.errorMessage, this.statuesCode});
}

class JsonKeys {
  // ------------- DayPars Json -----------------------

  static const String DAY_TEMP_KEY = "day";
  static const String MIN_TEMP_KEY = "min";
  static const String MAX_TEMP_KEY = "max";
  static const String NIGHT_TEMP_KEY = "night";
  static const String EVENING_TEMP_KEY = "eve";
  static const String MORNING_TEMP_KEY = "morn";

  // ----------- Weather Json ------------------------------

  static const String WEATHER_ID_KEY = "id";
  static const String WEATHER_MAIN_KEY = "main";
  static const String WEATHER_DESCRIPTION_KEY = "description";
  static const String WEATHER_ICON_KEY = "icon";

  //--------- City Json ----------------------

  static const String CITY_GOE_NAME_ID_KEY = "geoname_id";
  static const String CITY_NAME_KEY = "name";
  static const String CITY_LATITUDE_KEY = "lat";
  static const String CITY_LONGITUDE_KEY = "lon";
  static const String CITY_COUNTRY_CODE_KEY = "country";
  static const String CITY_COUNTRY_ISO_CODE_KEY = "iso2";
  static const String CITY_TYPE_KEY = "type";
  static const String CITY_POPULATION_KEY = "population";
  static const String CITY_COORDINATES_KEY = "coord";
}
