// Replace with Signup Controller
//import 'package:better_vote/controllers/LoginController.dart';
import 'package:flutter/material.dart';
import 'Homepage.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //Replace with signup controller
  //final _loginController = LoginController();

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

    void handleSignup() async {
      /*
      Implement signup
      */
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
