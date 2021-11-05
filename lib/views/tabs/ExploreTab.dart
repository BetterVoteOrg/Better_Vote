import 'package:better_vote/controllers/UserController.dart';
import 'package:flutter/material.dart';

class ExploreTabPage extends StatefulWidget {
  ExploreTabPage({Key key}) : super(key: key);
  @override
  State<ExploreTabPage> createState() => ExploreTabState();
}

class ExploreTabState extends State<ExploreTabPage> {
  final user = UserController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          builder: exploreTabBuilder, future: user.canFindProfileData()),
    );
  }

  Widget exploreTabBuilder(
      BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.hasData) {
      const TextStyle optionStyle =
          TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
      return Center(
        child: Text(
          'Index 1: Explore',
          style: optionStyle,
        ),
      );
    }
    if (snapshot.hasError) return Text("An error occurred home data.");

    return CircularProgressIndicator();
  }
}
