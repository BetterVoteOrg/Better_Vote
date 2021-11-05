import 'package:better_vote/controllers/UserController.dart';
import 'package:better_vote/models/User.dart';
import 'package:flutter/material.dart';

class ProfileTabPage extends StatefulWidget {
  // ProfileTabPage( {Key key}) : super(key: key)
  @override
  State<ProfileTabPage> createState() => ProfileState();
}

class ProfileState extends State<ProfileTabPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          builder: profileBuilder, future: UserController().findProfileData()),
    );
  }

  Widget profileBuilder(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.hasData) {
      User _user = snapshot.data;
      return Center(
        child: Column(
          children: [
            Text("WELCOME"),
            Text("Username:  " + _user.getUsername()),
            Text("Email: " + _user.getEmail()),
            Text("Account created: " + _user.getCreatedAt()),
          ],
        ),
      );
    }
    if (snapshot.hasError) return Text("An error occurred fetching user data.");

    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
