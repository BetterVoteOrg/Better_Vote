import 'package:better_vote/controllers/PollController.dart';
import 'package:better_vote/models/Poll.dart';
import 'package:flutter/material.dart';
import 'package:better_vote/views/widgets/postcard.dart';

class HomeTabPage extends StatefulWidget {
  HomeTabPage({Key key}) : super(key: key);
  @override
  State<HomeTabPage> createState() => HomeTabState();
}

class HomeTabState extends State<HomeTabPage> {
  final pollController = PollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          builder: homeTabBuilder,
          future: pollController.getUserCreatedPolls()),
    );
  }

  Widget homeTabBuilder(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.hasData) {
      List<Poll> polls = snapshot.data;
      return Scaffold(
        appBar: AppBar(
          title: Text("Polls"),
          backgroundColor: Color(0xFF008037),
          automaticallyImplyLeading: false,
        ),
        body: ListView.builder(
          itemCount: polls.length,
          itemBuilder: (BuildContext context, int index) {
            return PostCard(polls[index]);
          },
        ),
      );
    }
    if (snapshot.hasError) return Text("An error occurred home data.");

    return CircularProgressIndicator();
  }
}
