import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class CoversionToAdress extends StatefulWidget {
  const CoversionToAdress({super.key});

  @override
  State<CoversionToAdress> createState() => _CoversionToAdressState();
}

class _CoversionToAdressState extends State<CoversionToAdress> {
  String laAdress = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              final Location = await locationFromAddress(
                "Gronausestraat 710, Enschede",
              );

              setState(() {
                laAdress =
                    Location.last.longitude.toString() +
                    '' +
                    Location.first.latitude.toString();
              });
              print(laAdress);
            },
            child: Center(
              child: Container(
                height: 45,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(child: Text("Convert")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
