import 'package:better_vote/models/Poll.dart';
import 'package:flutter/material.dart';

class PLURALITYForm extends StatelessWidget {
  final Poll poll;
  const PLURALITYForm(this.poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Text("Testing plurality")],
    );
  }
}
