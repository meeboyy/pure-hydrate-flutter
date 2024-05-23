import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pure_hydrate/beranda.dart';
import 'package:pure_hydrate/models/settings_model.dart';
import 'package:pure_hydrate/models/water_intake_model.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MaterialApp(title: 'Water Reminder', home: MyHomePage());
  }
}
