import 'package:http/http.dart' as http;

class NetworkHandler {
  NetworkHandler(this._path);
  String _path;
  final String _apiHost = "https://bettervote.herokuapp.com/api";
  // final String _apiHost =
  //     "https://5a09-2600-8807-305-3100-d5ba-7a2f-9541-c218.ngrok.io/api";

  Future<http.Response> sendDataToServer(Object _theData) async {
    print(_theData);
    return await http.post(Uri.parse(_apiHost + _path), body: _theData);
  }

  Future<String> fetchData(Map<String, String> headers) {
    return http.read(Uri.parse(_apiHost + _path), headers: headers);
  }
}
