import 'package:flutter/material.dart';

class AppStyles {
  static Color bgColor = Colors.black;
  static Color buttonTextColor = Colors.white;
  static Color buttonBackgroundColor = Colors.black;
  static Color buttonDisabledBackgroundColor = const Color(0xCCCCCC);
  static Color defaultBorderColor = const Color(0xFFEEEEEE);

  static TextStyle GetCounterTextStyleByWidth(double w) {
    return TextStyle(
      // fontFamily: 'Inter',
      fontSize: (w / 5),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle GetIncrementerTextStyleByWidth(double w) {
    return TextStyle(
      // fontFamily: 'Inter',
      fontSize: (w / 7.5),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle GetSignageTextStyleByWidth(double w) {
    return TextStyle(
      // fontFamily: 'Inter',
      fontSize: (w / 7.5),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle GetTitleTextStyleByWidth(double w) {
    return TextStyle(
      // fontFamily: 'Inter',
      fontSize: (w / 10),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle GetSubTitleTextStyleByWidth(double w) {
    return TextStyle(
      // fontFamily: 'Inter',
      fontSize: (w / 12),
    );
  }

  static TextStyle GetHeadingTextStyleByWidth(double w) {
    return TextStyle(
      // fontFamily: 'Inter',
      fontSize: (w / 18),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle GetSubHeadingTextStyleByWidth(double w) {
    return TextStyle(
      // fontFamily: 'Inter',
      fontSize: (w / 20),
    );
  }

  static TextStyle GetPTextStyleByWidth(double w) {
    return TextStyle(
      // fontFamily: 'Inter',
      fontSize: (w / 22),
    );
  }

  static TextStyle GetDisclaimerStyleByWidth(double w) {
    return TextStyle(
      // fontFamily: 'Inter',
      color: Colors.grey,
      fontSize: (w / 30),
    );
  }

  static TextStyle GetButtonTextStyleByWidth(double w) {
    return TextStyle(
      // fontFamily: 'Inter',
      fontSize: (w / 22),
    );
  }
}
