import 'package:better_vote/views/tabs/createpoll/forms/CreateAPollForm.dart';
import 'package:flutter/material.dart';

class CreatePollTabPage extends StatefulWidget {
  CreatePollTabPage({Key key}) : super(key: key);
  @override
  State<CreatePollTabPage> createState() => CreatePollState();

  static CreatePollState of(BuildContext context) =>
      context.findAncestorStateOfType<CreatePollState>();
}

class CreatePollState extends State<CreatePollTabPage> {
  GlobalKey<FormState> _formkey =
      GlobalKey<FormState>(debugLabel: '_pollformScreenkey');

  set formData(Map<String, String> data) => setState(() {
        formData = data;
      });

  @override
  Widget build(BuildContext context) {
    const pageTitle = 'Create Poll';
    return Scaffold(
      body: CreateAPollForm(
        key: _formkey,
      ),
      appBar: AppBar(
        title: const Text(pageTitle),
        backgroundColor: Color(0xFF008037),
        automaticallyImplyLeading: false,
      ),
    );
  }
}
