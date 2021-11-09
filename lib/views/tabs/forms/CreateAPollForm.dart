import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:http/http.dart';

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
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: CustomForm(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text(
          'Save Poll',
          textAlign: TextAlign.center,
        ),
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
  TextEditingController _candidateController = TextEditingController();
  List<String> candidates = [""];
  List<Widget> list;

  @override
  void initState() {
    super.initState();
  }

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
          child: Text("Add Candidates"),
        ),
        Container(
          height: 80,
          color: Color(000),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: candidates.length,
            itemBuilder: (context, index) {
              var candidateNum = (index + 1);
              return InputChip(
                // avatar: Icon(Icons.remove),
                label: Text("$candidateNum. ${candidates[index]}"),
                onSelected: (bool value) {},
              );
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            controller: _candidateController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Start typing and press +',
            ),
          ),
        ),
        Center(
          child: IconButton(
              onPressed: () {
                setState(() {
                  candidates.remove("");
                  candidates.add(_candidateController.text);
                  candidates = candidates.toSet().toList();
                });
              },
              icon: Icon(Icons.add)),
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
