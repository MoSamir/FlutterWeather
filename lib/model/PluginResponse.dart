import 'ApiModels.dart';
import 'WeatherModel.dart';

class PluginResponse {
  String requestURL;
  bool isSuccess = true;
  PluginResponse(
      {this.isSuccess, this.errorModel, this.weatherResponse, this.requestURL});
  ErrorViewModel errorModel;
  WeatherForecastModel weatherResponse;

  @override
  String toString() {
    // TODO: implement toString

    String success = 'is response success => $isSuccess';
    String errorIfExist = "";
    String successLengthIfExist = "";
    if (isSuccess)
      successLengthIfExist = 'data => ${weatherResponse.toString()}';
    else
      errorIfExist = "Error accured => ${errorModel?.errorMessage}";

    return success + errorIfExist + successLengthIfExist;
  }
}
