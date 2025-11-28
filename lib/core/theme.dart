import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFFC6011); // Orange shade
const Color secondaryColor = Color(0xFF4A4B4D);
const Color backgroundColor = Color(0xFFF2F2F2);
const Color textColor = Color(0xFF4A4B4D);

final ThemeData appTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: backgroundColor,
  fontFamily: 'Montserrat', // You can use Google Fonts later
  textTheme: const TextTheme(bodyMedium: TextStyle(color: textColor)),
);
