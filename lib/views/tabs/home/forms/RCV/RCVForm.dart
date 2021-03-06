import 'package:better_vote/controllers/BallotController.dart';
import 'package:better_vote/controllers/UserController.dart';
import 'package:better_vote/models/Poll.dart';
import 'package:better_vote/models/User.dart';
import 'package:better_vote/models/ballots/RcvBallot.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RCVForm extends StatefulWidget {
  final Poll poll;

  RCVForm(this.poll, {Key key}) : super(key: key);
  @override
  State<RCVForm> createState() => _RCVFormState(this.poll);
}

class _RCVFormState extends State<RCVForm> {
  final Poll poll;

  _RCVFormState(this.poll);
  // List<dynamic> _remainingChoices;
  List<int> _ranks = [];
  bool isBusy;
  RcvBallot ballot;
  @override
  void initState() {
    super.initState();
    final List<dynamic> choices = poll.getChoices();
    ballot = new RcvBallot(poll);

    // _remainingChoices = choices;
    for (int i = 0; i < choices.length; i++) {
      _ranks.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    //immutable
    final List<dynamic> choices = poll.getChoices();
    voterBuilder(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.hasData) {
        User voter = snapshot.data;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "\t\tRank\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tChoices",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                itemCount: _ranks.length,
                itemBuilder: (BuildContext context, int rank) {
                  //debugPrint("this right here2");
                  return Container(
                    height: 50,
                    child: Row(children: [
                      Text("\t\t\t\t\t" +
                          (rank + 1).toString() +
                          "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t"),
                      RCVDropdown(choices, rank, (int selectedChoice) {
                        setState(() {
                          // Validate choices first
                          ballot.setVote(selectedChoice, rank + 1);
                          print("ballot: ${ballot.getVote()}");
                          print("rank $rank");
                          print("choice ${choices[selectedChoice]}");
                        });
                      })
                    ]),
                  );
                }),
            Align(
                alignment: Alignment.center,
                child: TextButton(
                    onPressed: () async {
                      setState(() {
                        isBusy = true;
                      });
                      bool succesfulVote = await BallotController()
                          .attempToSubmitABallot(
                              widget.poll.getId(), ballot.getVote());

                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Container(
                                    child: Column(
                                  children: [
                                    Icon(FontAwesomeIcons.checkCircle),
                                    Text("Vote submitted!"),
                                  ],
                                )),
                                content: Container(
                                  height: 40,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Center(
                                            child:
                                                Text("Thank you for voting."),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ));
                    },
                    child: Text(
                      "Submit Vote",
                      style: TextStyle(fontSize: 20, color: Color(0xFF00b764)),
                    )))
          ],
        );
      }
      if (snapshot.hasError) return Text("Voter info not found.");

      return Center(
        child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF00b764))),
      );
    }

    return FutureBuilder(
        future: UserController().findProfileData(), builder: voterBuilder);
  }
}

// ignore: must_be_immutable
class RCVDropdown extends StatefulWidget {
  Function callback;
  int rank;
  List<dynamic> choices;
  RCVDropdown(this.choices, this.rank, this.callback);
  @override
  State<RCVDropdown> createState() => RCVDropdownState();
}

class RCVDropdownState extends State<RCVDropdown> {
  RCVDropdownState();
  String _selectedChoice;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text('Please choose an option'), // Not necessary for Option 1
      value: _selectedChoice,
      items: widget.choices
          .map((choice) => DropdownMenuItem<String>(
                value: choice,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(choice),
                ),
              ))
          .toList(),

      onChanged: (String newSelectedChoice) {
        setState(() {
          _selectedChoice = newSelectedChoice;
          print("Selected Value: $newSelectedChoice");
        });
        int index = widget.choices.indexOf(_selectedChoice);
        print("index: $index");
        widget.callback(index);
      },
      //value: newValue,
    );
  }
}
