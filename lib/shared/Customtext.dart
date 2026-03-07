// ignore: file_names
import 'package:flutter/material.dart';

class Customtext extends StatelessWidget {
  const Customtext({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    this.centerLastWord = false,
    this.textBaseline,
    this.decoration,
    this.decorationColor,
    this.maxLines,
  });

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final bool centerLastWord;
  final TextBaseline? textBaseline;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    if (!centerLastWord) {
      return Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start, // ✅ الحل هنا
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          decoration: decoration,
          decorationColor: decorationColor,
        ),
      );
    }

    List<String> words = text.split(" ");
    String lastWord = words.removeLast();
    String firstPart = words.join(" ");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // ✅ مهم
      children: [
        Text(
          firstPart,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
          ),
        ),
        Text(
          lastWord,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
          ),
        ),
      ],
    );
  }
}
