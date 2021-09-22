import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/components/status_block.dart';
import 'package:weather/constants.dart';
import 'package:weather/controllers/weather_controller.dart';


class CurrentWeatherCard extends StatelessWidget {
  final WeatherController weatherController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        //Base
        Container(
          width: kCurrentWeatherResultBaseWidth,
          height: kCurrentWeatherResultBaseHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kCurrentWeatherResultBr),
            color: kSecondaryColor.withOpacity(0.5),
          ),
        ),

        //Top
        Positioned(
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              width: kCurrentWeatherResultBaseWidth - 30,
              height: kCurrentWeatherResultBaseHeight + 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kCurrentWeatherResultBr),
                color: kSecondaryColor,
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${weatherController.weatherData.value!.current.weather[0].main}',
                        style: TextStyle(
                          fontSize: kWeatherStatusTextSize,
                          color: kPrimaryColor,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: kPrimaryColor.withOpacity(0.2),
                      child: Image.network(
                        'http://openweathermap.org/img/wn/${weatherController.weatherData.value!.current.weather[0].icon}@2x.png',
                        loadingBuilder: (context, child, progress){
                          return progress == null ? child : CircularProgressIndicator(
                            color: kSecondaryColor,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('${weatherController.weatherData.value!.current.weather[0].description}',
                        style: TextStyle(
                          fontSize: kWeatherStatusTextSize,
                          color: kPrimaryColor,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        StatusBlock(
                          title: 'Temp',
                          result: '${weatherController.weatherData.value!.current.temp}',
                        ),
                        StatusBlock(
                          title: 'Wind',
                          result: '${weatherController.weatherData.value!.current.windSpeed}',
                        ),
                        StatusBlock(
                          title: 'Humidity',
                          result: '${weatherController.weatherData.value!.current.humidity}',
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
