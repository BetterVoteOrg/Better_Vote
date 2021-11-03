import 'package:flutter/material.dart';

class CreateAPoll extends StatelessWidget {
  const CreateAPoll({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const pageTitle = 'Create Poll';
    return MaterialApp(
      title: pageTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(pageTitle),
        ),
        body: const CustomForm(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Text('Save Poll'),
        ),
      ),
    );
  }
}

class CustomForm extends StatelessWidget {
  const CustomForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
                decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Poll Title',
            ))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Description',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Poll Question',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Poll Choices',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'End Date',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'End Time',
            ),
          ),
        ),
      ],
    );
  }
}
