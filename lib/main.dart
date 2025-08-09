import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_google_map_integration/View/CustomMarker.dart';

void main() {
  runApp(FlutterGoogleMap_());
}

class FlutterGoogleMap_ extends StatefulWidget {
  const FlutterGoogleMap_({super.key});

  @override
  State<FlutterGoogleMap_> createState() => _FlutterGoogleMap_State();
}

class _FlutterGoogleMap_State extends State<FlutterGoogleMap_> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomMarkerScreen(),
    );
  }
}
