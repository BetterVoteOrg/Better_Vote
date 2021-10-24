import 'package:better_vote/network/NetworkHandler.dart';
import 'package:flutter/material.dart';
import 'dart:convert' show json, base64, ascii;

Map<String, dynamic> getPayload(_jsonWebToken) {
  return json
      .decode(ascii.decode(base64.decode(base64.normalize(_jsonWebToken))));
}

class HomePage extends StatelessWidget {
  HomePage(this._jsonWebToken, this.payload, {Key key}) : super(key: key) {
    print(this._jsonWebToken);
  }
  factory HomePage.fromBase64(String _jsonWebToken) =>
      HomePage(_jsonWebToken, getPayload(_jsonWebToken.split(".")[1]));

  final String _jsonWebToken;
  final Map<String, dynamic> payload;

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
                        //This payload has user id, iat=> date user logged in, iat => jsonwebtoken expiry date
                        Text("${payload.toString()}"),

                        // Text(snapshot.data.toString(),
                        //     style: Theme.of(context).textTheme.bodyText1)

                        //Get data using id
                        displayUserData(payload['user_id'])
                      ],
                    )
                  : snapshot.hasError
                      ? const Text("An error occurred")
                      : const CircularProgressIndicator()),
        ),
      );

  Widget displayUserData(String _userId) {
    return FutureBuilder(
      future: NetworkHandler("/users/" + _userId)
          .fetchData({"Authorization": _jsonWebToken}),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.toString());
        }
        return Text("User not found");
      },
    );
  }
}
