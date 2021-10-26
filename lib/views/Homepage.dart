import 'package:better_vote/network/NetworkHandler.dart';
import 'package:flutter/material.dart';
import 'dart:convert' show json, base64, ascii;

Map<String, dynamic> getpayloadFromToken(_jsonWebToken) {
  print(_jsonWebToken);
  return json
      .decode(ascii.decode(base64.decode(base64.normalize(_jsonWebToken))));
}

class HomePage extends StatelessWidget {
  HomePage(this._jsonWebToken, this._payloadFromToken, {Key key})
      : super(key: key) {
    print(this._jsonWebToken);
  }
  factory HomePage.fromBase64(String _jsonWebToken) =>
      HomePage(_jsonWebToken, getpayloadFromToken(_jsonWebToken.split(".")[1]));

  final String _jsonWebToken;
  final Map<String, dynamic> _payloadFromToken;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Home")),
        body: Center(
          child: FutureBuilder(
              future: NetworkHandler("/")
                  .fetchData({"Authorization": _jsonWebToken}),
              builder: (context, snapshot) => snapshot.hasData
                  ? Column(
                      children: <Widget>[
                        //This _payloadFromToken has user id, iat=> date user logged in, iat => jsonwebtoken expiry date
                        // Text("${_payloadFromToken.toString()}"),
                        //Get data using id
                        displayUserData(_payloadFromToken['user_id'])
                      ],
                    )
                  : snapshot.hasError
                      ? const Text("An error occurred")
                      : const CircularProgressIndicator()),
        ),
      );

  Widget displayUserData(String _userId) {
    return FutureBuilder(
      future: NetworkHandler("/api/users/")
          .fetchData({"Authorization": _jsonWebToken}),
      builder: userBuilder,
    );
  }

  Widget userBuilder(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.hasData) {
      Map<String, dynamic> _payloadFromUserRequest = json.decode(snapshot.data);
      print(_payloadFromUserRequest.toString());
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
    if (snapshot.hasError) return Text("An error occurred fetching user data.");
    return CircularProgressIndicator();
  }
}
