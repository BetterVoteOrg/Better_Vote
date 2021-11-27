import 'dart:io';

import 'package:better_vote/controllers/PollController.dart';
import 'package:better_vote/models/Poll.dart';
import 'package:better_vote/network/FileHandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

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
  String _selectedCategory;
  String _selectedVisibility;
  String _startDate;
  String _endDate;

  // ignore: non_constant_identifier_names
  List<String> VoteSystemDropDown = [];
  String pollQuestion = "";
  List<String> _selectedCandidates = [""];
  XFile _selectedImage;
  FileHandler fileHandler = FileHandler();
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
      Map<String, dynamic> data = {
        'poll_title': _pollTitleController.text,
        'prompt': _pollQuestionController.text,
        'vote_system': _selectedVoteSystem,
        'poll_type': 'PUBLIC',
        'candidates': _selectedCandidates,
        'start_time': _startDate,
        'end_time': _endDate,
        'poll_category': _selectedCategory,
      };

      return data;
    }

    createNewPoll(pollData) async {
      try {
        bool pollIsCreated = await PollController()
            .attempToCreateAPoll(pollData, pollImage: _selectedImage);
        if (pollIsCreated) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Container(
                        height: 50,
                        child: Column(
                          children: [
                            Icon(FontAwesomeIcons.checkCircle),
                            Text("Your poll was created!"),
                          ],
                        )),
                    content: Container(
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.twitter,
                                    color: Colors.lightBlue,
                                    size: 20,
                                  ),
                                  Padding(padding: EdgeInsets.all(8)),
                                  Text(
                                    "Share on Twitter",
                                    style: TextStyle(
                                      color: Colors.lightBlue,
                                    ),
                                  )
                                ],
                              ),
                              Padding(padding: EdgeInsets.all(1)),
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.whatsapp,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                  Padding(padding: EdgeInsets.all(8)),
                                  Text(
                                    "Share on Whatsapp",
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  )
                                ],
                              ),
                              Padding(padding: EdgeInsets.all(1)),
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.qrcode,
                                    color: Colors.orange,
                                    size: 20,
                                  ),
                                  Padding(padding: EdgeInsets.all(8)),
                                  Text(
                                    "Share QR Code",
                                    style: TextStyle(
                                      color: Colors.orange,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ));
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
        child: Container(
          color: Colors.grey.shade200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Text("Poll details"),
              ),
              Card(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        child: Text("Poll title"),
                      ),
                      TextField(
                          controller: _pollTitleController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter title',
                          )),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        child: Text("Poll question"),
                      ),
                      TextField(
                        controller: _pollQuestionController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Question',
                        ),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Choose vote system.'),
                              DropdownButton<String>(
                                  value: _selectedVoteSystem,
                                  iconSize: 24,
                                  elevation: 16,
                                  hint: Text("Choose voting system"),
                                  onChanged: (String newValue) {
                                    if (newValue.length >= 0)
                                      setState(() {
                                        _selectedVoteSystem = newValue;
                                      });
                                  },
                                  items: VoteSystemDropDown.map(
                                      (e) => DropdownMenuItem<String>(
                                            value: e,
                                            child: Text(e),
                                          )).toList())
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Text("Poll candidates"),
              ),
              Card(
                  child: Container(
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      color: Color(000),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _selectedCandidates.length,
                        itemBuilder: (context, index) {
                          var candidateNum = (index + 1);
                          return InputChip(
                            label: Text(
                                "$candidateNum. ${_selectedCandidates[index]}"),
                            onSelected: (bool value) {},
                          );
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    Container(
                      width: 300,
                      alignment: Alignment.center,
                      child: TextField(
                          controller: _candidateController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Candidate name',
                            suffixIcon: Wrap(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.image),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _candidateController.clear();
                                  },
                                  icon: Icon(Icons.clear),
                                )
                              ],
                            ),
                          )),
                    ),
                    Center(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        child: Container(
                          width: 300,
                          child: ElevatedButton(
                            child: Text("Add Option"),
                            onPressed: () {
                              setState(() {
                                _selectedCandidates.remove("");
                                _selectedCandidates
                                    .add(_candidateController.text);
                                _selectedCandidates =
                                    _selectedCandidates.toSet().toList();
                                _candidateController.text = "";
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Text("Poll Dates."),
              ),
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: DateTimePicker(
                        type: DateTimePickerType.dateTimeSeparate,
                        dateMask: 'd MMM, yyyy',
                        initialValue: DateTime.now()
                            .add(const Duration(minutes: 5))
                            .toString(),
                        firstDate:
                            DateTime.now().add(const Duration(minutes: 5)),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: DateTimePicker(
                        type: DateTimePickerType.dateTimeSeparate,
                        dateMask: 'd MMM, yyyy',
                        initialValue: DateTime.now()
                            .add(const Duration(minutes: 10))
                            .toString(),
                        firstDate:
                            DateTime.now().add(const Duration(minutes: 10)),
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
                      padding: EdgeInsets.symmetric(vertical: 15),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Text('Other options.'),
              ),
              Container(
                width: double.infinity,
                child: Card(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Poll category'),
                            DropdownButton<String>(
                                value: _selectedCategory,
                                iconSize: 24,
                                elevation: 16,
                                hint: Text("Choose category."),
                                onChanged: (String newValue) {
                                  if (newValue.length >= 0)
                                    setState(() {
                                      _selectedCategory = newValue;
                                    });
                                },
                                items: [
                                  "Movies",
                                  "Entertainment",
                                  "Music",
                                  "News",
                                  "Politics",
                                  "Random"
                                ]
                                    .map((e) => DropdownMenuItem<String>(
                                          value: e,
                                          child: Text(e),
                                        ))
                                    .toList()),
                          ],
                        )),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Poll visibilty'),
                            DropdownButton<String>(
                                value: _selectedVisibility,
                                iconSize: 24,
                                elevation: 16,
                                hint: Text("Choose visibility"),
                                onChanged: (String newValue) {
                                  if (newValue.length >= 0)
                                    setState(() {
                                      _selectedVisibility = newValue;
                                    });
                                },
                                items: [
                                  "Private",
                                  "Public",
                                ]
                                    .map((e) => DropdownMenuItem<String>(
                                          value: e,
                                          child: Text(e),
                                        ))
                                    .toList())
                          ],
                        )),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                            ),
                            Text('Poll image'),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _selectedImage == null
                                    ? Text('Poll image not selected.')
                                    : Container(
                                        height: 300,
                                        child: Image.file(
                                          File(_selectedImage.path),
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                ElevatedButton(
                                  child: Text("Add Image"),
                                  onPressed: () async {
                                    XFile xfile =
                                        await fileHandler.getImageFromGallery();
                                    setState(() {
                                      _selectedImage = xfile;
                                    });
                                  },
                                )
                              ],
                            ),
                          ],
                        )),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    )
                  ],
                )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Center(
                  child: Container(
                    width: double.infinity,
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
              ),
            ],
          ),
        ));
  }
}
