import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:weather/components/forecast_status_block.dart';
import 'package:weather/components/status_block.dart';
import 'package:weather/constants.dart';
import 'package:get/get.dart';
import 'package:weather/controllers/weather_controller.dart';

class Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WeatherController weatherController = Get.put(WeatherController());
    MapController mapController = MapController();
    var pos = LatLng(20.46, 96.33).obs;
    var zoomLevel = 5.0.obs;
    void zoomIncre() {
      zoomLevel.value++;
      mapController.move(pos.value, zoomLevel.value);
    }

    void zoomDecre() {
      zoomLevel.value--;
      mapController.move(pos.value, zoomLevel.value);
    }

    void zoomReset(){
      zoomLevel.value = 3.0;
      mapController.move(pos.value, zoomLevel.value);
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Obx(() => Container(
                child: FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    minZoom: 3,
                      center: pos.value,
                      zoom: zoomLevel.value,
                      onTap: (tapPosition, point) async {
                        pos(point);
                        print(point);
                        await weatherController.getWeatherData(
                            lat: pos.value.latitude, long: pos.value.longitude);
                        print('Data is ==> $weatherController.weatherData.value');
                        if(weatherController.weatherData.value == null){
                          Get.defaultDialog(
                            title: 'Error!',
                            content: Text('Please choose another place!')
                          );
                        }else{
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) =>
                                showButtonSheet(weatherController),
                            isScrollControlled: true,
                          );
                        }
                      }),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                      attributionBuilder: (_) {
                        return Text("© OpenStreetMap contributors");
                      },
                    ),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: 60.0,
                          height: 90.0,
                          point: pos.value,
                          builder: (ctx) => Container(
                            width: 40,
                            height: 40,
                            child: Obx(() => Icon(
                                  weatherController.isLoading.value
                                      ? Icons.hourglass_bottom
                                      : Icons.location_on,
                                  size: 40,
                                  color: kSecondaryColor,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),

          Obx(() => Positioned(
                left: 30,
                top: 50,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 300, minWidth: 200),
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(
                          width: 15,
                        ),
                        Text('${weatherController.locationData.value}')
                      ],
                    ),
                  ),
                ),
              )),

          //Map controller
          Positioned(
            bottom: 40,
            right: 40,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //reset zoom
                SizedBox(
                  width: 40,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      zoomReset();
                    },
                    child: Icon(Icons.replay),
                    style: ElevatedButton.styleFrom(
                      primary: kSecondaryColor,
                      padding: EdgeInsets.all(0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // minus zoom
                SizedBox(
                  width: 40,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      if (zoomLevel.value > 3) {
                        zoomDecre();
                      }
                    },
                    child: Icon(Icons.remove),
                    style: ElevatedButton.styleFrom(
                      primary: kSecondaryColor,
                      padding: EdgeInsets.all(0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // add zoom
                SizedBox(
                  width: 40,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      if (zoomLevel.value < 13) {
                        zoomIncre();
                      }
                    },
                    child: Icon(Icons.add),
                    style: ElevatedButton.styleFrom(
                        primary: kSecondaryColor, padding: EdgeInsets.all(0)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget showButtonSheet(weatherController) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.8,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: EdgeInsets.only(top: 25, left: 15, right: 15),
          decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40), topLeft: Radius.circular(40))),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Obx(() {
              if (weatherController.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  children: [
                    // Current
                    Container(
                      child: Column(
                        children: [
                          Text(
                            '${weatherController.locationData}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: kSecondaryColor.withOpacity(0.8),
                            child: Image.network(
                                'http://openweathermap.org/img/wn/${weatherController.weatherData.value!.current.weather[0].icon}@2x.png'),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '${weatherController.weatherData.value!.current.weather[0].main}',
                            style: TextStyle(
                                fontSize: kWeatherStatusTextSize,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              StatusBlock(
                                title: 'Temp',
                                result:
                                    '${weatherController.weatherData.value!.current.temp} \u2103',
                              ),
                              StatusBlock(
                                title: 'Wind speed',
                                result:
                                    '${weatherController.weatherData.value!.current.windSpeed}',
                              ),
                              StatusBlock(
                                title: 'Humidity',
                                result:
                                    '${weatherController.weatherData.value!.current.humidity} %',
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    //  Focus
                    foreCastBuilder(weatherController.weatherData.value!.daily)
                  ],
                );
              }
            }),
          ),
        );
      },
    );
  }

  Widget foreCastBuilder(dailyForecast) {
    return Column(
      children: dailyForecast
          .map<Widget>((forecast) => Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.only(left: 15, right: 15),
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: kSecondaryColor,
                ),
                child: Row(
                  children: [
                    //Avatar
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundColor: kPrimaryColor.withOpacity(0.5),
                          radius: 35,
                          child: Image.network(
                              'http://openweathermap.org/img/wn/${forecast.weather[0].icon}@2x.png'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                              color: kPrimaryColor.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text:
                                        '${DateTime.parse(DateTime.fromMillisecondsSinceEpoch(forecast.dt * 1000).toString()).day}/ '),
                                TextSpan(
                                    text:
                                        '${DateTime.parse(DateTime.fromMillisecondsSinceEpoch(forecast.dt * 1000).toString()).month}/ '),
                                TextSpan(
                                    text:
                                        '${DateTime.parse(DateTime.fromMillisecondsSinceEpoch(forecast.dt * 1000).toString()).year}'),
                              ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Weather main
                          Text(
                            '${forecast.weather[0].main}',
                            style:
                                TextStyle(fontSize: 25, color: kPrimaryColor),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            '${forecast.weather[0].description}',
                            style:
                                TextStyle(fontSize: 14, color: kPrimaryColor),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ForecastStatusBlock(
                                title: 'Temp',
                                result: '${forecast.temp.eve} \u2103',
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              ForecastStatusBlock(
                                title: 'Wind speed',
                                result: '${forecast.windSpeed}',
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              ForecastStatusBlock(
                                title: 'Humidity',
                                result: '${forecast.humidity} %',
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ))
          .toList(),
    );
  }
}
