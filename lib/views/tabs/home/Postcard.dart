import 'package:better_vote/models/Poll.dart';
import 'package:better_vote/views/tabs/home/PostTitleSummary.dart';
import 'package:flutter/material.dart';
import 'package:better_vote/helper/demoValues.dart';
import 'package:better_vote/views/tabs/home/PollDisplay.dart';
import 'package:better_vote/helper/profilePics.dart';

import 'Post.dart';

class PostCard extends StatelessWidget {
  final Poll poll;
  const PostCard(this.poll, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
              Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                  child: Post(
                    poll,
                    child: PostTitleAndSummary(poll),
                  )),
            ],
          ),
        ),
      )
    ]);
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
