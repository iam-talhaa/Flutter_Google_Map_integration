import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_google_map_integration/Data/AppException.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class PlaceScreen extends StatefulWidget {
  const PlaceScreen({super.key});

  @override
  State<PlaceScreen> createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  TextEditingController _controller = TextEditingController();
  var uuid = Uuid();

  String _sessionToken = '12345';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller.addListener(() {
      onchange();
    });
  }

  void onchange() {
    if (_sessionToken.isEmpty) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }

    getSuggestion(_sessionToken);
  }

  List<dynamic> _listPlace = [];

  void getSuggestion(String input) async {
    var kPLACES_API_KEY = 'AIzaSyCm2lSkM98sfRSpJNITnj0m-NMW8Ahs5h8';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));
    print(response.body.toString());
    if (response.statusCode == 200) {
      setState(() {
        _listPlace = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw FetechDataException("Error Occur During Fetching Api");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Center(
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(hintText: "Search Place"),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: _listPlace.length,
              itemBuilder: (Context, index) {
                return ListTile(title: Text(index.toString()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
