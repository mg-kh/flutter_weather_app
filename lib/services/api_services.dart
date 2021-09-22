import 'package:http/http.dart' as http;
import 'package:weather/models/weather_data_model.dart';

class ApiServices {
  static var client = http.Client();

  static Future<WeatherData?> fetchWeatherData({lat, long}) async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&exclude=minutely,hourly,alerts&appid=89202b2d385c5c15c54e4aa3d53637e1&units=metric');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      // return null;
      // print(weatherDataFromJson(jsonString));
      return weatherDataFromJson(jsonString);
    } else {
      return null;
    }
  }
}
