import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:weather/components/current_weather_card.dart';
import 'package:weather/constants.dart';
import 'package:weather/controllers/weather_controller.dart';
import 'package:http/http.dart' as http;

class CurrentWeather extends StatelessWidget {
  final WeatherController weatherController = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: Text('Current Weather Data'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: kSecondaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      weatherController.getWeatherData();
                    },
                    child: Text('Fetch Data'),
                  ),
                  //  Weather Result
                  Obx(() {
                    if (weatherController.isLoading.value) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return CurrentWeatherCard();
                    }
                  })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
