import 'package:better_vote/controllers/LoginController.dart';
import 'package:flutter/material.dart';
import 'Homepage.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    bool _isLogged;
    void handleScreens(BuildContext context) {
      if (_isLogged) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
              title: Text("An Error Occurred"),
              content: Text(
                  "No account was found matching that username and password")),
        );
      }
    }

    void handleLogin() async {
      var _userName = _usernameController.text;
      var _password = _passwordController.text;
      _isLogged = await _loginController
          .attemptLogIn({"user_name": _userName, "password": _password});
      handleScreens(context);
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Log In"),
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
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              ElevatedButton(
                  onPressed: handleLogin, child: const Text("Log In")),
            ],
          ),
        ));
  }
}
