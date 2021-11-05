import 'package:better_vote/controllers/UserController.dart';
import 'package:flutter/material.dart';
import 'package:better_vote/views/widgets/postcard.dart';

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
      return Scaffold(
        appBar: AppBar(
          title: Text("Polls"),
          backgroundColor: Color(0xFF008037),
          automaticallyImplyLeading: false,
        ),
        body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return PostCard();
          },
        ),
      );
    }
    if (snapshot.hasError) return Text("An error occurred home data.");

    return CircularProgressIndicator();
  }
}
