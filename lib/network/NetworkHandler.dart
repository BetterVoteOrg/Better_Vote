import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class NetworkHandler {
  NetworkHandler(this._path);
  String _path;
  final String _apiHost = "https://bettervote.herokuapp.com";
  Future<http.Response> sendDataToServer(Map<String, dynamic> _theData) async {
    try {
      final _jsonWebToken = await FlutterSecureStorage().read(key: "jwt");
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      };
      if (_jsonWebToken != null)
        headers['Authorization'] = 'Bearer ' + _jsonWebToken;
      print(jsonEncode(_theData));
      return await http
          .post(
        Uri.parse(_apiHost + _path),
        headers: headers,
        body: jsonEncode(_theData),
      )
          .onError((error, stackTrace) {
        print(stackTrace.toString());
        throw error;
      });
    } catch (error) {
      throw error;
    }
  }

  Future<String> fetchData() async {
    try {
      final _jsonWebToken = await FlutterSecureStorage().read(key: "jwt");
      return await http.read(Uri.parse(_apiHost + _path), headers: {
        "Authorization": "Bearer " + _jsonWebToken
      }).onError((error, stackTrace) {
        print(stackTrace.toString());
        throw error;
      });
    } catch (error) {
      throw error;
    }
  }
}

Map<String, dynamic> getpayloadFromToken(_jsonWebToken) {
  return json
      .decode(ascii.decode(base64.decode(base64.normalize(_jsonWebToken))));
}

var dummy = {
  "poll_title": "STAR POLL DEPLOYED",
  "prompt":
      "Baton Rouge, Louisiana’s capital Country, visit the capitol buildings or check out the Shaw Center for the arts.",
  "vote_system": "STAR",
  "poll_type": "PUBLIC",
  "candidates": [
    "Ruth's Chris Steak House",
    "Anthony's Italian Deli",
    "Parrain's Seafood Restaurant",
    "Albasha Greek & Lebanese"
  ],
  "start_time": "2022-11-12T17:42:00.042Z",
  "end_time": "2022-11-12T17:45:00.042Z"
};
