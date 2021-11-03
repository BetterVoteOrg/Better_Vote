import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class NetworkHandler {
  NetworkHandler(this._path);
  String _path;
  final String _apiHost = "https://bettervote.herokuapp.com";

  // final String _apiHost =
  //     "https://6daf-2600-8807-305-3100-3801-a314-1b31-1f89.ngrok.io";

  Future<http.Response> sendDataToServer(Object _theData) async {
    print(_theData);
    return await http.post(Uri.parse(_apiHost + _path), body: _theData);
  }

  Future<String> fetchData() async {
    final _jsonWebToken = await FlutterSecureStorage().read(key: "jwt");
    return http.read(Uri.parse(_apiHost + _path),
        headers: {"Authorization": "Bearer " + _jsonWebToken});
  }
}

Map<String, dynamic> getpayloadFromToken(_jsonWebToken) {
  return json
      .decode(ascii.decode(base64.decode(base64.normalize(_jsonWebToken))));
}
