import 'package:better_vote/controllers/UserController.dart';
import 'package:flutter/material.dart';

class ProfileTabPage extends StatefulWidget {
  ProfileTabPage({Key key}) : super(key: key);
  @override
  State<ProfileTabPage> createState() => ProfileState();
}

class ProfileState extends State<ProfileTabPage> {
  final user = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          builder: profileBuilder, future: user.canFindProfileData()),
    );
  }

  Widget profileBuilder(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.hasData) {
      return Center(
        child: Column(
          children: [
            Text("WELCOME"),
            Text("Username:  " + user.getUsername()),
            Text("Email: " + user.getEmail()),
            Text("Account created: " + user.getCreatedAt()),
          ],
        ),
      );
    }
    if (snapshot.hasError) return Text("An error occurred fetching user data.");

    return CircularProgressIndicator();
  }
}
