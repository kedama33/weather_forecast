import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_forecast/providers/weathers.dart';
import 'package:weather_forecast/screens/screen_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Weathers(),
      child: const MaterialApp(
        home: ScreenHome(),
      ),
    );
  }
}
