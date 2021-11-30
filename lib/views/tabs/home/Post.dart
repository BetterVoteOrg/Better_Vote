import 'package:badges/badges.dart';
import 'package:better_vote/models/Poll.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Post extends StatelessWidget {
  Poll poll;
  Widget child;
  Post(this.poll, {Key key, Widget child}) {
    if (child != null) {
      this.child = child;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[child],
    );
  }
}

Widget handlePollStatus(String status) {
  Color color;
  switch (status) {
    case "JUST_CREATED":
      color = Colors.yellow;
      break;
    case "ACTIVE":
      color = Colors.greenAccent;
      break;
    case "ENDED":
      color = Colors.redAccent;
  }

  return Badge(
    toAnimate: false,
    shape: BadgeShape.square,
    badgeColor: color,
    borderRadius: BorderRadius.circular(8),
    badgeContent: Text(status == "JUST_CREATED" ? "NOT STARTED" : status,
        style: TextStyle(
          color: Colors.black,
          fontSize: 10,
        )),
  );
}

class PostTime extends StatelessWidget {
  final String createdTime;
  const PostTime(this.createdTime, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext contxt) {
    var timeDifference = DateTime.now().difference(DateTime.parse(createdTime));
    String getTimeDifference() {
      if (timeDifference.inMinutes <= 1) {
        return "Just now";
      }
      if (timeDifference.inMinutes <= 60) {
        return "${timeDifference.inMinutes} minutes ago";
      }
      if (timeDifference.inHours == 1) {
        return "${timeDifference.inHours} hour ago";
      }
      if (timeDifference.inHours <= 24) {
        return "${timeDifference.inHours} hours ago";
      }

      if (timeDifference.inDays == 1) {
        return "Yesterday";
      }
      return "${timeDifference.inDays} days ago";
    }

    return Expanded(
      flex: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Text(getTimeDifference()),
            ],
          )
        ],
      ),
    );
  }
}
