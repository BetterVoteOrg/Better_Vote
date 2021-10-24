import 'package:better_vote/network/NetworkHandler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginController {
  LoginController();
  String _loginPath = "/users/login";
  String jsonWebToken;

  Future<bool> attemptLogIn(Object _loginData) async {
    var response =
        await NetworkHandler(_loginPath).sendDataToServer(_loginData);

    if (response.statusCode == 200) {
      jsonWebToken = response.body;
      FlutterSecureStorage().write(key: "jwt", value: jsonWebToken);
      return true;
    }

    return false;
  }
}
