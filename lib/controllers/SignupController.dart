import 'package:better_vote/network/NetworkHandler.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignupController {
  SignupController();
  String _signupPath = "/signup";

  Future<bool> attemptSignup(Object _signupData) async {
    var response =
        await NetworkHandler(_signupPath).sendDataToServer(_signupData);

    if (response.statusCode == 200) {
      // String jsonWebToken = response.body;
      // FlutterSecureStorage().write(key: "jwt", value: jsonWebToken);
      return true;
    }

    return false;
  }
}
