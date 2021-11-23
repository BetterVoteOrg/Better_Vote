import 'package:better_vote/models/Poll.dart';
import 'package:flutter/material.dart';

class STARForm extends StatelessWidget {
  final Poll poll;
  const STARForm(this.poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [Text("Testing star")],
      ),
    );
  }
}
