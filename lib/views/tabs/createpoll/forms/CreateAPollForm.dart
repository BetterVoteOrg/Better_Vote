import 'package:better_vote/models/Poll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:http/http.dart';

typedef void FormDataCallback(Map<String, dynamic> val);

class CreateAPollForm extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  final FormDataCallback callback;
  CreateAPollForm({this.callback, Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(),
        child: CustomForm(),
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
  TextEditingController _pollTitleController = TextEditingController();
  TextEditingController _pollQuestionController = TextEditingController();
  TextEditingController _voteSystemController = TextEditingController();
  TextEditingController _pollTypeController = TextEditingController();
  String _selectedVoteSystem;
  String _startDate;
  String _endDate;
  // ignore: non_constant_identifier_names
  List<String> VoteSystemDropDown = ["-"];
  String pollQuestion = "";

  List<String> _selectedCandidates = [""];
  List<Widget> list;

  @override
  void initState() {
    super.initState();
    // VoteSystemDropDown.add("None");
    //_selectedVoteSystem = "None";
    List<String> list = VotingSystem.values.map<String>((VotingSystem value) {
      return value.toString().split(".").last;
    }).toList();

    VoteSystemDropDown.addAll(list);
  }

  @override
  Widget build(BuildContext context) {
    print(VoteSystemDropDown);

    createPollData() {
      return {
        "poll_title": _pollTitleController.text,
        "prompt": "",
        "vote_system": _selectedVoteSystem,
        "poll_type": _selectedVoteSystem,
        "candidates": _selectedCandidates,
        "start_time": _startDate,
        "end_time": _endDate
      };
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
                controller: _pollTitleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Poll Title',
                ))),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: DropdownButton<String>(
                value: _selectedVoteSystem,
                iconSize: 24,
                elevation: 16,
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  if (newValue.length >= 0)
                    setState(() {
                      _selectedVoteSystem = newValue;
                    });
                },
                items: VoteSystemDropDown.map((e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    )).toList())),
        /*Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Description',
            ),
          ),
        ),*/
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
            itemCount: _selectedCandidates.length,
            itemBuilder: (context, index) {
              var candidateNum = (index + 1);
              return InputChip(
                // avatar: Icon(Icons.remove),
                label: Text("$candidateNum. ${_selectedCandidates[index]}"),
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
                  _selectedCandidates.remove("");
                  _selectedCandidates.add(_candidateController.text);
                  _selectedCandidates = _selectedCandidates.toSet().toList();
                });
              },
              icon: Icon(Icons.add)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: DateTimePicker(
            type: DateTimePickerType.dateTimeSeparate,
            dateMask: 'd MMM, yyyy',
            // controller: _startDateController,
            initialValue:
                DateTime.now().add(const Duration(minutes: 5)).toString(),
            firstDate: DateTime.now().add(const Duration(minutes: 5)),
            lastDate: DateTime.now().add(const Duration(days: 7)),
            dateLabelText: 'Start Date',
            timeLabelText: "Hour",
            onChanged: (val) {
              print(val);
            },
            validator: (val) {
              print(val);
              return null;
            },
            onSaved: (val) {
              print(val);
              setState(() {
                var date = DateTime.now().toUtc();
                print(date);
                //Convert to GMT

                _startDate = val;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: DateTimePicker(
            type: DateTimePickerType.dateTimeSeparate,
            dateMask: 'd MMM, yyyy',
            // controller: _endDateController,
            initialValue:
                DateTime.now().add(const Duration(minutes: 10)).toString(),
            firstDate: DateTime.now().add(const Duration(minutes: 10)),
            lastDate: DateTime.now().add(const Duration(days: 14)),
            dateLabelText: 'End Date',
            timeLabelText: "Hour",
            onChanged: (val) => print(val),
            validator: (val) {
              print(val);
              return null;
            },
            onSaved: (val) {
              print(val);
              setState(() {
                _endDate = val;
              });
            },
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
