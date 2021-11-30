import 'package:better_vote/controllers/BallotController.dart';
import 'package:better_vote/controllers/UserController.dart';
import 'package:better_vote/models/Poll.dart';
import 'package:better_vote/models/ballots/StarBallot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class STARForm extends StatefulWidget {
  final Poll poll;
  StarBallot ballot;
  STARForm(this.poll, {Key key}) : super(key: key);
  @override
  State<STARForm> createState() => _STARFormState();
}

class _STARFormState extends State<STARForm> {
  bool isBusy = false;
  @override
  void initState() {
    super.initState();
    widget.ballot = new StarBallot(widget.poll);
  }

  @override
  Widget build(BuildContext context) {
    //immutable
    final List<dynamic> choices = widget.poll.getChoices();

    voterBuilder(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.hasData) {
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
                itemBuilder: (BuildContext context, int choice) {
                  //debugPrint("this right here2");
                  return Container(
                    height: 50,
                    child: Row(children: [
                      Column(
                        children: [
                          Text("\t\t" +
                              choices[choice].toString() +
                              "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t"),
                        ],
                      ),
                      Column(children: [
                        Align(
                            alignment: Alignment.centerRight,
                            child: RatingBar.builder(
                              initialRating: 0,
                              itemSize: 20,
                              itemCount: 5,
                              // ignore: missing_return
                              itemBuilder: (context, index) {
                                switch (index) {
                                  case 0:
                                    return Icon(
                                      Icons.sentiment_very_dissatisfied,
                                      color: Colors.red,
                                    );
                                  case 1:
                                    return Icon(
                                      Icons.sentiment_dissatisfied,
                                      color: Colors.redAccent,
                                    );
                                  case 2:
                                    return Icon(
                                      Icons.sentiment_neutral,
                                      color: Colors.amber,
                                    );
                                  case 3:
                                    return Icon(
                                      Icons.sentiment_satisfied,
                                      color: Colors.lightGreen,
                                    );
                                  case 4:
                                    return Icon(
                                      Icons.sentiment_very_satisfied,
                                      color: Colors.green,
                                    );
                                }
                              },
                              onRatingUpdate: (rating) {
                                setState(() {
                                  widget.ballot.setVote(choice, rating.toInt());
                                });
                                print(widget.ballot.getVote());
                              },
                            ))
                      ])
                    ]),
                  );
                }),
            Align(
                alignment: Alignment.center,
                child: TextButton(
                    onPressed: () async {
                      //Validate ballot before next line
                      setState(() {
                        isBusy = true;
                      });
                      bool succesfulVote = await BallotController()
                          .attempToSubmitABallot(
                              widget.poll.getId(), widget.ballot.getVote());
                      // if(succesfulVote)
                      // showDialog(context: context, builder: builder);
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
        child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF00b764))),
      );
    }

    return FutureBuilder(
        future: UserController().findProfileData(), builder: voterBuilder);
  }
}

// ignore: must_be_immutable
// class STARDropdown extends StatefulWidget {
//   Function callback;
//   List<dynamic> scores;
//   String choice;
//   STARDropdown(this.choice, this.scores, this.callback);
//   @override
//   State<STARDropdown> createState() => STARDropdownState();
// }

// class STARDropdownState extends State<STARDropdown> {
//   STARDropdownState();
//   String _selectedScore;

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//         alignment: Alignment.center,
//         child: DropdownButton<String>(
//           hint: Text('-'), // Not necessary for Option 1
//           value: _selectedScore,
//           items: widget.scores
//               .map((score) => DropdownMenuItem<String>(
//                     value: score,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(score),
//                     ),
//                   ))
//               .toList(),

//           onChanged: (String newSelectedScore) {
//             setState(() {
//               _selectedScore = newSelectedScore;
//               print("Selected Value: $newSelectedScore");
//             });
//             int index = widget.scores.indexOf(_selectedScore);
//             print("index: $index");
//             //widget.callback(index);
//           },
//           //value: newValue,
//         ));
//   }
// }
