import 'package:better_vote/models/Poll.dart';
import 'package:flutter/material.dart';
import 'package:better_vote/helper/demoValues.dart';
import 'package:better_vote/helper/descriptionTextWidget.dart';
import 'package:better_vote/views/PollDisplay.dart';
import 'package:flutter/semantics.dart';

class PostCard extends StatelessWidget {
  final Poll poll;
  const PostCard(this.poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return AspectRatio(
    return GestureDetector(
      child: AspectRatio(
        aspectRatio: 5 / 2,
        child: Card(
          child: Column(children: <Widget>[_PostDetails(poll), _Post(poll)]),
        ),
      ),
      onTap: () {
        //print("tapped");
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => PollDisplay(poll)),
            );
      },
    );
  }
}

class _Post extends StatelessWidget {
  final Poll poll;
  const _Post(this.poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Row(
        children: <Widget>[_PostTitleAndSummary(poll)],
      ),
    );
  }
}

class _PostTitleAndSummary extends StatelessWidget {
  final Poll poll;
  const _PostTitleAndSummary(this.poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final TextStyle titleTheme = Theme.of(context).textTheme.title;
    //final TextStyle summaryTheme = Theme.of(context).textTheme.body1;
    final String title = poll.getTitle();
    final String summary = poll.getQuestion();

    return Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 1),
          //Text(summary, style: TextStyle(fontSize: 14)),
          new DescriptionTextWidget(text: summary),
        ],
      ),
    );
  }
}

/* For later use if we want to do post images
class _PostImage extends StatelessWidget {
  const _PostImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(flex: 2, child: Image.asset(DemoValues.userImage));
  }
}
*/

class _PostDetails extends StatelessWidget {
  final Poll poll;
  const _PostDetails(this.poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _UserImage(),
        _UserName(poll.getCreator().getUsername()),
        _PostTime(poll.getStartTime())
      ],
    );
  }
}

class _UserName extends StatelessWidget {
  final username;
  const _UserName(this.username, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(username),
        ],
      ),
    );
  }
}

class _UserImage extends StatelessWidget {
  const _UserImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: CircleAvatar(
        backgroundImage: AssetImage(DemoValues.userImage),
      ),
    );
  }
}

class _PostTime extends StatelessWidget {
  final String startTime;
  const _PostTime(this.startTime, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext contxt) {
    //To use later
    var timeDifference =
        DateTime.now().difference(DateTime.parse(startTime)).inHours;

    return Expanded(
      flex: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(DemoValues.postTime),
        ],
      ),
    );
  }
}
