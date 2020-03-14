library openweatherapi;

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'model/ApiModels.dart';
import 'model/PluginResponse.dart';
import 'model/WeatherModel.dart';

class WeatherForecastPlugin {
  static const String _BASE_URL =
      "https://api.openweathermap.org/data/2.5/forecast/daily?";

  static Future<PluginResponse> getWeatherForecast(
      {String apiKey,
      int forecastLength = 10,
      double locationLatitude,
      double locationLongitude}) async {
    //-------------  Handle Location Logic ----------------------------- .

    double userLat = locationLatitude, userLon = locationLongitude;
//    if (userLat == null || userLon == null) {
//      Location userCurrentLocation = await _handleLocation();
//      if (userCurrentLocation == null) {
//        return PluginResponse(
//            isSuccess: false,
//            errorModel: ErrorViewModel(
//              statuesCode: 404,
//              errorMessage: 'Unable to reslove user location',
//            ),
//            weatherResponse: null);
//      } else {
//        userLat = userCurrentLocation.latitude;
//        userLon = userCurrentLocation.longitude;
//      }
//    }

    //--------------- Handle Api Call ------------------------------------- .

    String apiURL = _BASE_URL +
        'lat=$userLat' +
        '&lon=$userLon' +
        '&cnt=$forecastLength' +
        '&appid=$apiKey';

    try {
      var response = await http.get(apiURL);
      if (response.statusCode == 200) {
        try {
          return PluginResponse(
            requestURL: apiURL,
            isSuccess: true,
            errorModel: null,
            weatherResponse:
                WeatherForecastModel.fromJson(json.decode(response.body)),
          );
        } catch (ex) {
          return PluginResponse(
            requestURL: apiURL,
            isSuccess: false,
            errorModel: ErrorViewModel(
                statuesCode: response.statusCode,
                errorMessage: 'Response parsing error => $ex'),
            weatherResponse: null,
          );
        }
      } else {
        return PluginResponse(
          requestURL: apiURL,
          isSuccess: false,
          errorModel: ErrorViewModel(
              statuesCode: response.statusCode,
              errorMessage: response.reasonPhrase),
          weatherResponse: null,
        );
      }
    } on SocketException {
      return PluginResponse(
        requestURL: apiURL,
        isSuccess: false,
        errorModel: ErrorViewModel(
            statuesCode: HttpStatus.networkConnectTimeoutError,
            errorMessage: 'Connection timeout'),
        weatherResponse: null,
      );
    } catch (ex) {
      return PluginResponse(
        requestURL: apiURL,
        isSuccess: false,
        errorModel: ErrorViewModel(
            statuesCode: HttpStatus.notFound, errorMessage: ex.toString()),
        weatherResponse: null,
      );
    }
  }

//  static _handleLocation() async {
//    final GeolocationResult locationPermission =
//        await Geolocation.requestLocationPermission();
//
//    if (locationPermission.isSuccessful) {
//      LocationResult userLocation = await Geolocation.lastKnownLocation();
//      if (userLocation != null) {
//        return userLocation.location;
//      } else {
//        return null;
//      }
//    } else {
//      return null;
//    }
//  }
}

/*
https://samples.openweathermap.org/data/2.5/forecast/daily
?lat=35&lon=139&cnt=10
&appid=b1b15e88fa797225412429c1c50c122a1
 */
