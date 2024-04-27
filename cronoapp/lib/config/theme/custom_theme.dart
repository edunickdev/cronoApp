import 'package:flutter/material.dart';

List<Color> myListOfColors = [
  Colors.pink,
  Colors.yellow,
  Colors.purple,
  Colors.green,
  Colors.blue,
  Colors.brown,
  Colors.amber,
  Colors.grey,
  Colors.red,
];

class CustomTheme {
  final int selectedColor;
  final bool brightness;

  CustomTheme({required this.selectedColor, required this.brightness});

  ThemeData changeColor() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: myListOfColors[selectedColor],
      brightness: brightness ? Brightness.light : Brightness.dark,
    );
  }
}
