import 'package:better_vote/network/NetworkHandler.dart';
import 'package:flutter/material.dart';
import 'dart:convert' show json, base64, ascii;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Map<String, dynamic> getpayloadFromToken(_jsonWebToken) {
  return json
      .decode(ascii.decode(base64.decode(base64.normalize(_jsonWebToken))));
}

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget userBuilder(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.hasData) {
        Map<String, dynamic> _payloadFromUserRequest =
            json.decode(snapshot.data);
        print(_payloadFromUserRequest);
        return Center(
          child: Column(
            children: [
              Text("WELCOME"),
              Text("Username:  " + _payloadFromUserRequest["user_name"]),
              Text("Email: " + _payloadFromUserRequest["email"]),
              Text("Account created: " + _payloadFromUserRequest["created_at"]),
            ],
          ),
        );
      }
      if (snapshot.hasError)
        return Text("An error occurred fetching user data.");
      return CircularProgressIndicator();
    }

    Widget displayUserData(String _jsonWebToken) {
      //This payloadFromToken has user id, iat=> date user logged in, iat => jsonwebtoken expiry date
      //Get data using id
      Map<String, dynamic> _payloadFromToken =
          getpayloadFromToken(_jsonWebToken.split(".")[1]);
      return Center(
        child: FutureBuilder(
          future: NetworkHandler("/api/users/" + _payloadFromToken["user_id"])
              .fetchData(),
          builder: userBuilder,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: FutureBuilder(
            future: FlutterSecureStorage().read(key: "jwt"),
            builder: (context, snapshot) => snapshot.hasData
                ?
                //snapshot.data is the json web token.
                displayUserData(snapshot.data)
                : snapshot.hasError
                    ? const Text("An error occurred logging in.")
                    : const CircularProgressIndicator()),
      ),
    );
  }
}
