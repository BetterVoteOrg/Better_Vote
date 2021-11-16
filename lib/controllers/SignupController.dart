import 'package:better_vote/network/NetworkHandler.dart';

class SignupController {
  SignupController();
  String _signupPath = "/signup";

  Future<bool> attemptSignup(Object _signupData) async {
    var response =
        await NetworkHandler(_signupPath).sendDataToServer(_signupData);

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
}
