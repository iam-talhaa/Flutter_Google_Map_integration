import 'dart:convert';
import 'dart:io';
import 'dart:nativewrappers/_internal/vm/lib/convert_patch.dart';

import 'package:flutter/material.dart';
import 'package:flutter_google_map_integration/Data/AppException.dart';
import 'package:flutter_google_map_integration/Data/Network/BaseApiNetwork.dart';
import 'package:http/http.dart' as http;

class Networkapiservice extends Baseapiservices {
  @override
  Future getGetApiResponse(String url) async {
    // TODO: implement getGetApiResponse
    dynamic JsonResponse;
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(Duration(seconds: 10));

      JsonResponse = ReturnResponse(response);
    } on SocketException {
      FetechDataException("No Internet Acesss");
    }

    return JsonResponse;
  }

  @override
  Future getPostApiResponse(String url, body) {
    // TODO: implement getPostApiResponse
    throw UnimplementedError();
  }

  dynamic ReturnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response = jsonDecode(response.body);
      case 404:
        throw unAuthorizedAcces();

      default:
    }
  }
}
