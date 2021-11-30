import 'dart:io';

import 'package:better_vote/controllers/PollController.dart';
import 'package:better_vote/models/Poll.dart';
import 'package:better_vote/network/FileHandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';

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
bool _isBusy = false;
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
            setState(() {
            _isBusy = false;
          });
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

    return LoadingOverlay(
      isLoading: _isBusy,
      child: Form(
          key: _formKey,
          child: Container(
            color: Colors.grey.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  //child: Text("Poll details"),
                ),
                Card(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          child: Text("Title", style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        TextField(
                            controller: _pollTitleController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF00b764), width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black38, width: 1.0),
                              ),
                              hintText: 'Enter title',
                            )),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          child: Text("Question", style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        TextField(
                          controller: _pollQuestionController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF00b764), width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38, width: 1.0),
                            ),
                            hintText: 'Enter question',
                          ),
                        ),
                        Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Voting System', style: TextStyle(fontWeight: FontWeight.bold)),
                                Row(children: [
                                    DropdownButton<String>(
                                      value: _selectedVoteSystem,
                                      iconSize: 24,
                                      elevation: 16,
                                      hint: Text("Select voting system"),
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
                                              )).toList()
                                    ),

                                    TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(25.0),
                            topRight: const Radius.circular(25.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: SingleChildScrollView(
                              child: Column(
                            children: [
                              Row(children: [
                                Text("Voting Systems",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ))
                              ]),
                              Divider(
                                color: Color(0xFF00b764),
                                height: 40,
                                thickness: 1,
                                indent: 1,
                                endIndent: 1
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text("RCV", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text("In ranked choice voting (also known as Instant Runoff Voting), voters rank each choice, starting at 1, counting upwards. If a choice is ranked as the first choice on more than half of ballots, then that choice wins. Otherwise, the choice that is ranked as the first choice on the fewest ballots is eliminated and their votes are redistributed to their voters’ second choices. The process of checking for a winner and eliminating the last place is repeated until a choice receives more than half of the votes."))
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text("STAR", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text("In STAR voting (Score Then Automatic Runoff), voters score each choice between zero and five. The scores are tallied and the choices with the two highest scores enter a runoff. In the runoff, a choice receives a single vote from each ballot where they scored higher than the other choice. The choice that receives the majority of votes in the runoff wins the poll."))
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text("Plurality", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text("In plurality voting (also known as first-past-the-post), each voter gets one vote, which they can give to any of the choices. The choice that receives the most votes wins the poll."))
                                ],
                              ),
                            ],
                          )),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Learn More",
                    style: TextStyle(fontSize: 12, color: Color(0xFF00b764)),
                  )),

                                  ]
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  //child: Text("Poll candidates"),
                ),
                Card(
                    child: Container(
                  child: Column(
                    children: [
                      Align(alignment: Alignment.centerLeft, child:
                        Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            child: Text("Choices", style: TextStyle(fontWeight: FontWeight.bold)),
                        )
                      ),
                      Container(
                        height: 70,
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
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF00b764), width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black38, width: 1.0),
                              ),
                              hintText: 'Choice name',
                              suffixIcon: Wrap(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {});
                                    },
                                    icon: Icon(Icons.image, color: Color(0xFF00b764),),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _candidateController.clear();
                                    },
                                    icon: Icon(Icons.clear, color: Color(0xFF00b764)),
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
                              child: Text("Add Choice"),
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
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF00b764)
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  //child: Text("Poll Dates."),
                ),
                Card(
                  child: Column(
                    children: [
                      Align(alignment: Alignment.centerLeft, child:
                        Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            child: Text("Timeframe", style: TextStyle(fontWeight: FontWeight.bold)),
                        )
                      ),
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
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  //child: Text('Other options.'),
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
                              Text('Category', style: TextStyle(fontWeight: FontWeight.bold)),
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
                              Text('Visibility', style: TextStyle(fontWeight: FontWeight.bold)),
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
                              Text('Image', style: TextStyle(fontWeight: FontWeight.bold)),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _selectedImage == null
                                      ? Text('Image not selected.')
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
                                    style: ElevatedButton.styleFrom(primary: Color(0xFF00b764))
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
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text("Submit Poll"),
                        style: ElevatedButton.styleFrom(primary: Color(0xFF00b764)),
                        onPressed: () {
                          setState(() {
                            _isBusy = true;
                            print("Poll submit");
    
                            ///MAKE SURE FIELDS ARE VALID BEFORE SUBMISSION, SHOW ERRORS.
                            // print(createPollData());
                          });
                            createNewPoll(getPollData());
    
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
