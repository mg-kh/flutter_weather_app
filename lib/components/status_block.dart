import 'package:flutter/material.dart';

class StatusBlock extends StatelessWidget {
  late final String title;
  late final String result;

  StatusBlock({
    required this.title,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          result,
          style: TextStyle(
            color: Colors.black,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
