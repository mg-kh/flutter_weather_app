import 'package:get/get.dart';
import 'package:weather/screens/current_weather.dart';
import 'package:weather/screens/map.dart';


List<GetPage> routes = [
  GetPage(name: '/current_weather', page: ()=>CurrentWeather()),
  GetPage(name: '/map', page: ()=>Map()),
];