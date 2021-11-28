import 'package:better_vote/controllers/PollController.dart';
import 'package:better_vote/models/Poll.dart';
import 'package:flutter/material.dart';
import 'package:better_vote/views/tabs/home/Postcard.dart';
import 'package:flutter/rendering.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class HomeTabPage extends StatefulWidget {
  HomeTabPage({Key key}) : super(key: key);
  @override
  State<HomeTabPage> createState() => HomeTabState();
}

class HomeTabState extends State<HomeTabPage> with SingleTickerProviderStateMixin {
  final _pollController = PollController();

  final _controller = ScrollController();

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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white70,
        appBar: ScrollAppBar(
          controller: _controller, 
          title: Image.asset('images/better_vote_logo.png', height: 50),
          backgroundColor: Colors.white,
          elevation: 0.5,
          automaticallyImplyLeading: false,),
        body: ListView.builder(
          controller: _controller,
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
