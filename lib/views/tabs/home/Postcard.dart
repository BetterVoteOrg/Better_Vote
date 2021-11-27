import 'package:better_vote/models/Poll.dart';
import 'package:flutter/material.dart';
import 'package:better_vote/helper/demoValues.dart';
import 'package:better_vote/helper/descriptionTextWidget.dart';
import 'package:better_vote/views/tabs/home/PollDisplay.dart';
import 'package:better_vote/helper/profilePics.dart';

class PostCard extends StatelessWidget {
  final Poll poll;
  const PostCard(this.poll, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String image = poll.getImageUrl();

    return Column(children: <Widget>[
      GestureDetector(
        onTap: () {
          //print("tapped");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PollDisplay(poll)),
          );
        },
        child: Card(
          margin: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PostDetails(poll),
              image == 'no image' || image == null
                  ? Container()
                  : AspectRatio(
                      aspectRatio: 18.0 / 13.0,
                      child: Image.network(
                        image,
                        fit: BoxFit.fill,
                      ),
                    ),
              Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                  child: _Post(poll)),
            ],
          ),
        ),
      )
    ]);
  }
}

class _Post extends StatelessWidget {
  final Poll poll;
  const _Post(this.poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[_PostTitleAndSummary(poll)],
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

          SizedBox(height: 1),
          // Text(summary, style: TextStyle(fontSize: 14)),
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
        SizedBox(width: 5),
        _UserImage(),
        SizedBox(width: 10),
        _UserName(poll.getCreator().getUsername()),
        _PostTime(poll.getStartTime()),
        SizedBox(width: 5)
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
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(ProfilePics.janedoeProfilePic),
          ),
        ],
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
