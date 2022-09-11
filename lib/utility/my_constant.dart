import 'package:flutter/material.dart';

class MyConstant {
  //field
  static String appName = 'Nice Cow';
  static Color dark = Colors.black;
  static Color primary = const Color.fromARGB(255, 233, 65, 121);
  static Color active = Colors.pink;
  static Color button = Colors.white;

  //method

  BoxDecoration primaryBox() {
    return BoxDecoration(color: primary.withOpacity(0.75));
  }

  TextStyle h1Style() {
    return TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: dark,
    );
  }

  TextStyle h2Style() {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: dark,
    );
  }

  TextStyle h3Style() {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: dark,
    );
  }

  TextStyle h3HintStyle() {
    return  TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.grey.shade700,
    );
  }

  TextStyle h3ActiveStyle() {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: active,
    );
  }

  TextStyle h3ButtonStyle() {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: button,
    );
  }
}
