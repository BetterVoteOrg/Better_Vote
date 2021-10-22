import 'package:better_vote/network/NetworkHandler.dart';
import 'package:flutter/material.dart';
import 'dart:convert' show json, base64, ascii;

Map<String, dynamic> getPayload(jwt) {
  return json
      .decode(ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1]))));
}

class HomePage extends StatelessWidget {
  const HomePage(this.jwt, this.payload, {Key key}) : super(key: key);

  factory HomePage.fromBase64(String jwt) => HomePage(jwt, getPayload(jwt));

  final String jwt;
  final Map<String, dynamic> payload;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Home")),
        body: Center(
          child: FutureBuilder(
              future: NetworkHandler("/").fetchData({"Authorization": jwt}),
              builder: (context, snapshot) => snapshot.hasData
                  ? Column(
                      children: <Widget>[
                        Text("${payload['user_id']}, here's the data:"),
                        Text(snapshot.data.toString(),
                            style: Theme.of(context).textTheme.bodyText1)
                      ],
                    )
                  : snapshot.hasError
                      ? const Text("An error occurred")
                      : const CircularProgressIndicator()),
        ),
      );
}
