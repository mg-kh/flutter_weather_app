import 'package:flutter/material.dart';
import 'package:weather/constants.dart';

class ForecastStatusBlock extends StatelessWidget {
  late final String title;
  late final String result;

  ForecastStatusBlock({
    required this.title,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: kPrimaryColor,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          result,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
