import 'dart:async';
// import 'dart:convert' as ui;
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerScreen extends StatefulWidget {
  const CustomMarkerScreen({super.key});

  @override
  State<CustomMarkerScreen> createState() => _CustomMarkerScreenState();
}

class _CustomMarkerScreenState extends State<CustomMarkerScreen> {
  final List<Marker> _marker = <Marker>[];
  String laAdress = '';
  String STAdress = '';
  final List<LatLng> _latlng = [
    LatLng(34.0081, 71.5898),
    LatLng(34.0025, 71.5683),
    LatLng(34.0116, 71.5486),
    LatLng(34.0002, 71.5380),
    LatLng(34.0123, 71.5645),
    LatLng(34.0128, 71.5525),
    LatLng(34.0162, 71.5554),
    LatLng(34.0101, 71.5537),
    LatLng(34.0008, 71.5530),
    LatLng(33.9965, 71.6204),
  ];

  List<String> _images = [
    'images/car.png',
    'images/car2.png',
    'images/marker2.png',
    'images/marker3.png',
    'images/car.png',
    'images/motorcycle.png',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    LoadData();
  }

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: 60,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(
      format: ui.ImageByteFormat.png,
    ))!.buffer.asUint8List();
  }

  void LoadData() async {
    for (int i = 0; i < _images.length; i++) {
      final Uint8List markerIcon = await getBytesFromAssets(_images[i], 100);
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _latlng[i].latitude,
        _latlng[i].longitude,
      );
      STAdress =
          placemarks.reversed.last.street.toString() +
          placemarks.reversed.last.locality.toString() +
          placemarks.reversed.last.administrativeArea.toString();
      placemarks.reversed.last.subAdministrativeArea.toString();

      _marker.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: _latlng[i],
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(title: STAdress),
        ),
      );
      setState(() {});
    }
  }

  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition firstPosition = CameraPosition(
    target: LatLng(34.0083, 71.5189),
    zoom: 14,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: firstPosition,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController Controller) {
          _controller.complete(Controller);
        },
      ),
    );
  }
}
