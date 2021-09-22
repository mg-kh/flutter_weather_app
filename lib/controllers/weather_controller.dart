import 'package:flutter_geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:weather/models/weather_data_model.dart';
import 'package:weather/services/api_services.dart';

class WeatherController extends GetxController {
  var weatherData = Rxn<WeatherData?>();
  var isLoading = false.obs;
  var locationData = Rx<String?>('');

  Future getWeatherData({lat, long}) async {
    isLoading.value = true;
    try{
      var coordinates = Coordinates(lat, long);
      var location = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      locationData.value = '${location.first.countryName}, ${location.first.subAdminArea}';
    }catch(e){
      locationData.value = "Can't get location data";
    }
    var responseWeatherData = await ApiServices.fetchWeatherData(lat: lat, long: long); // From services

    if (responseWeatherData != null) {
      weatherData(responseWeatherData);
    }
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    getWeatherData(lat: 17.371873, long:96.443244);
  }
}
