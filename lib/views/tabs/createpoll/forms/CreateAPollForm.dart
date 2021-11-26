import 'dart:convert';

import 'package:better_vote/controllers/PollController.dart';
import 'package:better_vote/models/Poll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:date_time_picker/date_time_picker.dart';

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
  TextEditingController _candidateController = TextEditingController();
  TextEditingController _pollTitleController = TextEditingController();
  TextEditingController _pollQuestionController = TextEditingController();
  String _selectedVoteSystem;
  String _startDate;
  String _endDate;
  // ignore: non_constant_identifier_names
  List<String> VoteSystemDropDown = [];
  String pollQuestion = "";
  List<String> _selectedCandidates = [""];
  List<Widget> list;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    List<String> list = VotingSystem.values.map<String>((VotingSystem value) {
      return value.toString().split(".").last;
    }).toList();
    VoteSystemDropDown.addAll(list);
  }

  @override
  Widget build(BuildContext context) {
    getPollData() {
      Object data = {
        'poll_title': _pollTitleController.text,
        'prompt': _pollQuestionController.text,
        'vote_system': _selectedVoteSystem,
        'poll_type': "PUBLIC",
        'candidates': _selectedCandidates.toString(),
        'start_time': _startDate,
        'end_time': _endDate
      };

      return data;
    }

    createNewPoll(pollData) async {
      try {
        bool pollIsCreated =
            await PollController().attempToCreateAPoll(pollData);
        if (pollIsCreated) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: Text("Your poll was created successfully."),
                content: Text("Poll will start on ${this._startDate}")),
          );
        } else
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: Text("Poll submission failure."),
                content: Text("Something went wrong.")),
          );
      } catch (e) {
        print(e.toString());
      }
    }

    return Form(
        key: _formKey,
        child: Column(
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
                child: Text('Choose vote system.')),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: DropdownButton<String>(
                    value: _selectedVoteSystem,
                    iconSize: 24,
                    elevation: 16,
                    onChanged: (String newValue) {
                      if (newValue.length >= 0)
                        setState(() {
                          _selectedVoteSystem = newValue;
                        });
                    },
                    items:
                        VoteSystemDropDown.map((e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            )).toList())),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: _pollQuestionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Description/Prompt/Question',
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
                      _selectedCandidates =
                          _selectedCandidates.toSet().toList();
                      _candidateController.text = "";
                    });
                  },
                  icon: Icon(Icons.add)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: DateTimePicker(
                type: DateTimePickerType.dateTimeSeparate,
                dateMask: 'd MMM, yyyy',
                initialValue:
                    DateTime.now().add(const Duration(minutes: 5)).toString(),
                firstDate: DateTime.now().add(const Duration(minutes: 5)),
                lastDate: DateTime.now().add(const Duration(days: 7)),
                dateLabelText: 'Start Date',
                timeLabelText: "Hour",
                onChanged: (val) {
                  setState(() {
                    _startDate = DateTime.parse(val)
                        .toUtc()
                        .toString()
                        .replaceFirst(" ", "T");
                  });
                },
                onSaved: (val) {
                  setState(() {
                    _startDate = DateTime.parse(val)
                        .toUtc()
                        .toString()
                        .replaceFirst(" ", "T");
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: DateTimePicker(
                type: DateTimePickerType.dateTimeSeparate,
                dateMask: 'd MMM, yyyy',
                initialValue:
                    DateTime.now().add(const Duration(minutes: 10)).toString(),
                firstDate: DateTime.now().add(const Duration(minutes: 10)),
                lastDate: DateTime.now().add(const Duration(days: 14)),
                dateLabelText: 'End Date',
                timeLabelText: "Hour",
                onChanged: (val) {
                  setState(() {
                    _endDate = DateTime.parse(val)
                        .toUtc()
                        .toString()
                        .replaceFirst(" ", "T");
                  });
                },
                onSaved: (val) {
                  setState(() {
                    _endDate = DateTime.parse(val)
                        .toUtc()
                        .toString()
                        .replaceFirst(" ", "T");
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Center(
                child: ElevatedButton(
                  child: Text("Submit Poll"),
                  onPressed: () {
                    setState(() {
                      print("Poll submit");

                      ///MAKE SURE FIELDS ARE VALID BEFORE SUBMISSION, SHOW ERRORS.
                      // print(createPollData());
                      createNewPoll(getPollData());
                    });
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
