import 'package:better_vote/views/tabs/forms/CreateAPollForm.dart';
import 'package:flutter/material.dart';

class CreatePollTabPage extends StatefulWidget {
  CreatePollTabPage({Key key}) : super(key: key);
  @override
  State<CreatePollTabPage> createState() => CreatePollState();
}

class CreatePollState extends State<CreatePollTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CreateAPollForm());
  }
}
