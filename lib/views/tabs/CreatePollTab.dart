import 'package:better_vote/controllers/UserController.dart';
import 'package:better_vote/views/tabs/forms/CreateAPollForm.dart';
import 'package:flutter/material.dart';

class CreatePollTabPage extends StatefulWidget {
  CreatePollTabPage({Key key}) : super(key: key);
  @override
  State<CreatePollTabPage> createState() => CreatePollState();
}

class CreatePollState extends State<CreatePollTabPage> {
  final user = User();
  @override
  Widget build(BuildContext context) {
    // const TextStyle optionStyle =
    //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    return Scaffold(body: CreateAPollForm()

        //     Center(
        //   child: Text(
        //     'Index 2: Create Poll',
        //     style: optionStyle,
        //   ),
        // )
        // FutureBuilder(
        //     builder: profileBuilder, future: user.canFindProfileData()),
        );
  }
}
