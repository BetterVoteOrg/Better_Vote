import 'package:better_vote/controllers/UserController.dart';
import 'package:flutter/material.dart';

class HomeTabPage extends StatefulWidget {
  HomeTabPage({Key key}) : super(key: key);
  @override
  State<HomeTabPage> createState() => HomeTabState();
}

class HomeTabState extends State<HomeTabPage> {
  final user = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          builder: homeTabBuilder, future: user.canFindProfileData()),
    );
  }

  Widget homeTabBuilder(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.hasData) {
      const TextStyle optionStyle =
          TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
      return Center(
        child: Text(
          'Index 0: Home',
          style: optionStyle,
        ),
      );
    }
    if (snapshot.hasError) return Text("An error occurred home data.");

    return CircularProgressIndicator();
  }
}
