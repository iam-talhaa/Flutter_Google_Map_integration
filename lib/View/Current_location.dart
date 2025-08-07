import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocation_ extends StatefulWidget {
  const CurrentLocation_({super.key});

  @override
  State<CurrentLocation_> createState() => _CurrentLocation_State();
}

final Completer<GoogleMapController> _controller = Completer();

Future<Position> getUserCurrentLocation() async {
  await Geolocator.requestPermission().then((V) {}).onError((error, s) {
    print(error);
  });

  return Geolocator.getCurrentPosition();
}

final CameraPosition GoogleInitPos = CameraPosition(
  zoom: 14,
  target: LatLng(34.0083, 71.5189),
);

List<Marker> _listOFMarker = [];
final List<Marker> _markers = <Marker>[
  Marker(
    markerId: MarkerId('2'),
    position: LatLng(34.0077, 71.7919),
    infoWindow: InfoWindow(title: "Home Town"),
  ),
  Marker(markerId: MarkerId('1'), position: LatLng(34.0083, 71.5189)),
];

// @override
// initstate() {
//   _listOFMarker.addAll(_markers);
// }

class _CurrentLocation_State extends State<CurrentLocation_> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: GoogleInitPos,

            compassEnabled: true,
            markers: Set<Marker>.of(_markers),
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController Controller) {
              _controller.complete(Controller);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () async {
                  final GoogleMapController Controller =
                      await _controller.future;
                  Controller.moveCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: LatLng(34.0077, 71.7919),
                        zoom: 14,
                      ),
                    ),
                  );
                },
                child: Container(
                  child: Center(
                    child: Text(
                      "MOVE TO LOCATION",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.teal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getUserCurrentLocation()
              .then((v) async {
                print(v.latitude.toString() + " " + v.longitude.toString());

                _markers.add(
                  Marker(
                    markerId: MarkerId('3'),
                    position: LatLng(v.latitude, v.longitude),
                  ),
                );

                CameraPosition cameraPosition = CameraPosition(
                  zoom: 14,
                  target: LatLng(v.latitude, v.longitude),
                );

                final GoogleMapController controller = await _controller.future;

                controller.animateCamera(
                  CameraUpdate.newCameraPosition(cameraPosition),
                );
                setState(() {});
              })
              .onError((error, s) {
                print("$error");
              });
        },
      ),
    );
  }
}
