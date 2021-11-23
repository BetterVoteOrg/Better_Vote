import 'package:better_vote/controllers/PollController.dart';
import 'package:better_vote/models/Poll.dart';
import 'package:flutter/material.dart';
import 'package:better_vote/views/tabs/home/Postcard.dart';

class HomeTabPage extends StatefulWidget {
  HomeTabPage({Key key}) : super(key: key);
  @override
  State<HomeTabPage> createState() => HomeTabState();
}

class HomeTabState extends State<HomeTabPage> {
  final _pollController = PollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          builder: homeTabBuilder, future: _pollController.getPublicPolls()),
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
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
