import 'package:flutter/material.dart';
import 'package:winwatt_solar_simulator/simulator_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculator",
      home: Calculator()
    );
  }
}


