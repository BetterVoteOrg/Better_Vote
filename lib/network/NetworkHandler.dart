import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class NetworkHandler {
  NetworkHandler(this._path);
  String _path;
  final String _apiHost = "https://bettervote.herokuapp.com";

  // final String _apiHost =
  //     "https://dba9-2600-8807-305-3100-b492-69a2-ef3-6a46.ngrok.io";

  Future<http.Response> sendDataToServer(Object _theData) async {
    try {
      return await http
          .post(
        Uri.parse(_apiHost + _path),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(_theData),
      )
          .onError((error, stackTrace) {
        throw error;
      });
    } catch (error) {
      throw error;
    }
  }

  Future<String> fetchData() async {
    try {
      final _jsonWebToken = await FlutterSecureStorage().read(key: "jwt");
      return await http.read(Uri.parse(_apiHost + _path),
          headers: {"Authorization": "Bearer " + _jsonWebToken});
    } catch (error) {
      throw error;
    }
  }
}

Map<String, dynamic> getpayloadFromToken(_jsonWebToken) {
  return json
      .decode(ascii.decode(base64.decode(base64.normalize(_jsonWebToken))));
}
