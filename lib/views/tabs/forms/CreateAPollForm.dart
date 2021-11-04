import 'package:flutter/material.dart';

class CreateAPollForm extends StatelessWidget {
  const CreateAPollForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const pageTitle = 'Create Poll';
    return MaterialApp(
      title: pageTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(pageTitle),
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: const CustomForm(),
          ),
        ),
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

/*  class MyButton extends StatelessWidget {
    const MyButton({Key key}) : super(key: key);
  

    @override
    Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        const buttonPress = SnackBar(content: Text('Save Poll'));
        ScaffoldMessenger.of(context).showSnackBar(buttonPress);
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(8.0),
      ),
      child: const Text('Save Poll'),
    ),
    );
  }
}
}*/
