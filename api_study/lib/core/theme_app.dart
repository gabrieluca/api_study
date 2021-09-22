import 'package:flutter/material.dart';

final kThemeApp = ThemeData(
  brightness: Brightness.dark,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primarySwatch: Colors.red,
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
  ),
);
