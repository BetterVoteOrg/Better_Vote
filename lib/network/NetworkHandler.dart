import 'package:http/http.dart' as http;

class NetworkHandler {
  NetworkHandler(this.path);
  String path;
  final String host = "https://bettervote.herokuapp.com/api";

  //
  Future<String> attemptLogIn(Object body) async {
    var res = await http.post(Uri.parse(host + path), body: body);
    if (res.statusCode == 200) return res.body;
    return "";
  }

  // Future<int> attemptSignUp(String username, String password) async {
  //   var res = await http.post(Uri.parse(host + path),
  //       body: {"user_name": username, "email": username, "password": password});
  //   return res.statusCode;
  // }

  Future<String> fetchData(Map<String, String> headers) {
    return http.read(Uri.parse(host + path), headers: headers);
  }
}
