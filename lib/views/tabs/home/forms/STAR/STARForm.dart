import 'package:better_vote/controllers/UserController.dart';
import 'package:better_vote/models/Poll.dart';
import 'package:better_vote/models/User.dart';
import 'package:better_vote/models/ballots/StarBallot.dart';
import 'package:flutter/material.dart';

class STARForm extends StatefulWidget {
  final Poll poll;

  STARForm(this.poll, {Key key}) : super(key: key);
  @override
  State<STARForm> createState() => _STARFormState(this.poll);
}

class _STARFormState extends State<STARForm> {
  final Poll poll;

  _STARFormState(this.poll);
  // List<dynamic> _remainingChoices;
  List<dynamic> _scores = [];
  StarBallot ballot;
  @override
  void initState() {
    super.initState();
    final List<dynamic> choices = poll.getChoices();
    // _remainingChoices = choices;
    for (int i = 0; i < choices.length; i++) {
      _scores.add((i+1).toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    //immutable
    final List<dynamic> choices = poll.getChoices();

    voterBuilder(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.hasData) {
        User voter = snapshot.data;
        ballot = StarBallot(voter, poll);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "\t\tChoices\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tScore",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                itemCount: choices.length,
                itemBuilder: (BuildContext context, int score) {
                  //debugPrint("this right here2");
                  return Container(
                    height: 50,
                    child: 
                    Row(
                      children: [
                        //Column(
                          //children: [
                            Text(
                              "\t\t" +
                              choices[score].toString() +
                              "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t"
                            ),
                          //],
                        //),
                        Column(
                          children: [Align(alignment: Alignment.centerRight,child:
                            STARDropdown(
                              choices[score].toString(), 
                              _scores, 
                              (int selectedScore) {
                                setState(() {
                                  ballot.setVote(score, selectedScore);
                                  print("ballot: ${ballot.getVote()}");
                                  print("score $selectedScore");
                                  print("choice ${choices[score]}");
                                }
                              );
                              }
                            ))
                          ]
                        )
                      ]
                    ),
                  );
                }),
            Align(
                alignment: Alignment.center,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Submit Vote",
                      style: TextStyle(fontSize: 20, color: Color(0xFF00b764)),
                    )))
          ],
        );
      }
      if (snapshot.hasError) return Text("Voter info not found.");

      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return FutureBuilder(
        future: UserController().findProfileData(), builder: voterBuilder);
  }
}

// ignore: must_be_immutable
class STARDropdown extends StatefulWidget {
  Function callback;
  List<dynamic> scores;
  String choice;
  STARDropdown(this.choice, this.scores, this.callback);
  @override
  State<STARDropdown> createState() => STARDropdownState();
}

class STARDropdownState extends State<STARDropdown> {
  STARDropdownState();
  String _selectedScore;

  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.center, child: DropdownButton<String>(
      hint: Text('-'), // Not necessary for Option 1
      value: _selectedScore,
      items: widget.scores
          .map((score) => DropdownMenuItem<String>(
                value: score,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(score),
                ),
              ))
          .toList(),

      onChanged: (String newSelectedScore) {
        setState(() {
          _selectedScore = newSelectedScore;
          print("Selected Value: $newSelectedScore");
        });
        int index = widget.scores.indexOf(_selectedScore);
        print("index: $index");
        //widget.callback(index);
      },
      //value: newValue,
    ));
  }
}
