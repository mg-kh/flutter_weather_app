import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/constants.dart';
import 'package:weather/routes.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Nunito'),
      home: SafeArea(
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explore',
                      style: kHomeScreenTextStyle,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Weather',
                      style: kHomeScreenTextStyle,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Data',
                      style: kHomeScreenTextStyle,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Explore weather conditions\n in other countries.',
                      style: kHomeScreenDesTextStyle,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    //Button
                    SizedBox(
                      width: 130,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed('/map');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Explore'),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.arrow_right_alt,
                              size: 20,
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: kSecondaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                      ),
                    ),
                  ],
                ),
              ),

              //! Top svg
              Positioned(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    child: SvgPicture.asset('assets/images/top.svg'),
                  ),
                ),
              ),

              //! Bottom svg
              Positioned(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    child: SvgPicture.asset('assets/images/bottom.svg'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
