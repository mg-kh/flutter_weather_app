import 'dart:convert';

WeatherData weatherDataToJson(String str) {
  return WeatherData.fromJson(json.decode(str));
}

class WeatherData {
  late double lat;
  late double long;
  late String timezone;
  late int timezone_offset;
  late Map current;
  late List daily;

  WeatherData({
    required this.lat,
    required this.long,
    required this.timezone,
    required this.timezone_offset,
    required this.current,
    required this.daily,
  });

  factory WeatherData.fromJson(json) {
    return WeatherData(
      lat: json['lat'],
      long: json['lon'],
      timezone: json['timezone'],
      timezone_offset: json['timezone_offset'],
      current: json['current'],
      daily: json['daily'],
    );
  }
}
