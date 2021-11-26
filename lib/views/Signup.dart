import 'package:better_vote/controllers/LoginController.dart';
import 'package:better_vote/controllers/SignupController.dart';
import 'package:flutter/material.dart';
import 'Homepage.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _useremailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _signupController = SignupController();
  final _loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    bool _isRegistered;

    void handleScreens(BuildContext context, loginData) async {
      _isRegistered = await _signupController.attemptSignup(loginData);
      if (_isRegistered) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
              title: Text("Account Registration Success!"),
              content:
                  Text("${loginData["user_name"]}, welcome to BetterVote.")),
        );
        //Automatically log in user
        bool isLogged = await _loginController.attemptLogIn(loginData);
        if (isLogged) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
          return;
        }
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
              title: Text("An Error Occured"),
              content: Text("Error Logging in.")),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
              title: Text("An Error Occurred"),
              content: Text("Account registration failed.")),
        );
      }
    }

    void handleSignup() async {
      var _userName = _usernameController.text;
      var _password = _passwordController.text;
      var _email = _useremailController.text;
      Object _loginData = {
        "user_name": _userName,
        "email": _email,
        "password": _password
      };

      handleScreens(context, _loginData);
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Sign up"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: _useremailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              ElevatedButton(
                  onPressed: handleSignup, child: const Text("Sign up")),
            ],
          ),
        ));
  }
}
