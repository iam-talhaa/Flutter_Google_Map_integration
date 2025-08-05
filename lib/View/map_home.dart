import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Marker> _markker = [];
  List<Marker> _list = [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(p_lat, p_lon),
      infoWindow: InfoWindow(title: 'My current Location'),
      draggable: true,
    ),

    Marker(markerId: MarkerId('2'), position: LatLng(34.0150, 71.9744)),
  ];

  Completer<GoogleMapController> _controller = Completer();
  static const p_lat = 34.0119;
  static const p_lon = 71.7985;
  static const CameraPosition _cameraPostion = const CameraPosition(
    target: LatLng(p_lat, p_lon),
    zoom: 14,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _markker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.route),
        onPressed: () async {
          final GoogleMapController controller = await _controller.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: LatLng(34.0150, 71.9744), zoom: 13),
            ),
          );
          setState(() {});
        },
      ),
      body: GoogleMap(
        markers: Set<Marker>.of(_markker),
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        compassEnabled: true,
        onTap: (context) {
          setState(() {});
        },
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },

        initialCameraPosition: _cameraPostion,
      ),
    );
  }
}
