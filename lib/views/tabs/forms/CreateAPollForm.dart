import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:date_time_picker/date_time_picker.dart';

class CreateAPollForm extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  CreateAPollForm({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const pageTitle = 'Create Poll';
    return Scaffold(
      appBar: AppBar(
        title: const Text(pageTitle),
        backgroundColor: Color(0xFF008037),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: CustomForm(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text('Save Poll', textAlign: TextAlign.center,),
      ),
    );
  }
}

class CustomForm extends StatefulWidget {
  CustomForm({Key key}) : super(key: key);
  @override
  State<CustomForm> createState() => CustomFormState();
}

class CustomFormState extends State<CustomForm> {
  // TextEditingController _startDateController = TextEditingController();
  // TextEditingController _endDateController = TextEditingController();

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
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: DateTimePicker(
            type: DateTimePickerType.dateTimeSeparate,
            dateMask: 'd MMM, yyyy',
            initialValue: DateTime.now().toString(),
            firstDate: DateTime.now().add(const Duration(minutes: 5)),
            lastDate: DateTime(2025),
            dateLabelText: 'Start Date',
            timeLabelText: "Hour",
            onChanged: (val) => print(val),
            validator: (val) {
              print(val);
              return null;
            },
            onSaved: (val) => print(val),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: DateTimePicker(
            type: DateTimePickerType.dateTimeSeparate,
            dateMask: 'd MMM, yyyy',
            initialValue: DateTime.now().toString(),
            firstDate: DateTime.now().add(const Duration(minutes: 5)),
            lastDate: DateTime(2025),
            dateLabelText: 'End Date',
            timeLabelText: "Hour",
            onChanged: (val) => print(val),
            validator: (val) {
              print(val);
              return null;
            },
            onSaved: (val) => print(val),
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
