import 'package:flutter/material.dart';

import 'inject.dart';
import 'movies/core/constants.dart';
import 'movies/core/theme.dart';
import 'movies/presentation/tabs.dart';

void main() {
  Inject.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kAppName,
      theme: kThemeData,
      home: const Tabs(),
    );
  }
}
