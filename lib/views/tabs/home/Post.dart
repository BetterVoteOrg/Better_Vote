import 'package:better_vote/models/Poll.dart';
import 'package:better_vote/views/tabs/home/PostTitleSummary.dart';
import 'package:flutter/material.dart';

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
