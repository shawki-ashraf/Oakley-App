import 'package:flutter/material.dart';
import 'package:furneture_app/shared/Customtext.dart';

class CheckData extends StatelessWidget {
  final String title;
  final String value;
  const CheckData({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Customtext(
          text: title,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        Customtext(
          text: value,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ],
    );
  }
}
