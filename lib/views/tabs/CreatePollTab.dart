import 'package:better_vote/controllers/UserController.dart';
import 'package:flutter/material.dart';

class CreatePollPage extends StatefulWidget {
  CreatePollPage({Key key}) : super(key: key);
  @override
  State<CreatePollPage> createState() => CreatePollState();
}

class CreatePollState extends State<CreatePollPage> {
  final user = User();
  @override
  Widget build(BuildContext context) {
    const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    return Scaffold(
        body: Center(
      child: Text(
        'Index 2: Create Poll',
        style: optionStyle,
      ),
    )
        // FutureBuilder(
        //     builder: profileBuilder, future: user.canFindProfileData()),
        );
  }
}
